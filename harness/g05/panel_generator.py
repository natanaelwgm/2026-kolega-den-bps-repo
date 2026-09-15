"""Reproducible fictional panel: hard province/sector blocks, nine continuous fields.

This is a development-data generator, not an entity-resolution estimator. Annual
clusters describe similar records; only one-to-one links create a persistent psid.
All ordering uses the frozen obs_id, never a mutable spreadsheet row position.
"""
from __future__ import annotations

import hashlib
import math

import numpy as np
import pandas as pd
from scipy.cluster.hierarchy import cut_tree, linkage
from scipy.optimize import linear_sum_assignment

VERSION = 'g05-external-excel-panel-v3'
STATUS = 'synthetic_development'
SEED = 20260913
# Each family has equal total weight. Correlated output/VA/input and energy
# breakdowns therefore do not get extra votes merely by having more columns.
FEATURES = {
    'workers': ('employment', 'Total workers', 'ltlnou'),
    'gross_output_nominal': ('scale', 'Gross output', 'output'),
    'value_added_nominal': ('scale', 'Reported value added', 'vtlvcu'),
    'intermediate_inputs_nominal': ('scale', 'Intermediate inputs', 'iinput'),
    'val_rtlvcu': ('materials', 'Raw materials used', 'rtlvcu'),
    'val_efuvcu': ('energy', 'Reported fuel/lubricant expenditure', 'efuvcu'),
    'elec_pln_kwh': ('energy', 'Purchased PLN electricity, kWh', 'eplkhu'),
    'val_zpdvcu': ('payroll', 'Production payroll field ZPDVCU (source proxy)', 'zpdvcu'),
    'val_zndvcu': ('payroll', 'Nonproduction payroll field ZNDVCU (source proxy)', 'zndvcu'),
}
LINK_COLUMNS = ['dev_cluster_id', 'dev_panel_stratum', 'dev_prev_obs_id',
               'dev_prev_year', 'dev_link_distance', 'dev_link_status', 'dev_n_features']
RANK_COLUMNS = dict(zip(FEATURES, ['dev_rank_workers','dev_rank_output','dev_rank_va','dev_rank_inputs',
                                 'dev_rank_material','dev_rank_fuel','dev_rank_electricity',
                                 'dev_rank_pay_prod','dev_rank_pay_nonprod']))
NEW_COLUMNS = LINK_COLUMNS + ['dev_identity_key', *RANK_COLUMNS.values()]
INPUT_COLUMNS = ['obs_id', 'source_year', 'province_code', 'industry_code', *FEATURES]


def weights():
    families = [f[0] for f in FEATURES.values()]
    return np.array([1 / (len(set(families)) * families.count(f)) for f in families])


def strata(frame):
    """Use literal 2-digit provinces and 5-digit manufacturing industry codes.

    Four-digit malformed codes are not padded into an invented industry. No
    boundary/KBLI concordance is asserted; invalid codes get isolated new IDs.
    """
    p = frame.province_code.astype('string').str.strip()
    s = frame.industry_code.astype('string').str.strip()
    valid = (p.str.fullmatch(r'[1-9][0-9]').fillna(False)
             & s.str.fullmatch(r'[1-3][0-9]{4}').fillna(False)
             & pd.to_numeric(s.str[:2], errors='coerce').between(10, 33))
    return (p + ':' + s.str[:2]).where(valid, ''), valid


def normalise(frame):
    """Within-year/sector mid-ranks, [0,1]; zeros observed, missing stays missing.

    Ranks remove unit/nominal-scale dominance without inventing a price deflator.
    They intentionally discard aggregate sector growth for development matching.
    A feature constant within a wave-sector receives .5. Pair distances need at
    least six observed features; missing values are never filled with zero.
    """
    raw = frame[list(FEATURES)].apply(pd.to_numeric, errors='coerce')
    raw = raw.where(np.isfinite(raw) & raw.ge(0))
    out = raw.copy()
    sector = frame.industry_code.astype('string').str[:2]
    for _, index in frame.groupby([frame.source_year, sector], sort=True).groups.items():
        sample = raw.loc[index]
        count = sample.count()
        ranked = (sample.rank(method='average') - 1).div((count - 1).replace(0, np.nan))
        for col in sample:
            if sample[col].nunique() <= 1:
                ranked[col] = sample[col].where(sample[col].isna(), .5)
        out.loc[index] = ranked
    return raw, out


def distances(left, right, weight, min_shared=6):
    observed = np.isfinite(left[:, None, :]) & np.isfinite(right[None, :, :])
    difference = np.where(observed, left[:, None, :] - right[None, :, :], 0.)
    denom = (observed * weight).sum(axis=2)
    result = np.sqrt((difference ** 2 * weight).sum(axis=2) / np.maximum(denom, 1e-12))
    result[observed.sum(axis=2) < min_shared] = np.inf
    return result


def choose_pairs(distance, cost, caliper):
    """Optional one-to-one assignment, including unmatched choices on both sides.

    A rectangular solver alone would force min(n,m) matches. The augmented
    matrix charges caliper/2 for either unmatched endpoint; forbidden distances
    cannot be selected, including when a small block has only one candidate.
    """
    n, m = distance.shape
    if not n or not m:
        return []
    costs = np.full((n + m, m + n), 1e6)
    allowed = np.isfinite(distance) & (distance <= caliper)
    costs[:n, :m] = np.where(allowed, cost, 1e6)
    costs[np.arange(n), m + np.arange(n)] = caliper / 2
    costs[n + np.arange(m), np.arange(m)] = caliper / 2
    costs[n:, m:] = 0.
    rows, cols = linear_sum_assignment(costs)
    return [(int(i), int(j)) for i, j in zip(rows, cols) if i < n and j < m and allowed[i, j]]


def new_psid(obs_id, seed):
    # 48-bit positive integer: exact in pandas/Arrow and Stata double. The
    # observation is a synthetic birth anchor, never an asserted source firm.
    digest = hashlib.sha256(f'{VERSION}:{seed}:{obs_id}'.encode()).digest()
    return 1 + int.from_bytes(digest[:6], 'big')


def generate(frame, *, seed=SEED, caliper=.25, cluster_weight=.20, progress=None, rank_inputs=None):
    if not 0 < caliper <= 1 or not 0 <= cluster_weight <= 1:
        raise ValueError('Invalid matching parameters')
    if frame.obs_id.isna().any() or not frame.obs_id.is_unique:
        raise ValueError('Frozen observation IDs must be unique and nonmissing')
    if frame.source_year.isna().any() or not frame.source_year.eq(frame.source_year.astype(int)).all():
        raise ValueError('Calendar years must be observed integers')
    source_order = frame.obs_id.tolist()
    frame = frame.sort_values(['source_year', 'obs_id']).reset_index(drop=True)
    raw, ranks = normalise(frame)
    if rank_inputs is not None:
        if not rank_inputs.index.is_unique or set(rank_inputs.index) != set(frame.obs_id):
            raise ValueError('Frozen rank inputs must cover the exact observation key set')
        ranks = rank_inputs.loc[frame.obs_id, list(FEATURES)].reset_index(drop=True).astype(float)
        finite = ranks.to_numpy()[np.isfinite(ranks.to_numpy())]
        if (finite < 0).any() or (finite > 1).any() or not ranks.notna().equals(raw.notna()):
            raise ValueError('Frozen ranks must lie in [0,1] and preserve feature availability')
    block, valid = strata(frame)
    usable = valid & raw.notna().sum(axis=1).ge(6)
    weight = weights()
    matrix = ranks.to_numpy(dtype=float)
    result = frame[['obs_id', 'source_year']].copy()
    result['psid'] = np.nan
    result['psid_status'] = STATUS
    result['dev_panel_stratum'] = block
    result['dev_cluster_id'] = ''
    result['dev_prev_obs_id'] = ''
    result['dev_prev_year'] = np.nan
    result['dev_link_distance'] = np.nan
    result['dev_link_status'] = np.where(valid, 'new_in_simulation', 'invalid_code_new_id')
    result.loc[valid & ~usable, 'dev_link_status'] = 'insufficient_features_new_id'
    result['dev_n_features'] = raw.notna().sum(axis=1).astype(float)
    # Mutable arrays avoid rebuilding an Arrow string column for each accepted
    # link. This preserves the assignment rule and bounds the full-data runtime.
    mutable = ['psid','dev_cluster_id','dev_prev_obs_id','dev_prev_year','dev_link_distance','dev_link_status']
    values = {col: result[col].to_numpy(copy=True) for col in mutable}
    observation_ids = result.obs_id.to_numpy()
    centroids = np.full_like(matrix, np.nan)
    cluster_counts = []
    # Labels are wave-specific. They need not agree across years and are never
    # used as a company ID or an additional compulsory matching boundary.
    for (year, key), index in frame.loc[usable].groupby([frame.source_year, block], sort=True).groups.items():
        index = np.array(sorted(index))
        data = matrix[index]
        filled = np.where(np.isfinite(data), data, .5)  # clustering only
        k = min(8, max(1, math.ceil(math.sqrt(len(index) / 8))))
        labels = (cut_tree(linkage(filled * np.sqrt(weight), method='ward'), n_clusters=k).ravel()
                  if len(index) > 1 else np.array([0]))
        # Canonical labels based on centroid coordinates, not SciPy tree labels.
        centers = {label: filled[labels == label].mean(axis=0) for label in set(labels)}
        labels_order = sorted(centers, key=lambda label: (*centers[label], int(label)))
        for serial, label in enumerate(labels_order, 1):
            members = index[labels == label]
            values['dev_cluster_id'][members] = f'C{int(year)}_{key.replace(":", "_")}_{serial:02d}'
            centroids[members] = centers[label]
        cluster_counts.append({'year': int(year), 'stratum': key, 'rows': len(index), 'clusters': len(centers)})
    years = sorted(frame.source_year.astype(int).unique())
    transitions, seen_psids = [], set()
    rng = np.random.default_rng(seed)
    for wi, year in enumerate(years):
        current = frame.index[frame.source_year.eq(year)]
        if wi:
            prior = years[wi - 1]
            left_groups = frame.loc[usable & frame.source_year.eq(prior)].groupby(block).groups
            right_groups = frame.loc[usable & frame.source_year.eq(year)].groupby(block).groups
            matched, capacity = 0, 0
            all_distances = []
            for key in sorted(set(left_groups) & set(right_groups)):
                left, right = np.array(sorted(left_groups[key])), np.array(sorted(right_groups[key]))
                capacity += min(len(left), len(right))
                distance = distances(matrix[left], matrix[right], weight)
                center_distance = distances(centroids[left], centroids[right], weight)
                cost = ((1 - cluster_weight) * distance + cluster_weight * center_distance)
                # Only a tiny seeded tie-break, not random matches across blocks.
                cost += rng.uniform(0, 1e-10, size=cost.shape)
                for i, j in choose_pairs(distance, cost, caliper):
                    a, b = left[i], right[j]
                    values['psid'][b] = values['psid'][a]
                    values['dev_prev_obs_id'][b] = observation_ids[a]
                    values['dev_prev_year'][b] = float(prior)
                    values['dev_link_distance'][b] = float(distance[i, j])
                    values['dev_link_status'][b] = 'matched_simulation'
                    all_distances.append(float(distance[i, j]))
                    matched += 1
            transitions.append({'from_year': int(prior), 'to_year': int(year), 'calendar_gap': int(year - prior),
                                'capacity_before_distance': capacity, 'matched': matched,
                                'unmatched_previous': int(frame.source_year.eq(prior).sum()) - matched,
                                'new_current': len(current) - matched,
                                'median_rank_distance': float(np.median(all_distances)) if all_distances else None,
                                'max_rank_distance': max(all_distances, default=None)})
        for idx in current[np.isnan(values['psid'][current])]:
            ident = new_psid(observation_ids[idx], seed)
            if ident in seen_psids:
                raise ValueError('Synthetic firm ID collision; explicit new namespace required')
            seen_psids.add(ident)
            values['psid'][idx] = float(ident)
        if progress:
            progress({'year': int(year), 'rows': len(current), 'cumulative_synthetic_firms': len(seen_psids)})
    for col in mutable:
        result[col] = values[col]
    result['dev_identity_key'] = result.obs_id
    for feature, col in RANK_COLUMNS.items():
        result[col] = ranks[feature].to_numpy()
    assert result.psid.notna().all() and not result.duplicated(['psid', 'source_year']).any()
    assert result.groupby('psid').dev_panel_stratum.nunique().le(1).all()
    sizes = result.groupby('psid').size()
    report = {'status': 'PASS', 'version': VERSION, 'rows': len(result), 'synthetic_firms': len(sizes),
              'firms_multiple_waves': int(sizes.ge(2).sum()), 'firms_single_wave': int(sizes.eq(1).sum()),
              'matched_links': int(result.dev_prev_obs_id.ne('').sum()),
              'invalid_code_rows': int((~valid).sum()), 'insufficient_feature_rows': int((valid & ~usable).sum()),
              'firm_wave_duplicates': 0, 'cross_stratum_links': 0, 'real_links_verified': 0,
              'parameters': {'seed': seed, 'caliper': caliper, 'cluster_weight': cluster_weight,
                             'min_shared_features': 6, 'ranking': 'midrank_within_year_sector',
                             'cluster_method': 'Ward; k=min(8,ceil(sqrt(n/8)))',
                             'matching': 'optional one-to-one minimum-cost; adjacent available waves'},
              'features': [{'name': n, 'family': family, 'label': label, 'excel_stem': stem, 'weight': float(w)}
                           for (n, (family, label, stem)), w in zip(FEATURES.items(), weight)],
              'feature_coverage': [{'year': int(y), 'feature': col, 'rows': len(group),
                                    'finite_nonnegative': int(raw.loc[group.index, col].notna().sum())}
                                   for y, group in frame.groupby('source_year') for col in FEATURES],
              'transitions': transitions,
              'cluster_counts_by_year': (pd.DataFrame(cluster_counts).groupby('year').clusters.sum().to_dict() if cluster_counts else {}),
              'firm_wave_count_distribution': sizes.value_counts().sort_index().to_dict(),
              'inference_scope': 'Fictional development continuity; not recovered actual company identity.',
              'downstream_estimation_executed': False}
    return result.set_index('obs_id').loc[source_order].reset_index(), report
