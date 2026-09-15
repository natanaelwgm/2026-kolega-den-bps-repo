"""Explicit field rules for G0.5 development perturbation (not anonymisation).

One bounded positive factor per record scales monetary/physical levels together.
Homogeneous sums and differences therefore scale together; dimensionless ratios,
prices and categorical/count fields keep their original meaning. Logs shift by
log(factor). Unclassified fields are preserved and disclosed, never guessed.
"""
from __future__ import annotations

import re

VERSION = 'g05-coherent-level-jitter-v1'
MIN_CHANGE = 0.001
MAX_CHANGE = 0.005

STRUCTURE = re.compile(
    r'(^st_|^vs_|^qs_|^qn_|_state$|_status$|_flag$|_eligible$|_observed$|'
    r'_verified$|_valid$|_ready$|_code$|_contract$|_basis$|_reason$|'
    r'_n$|_n_observed$|_nfuels_|_ncomponents|_count$|_binary$|_pct$|_share$|'
    r'^source_|^identity_|^dummy_|^demo_|^native_|^panel_|^classification_|'
    r'^deflator_|^wpi_|^grid_factor|^factor_|^p99_|^cq\d|^cr\d|^n_|'
    r'^any_|^all_|^outlier_rule$|^g0_schema_version$|^analysis_contract$|'
    r'^rd17_|^cleaning_|_threshold$)'
)
COUNTS = {
    'workers', 'production_workers', 'rd_workers', 'out_workers',
    'source_id_multiplicity', 'nine_tunnels_working', 'electricity_cost_n_observed',
}
RATIOS = {
    'value_added_share_of_output', 'energy_intensity_monetary',
    'energy_intensity_gj_nominal', 'co2_intensity_nominal',
    'energy_productivity_real', 'carbon_productivity_real',
    'energy_intensity_real', 'carbon_intensity_real',
    'ei_gj_va_real', 'ci_co2_va_real', 'ei_cost_va_nominal',
    'monetary_energy_intensity', 'monetary_energy_productivity',
    'own_generation_share', 'own_generation_share_reported',
}
LEVELS = {
    'accounting_gap', 'fuel_components_extended', 'fuel_reconciliation_gap',
    'fuel_reconciliation_gap_extended', 'fuel_components_rp000',
    'fuel_expenditure_rp000', 'electricity_expenditure_rp000',
    'energy_expenditure_rp000', 'labor_productivity_nominal',
    'energy_cost_per_worker', 'total_gj_per_worker', 'co2_per_worker',
    'capital_stock_per_worker', 'capital_additions_per_worker',
    'legacy_total_gj_s1', 'legacy_co2_total_s1',
    'energy_exp_observed_repaired', 'energy_cost_reported_partial',
    'energy_cost_reported_complete',
}


def classify(name: str, storage: str = '') -> dict:
    """Return an auditable rule; recursive aliases share the same dimensional rule."""
    def result(action, reason):
        return {'action': action, 'reason': reason}

    if name.startswith('raw_'):
        base = re.sub(r'(10|11|12|13|14|15|17|18|19|20|21|22)$', '', name[4:])
        if re.search(r'v(?:cu|ce|do|fo)$', base) or base in {'output', 'iinput', 'v1115'}:
            return result('scale', 'raw monetary value code; same record factor as derived levels')
        if re.search(r'(?:liu|lis|khu|khs|kwh|m3u|m3s|kgu|kgs|mmbtu)$', base):
            return result('scale', 'raw physical quantity code; same record factor as derived levels')
        return result('preserve', 'raw category/count/unclassified source field; no semantic guessing')
    if STRUCTURE.search(name):
        return result('preserve', 'structural/category/status/reference field')
    if name in COUNTS or name.endswith('_workers'):
        return result('preserve', 'integer people/count structure is retained')
    if name.startswith('r_'):
        child = classify(name[2:], storage)
        return result(child['action'], 'recomputed companion: ' + child['reason'])
    if name.startswith('ln_'):
        base = name[3:]
        aliases = {'output_nominal': 'gross_output_nominal', 'va_nominal': 'value_added_nominal',
                   'inputs_nominal': 'intermediate_inputs_nominal', 'energy_expenditure': 'energy_expenditure_rp000',
                   'import_nominal': 'import_value_nominal'}
        child = classify(aliases.get(base, base), storage)
        return result('log_shift' if child['action'] == 'scale' else 'preserve', 'log companion: ' + child['reason'])
    if name.startswith('pw_'):
        child = classify(name[3:], storage)
        return result(child['action'], 'per-worker companion with unchanged worker denominator: ' + child['reason'])
    if name.startswith(('cl_', 'clean_', 'out_')):
        prefix, child_name = name.split('_', 1)
        child = classify(child_name, storage)
        return result(child['action'], prefix + ' companion: ' + child['reason'])
    if name.startswith('val_'):
        if name == 'val_costrd':
            return result('preserve', 'COSTRD is an R&D response code, not expenditure')
        return result('scale', 'mapped monetary value family')
    if name in RATIOS or name.startswith('price_') or 'share' in name:
        return result('preserve', 'dimensionless level/level ratio or price; common factor cancels')
    if name in LEVELS or name.endswith(('_nominal', '_real', '_rp000', '_per_worker')):
        return result('scale', 'monetary/physical level or level per unchanged worker denominator')
    if name.startswith(('fuel_', 'elec_')) and name.endswith(('_kg', '_ltr', '_m3', '_mmbtu', '_kwh')):
        return result('scale', 'physical fuel/electricity quantity')
    if name.startswith(('gj_', 'co2_')) or name.startswith('total_gj'):
        if any(s in name for s in ['intensity', 'productivity', 'factor', 'scope1_n', 'coverage']):
            return result('preserve', 'energy/emission ratio, factor or coverage metadata')
        return result('scale', 'energy/emission level')
    return result('preserve', 'unclassified field retained and disclosed; no guessed transformation')
