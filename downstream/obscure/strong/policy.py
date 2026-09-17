"""Explicit primary-variable and derived-variable contracts for strong masking.

Primary cells receive distinct secret-seeded perturbations; derivations never
carry a second copy of the original quantity or original quantitative ratio.
Category/source-quality fields retain their source interpretation.
"""
import re

VERSION = 'kolega-independent-cell-mask-v2'
COUNTS = ['workers', 'production_workers', 'rd_workers']
PERCENTAGES = ['export_share_pct', 'foreign_ownership_pct']
CATEGORY_EXCEPTIONS = {'energy_cost_reported_partial', 'energy_cost_reported_complete'}
IDENTITY = {'obs_id', 'source_row', 'firm_id', 'psid', 'psid_status', 'dataset_mode',
            'panel_id_synthetic', 'panel_key_available', 'dev_panel_stratum',
            'dev_prev_obs_id', 'dev_prev_year', 'dev_link_status'}
EXTRA = ['val_efuvcu', 'val_zpdvcu', 'val_zndvcu']


def contract(names):
    names = set(names)
    base = set('value_added_nominal intermediate_inputs_nominal capital_stock_nominal capital_additions_nominal import_value_nominal rd_cost_nominal val_rtlvcu val_znsvcu val_zpsvcu accounting_gap'.split())
    base |= {n for n in names if re.fullmatch(r'(fuel|elec)_.+_(rp000|kg|ltr|m3|mmbtu|kwh)', n)}
    base &= names
    # An ordered expression graph. Nonmissing masks from actual are retained.
    derived = {}

    def add(n, op, inputs, constants=None):
        if n in names:
            assert set(inputs) <= names, (n, inputs)
            derived[n] = {'op': op, 'inputs': inputs, 'constants': constants or []}

    add('gross_output_nominal', 'sum_strict', ['value_added_nominal', 'intermediate_inputs_nominal', 'accounting_gap'])
    add('va_signed_nominal', 'alias', ['value_added_nominal'])
    add('va_signed_tail_sensitivity', 'alias', ['va_signed_nominal'])
    fuels = 'diesel petrol kerosene coal lpg citygas othergas coalbriq coke'.split()
    units = 'ltr ltr ltr kg kg m3 m3 kg kg'.split()
    c1 = [.002654,.00231,.002494,.002496,.002876,.002695,.002695,.002877,.00284]
    c2 = [.002978,.002479,.002616,.002448,.003293,.00219,.00219,.002032,.002907]
    gj = [.035697,.033225,.034559,.0262,.045544,.048,.048,.029308,.026377]
    for f,u,a,b,c in zip(fuels, units,c1,c2,gj):
        for n,k in [(f'co2_{f}_s1',a),(f'co2_{f}_s2',b),(f'gj_{f}',c)]:
            add(n,'constant',[f'fuel_{f}_{u}'],[k])
    add('co2_scope1_s1','sum_nonnegative',[f'co2_{f}_s1' for f in fuels])
    add('co2_scope1_s2','sum_nonnegative',[f'co2_{f}_s2' for f in fuels])
    add('gj_fuel_s1','sum_nonnegative',[f'gj_{f}' for f in fuels])
    add('elec_purchased_kwh','sum_nonnegative',['elec_pln_kwh','elec_nonpln_kwh'])
    add('gj_electricity','constant',['elec_purchased_kwh'],[.0036])
    add('co2_scope2_s1','product',['elec_purchased_kwh','grid_factor_s1'])
    add('co2_scope2_s2','product',['elec_purchased_kwh','grid_factor_s2'])
    add('co2_total_s1','sum_strict',['co2_scope1_s1','co2_scope2_s1'])
    add('co2_total_s2','sum_strict',['co2_scope1_s2','co2_scope2_s2'])
    add('total_gj_s1','sum_strict',['gj_fuel_s1','gj_electricity'])
    for n,p in {'co2_scope1_complete':'co2_scope1_s1','co2_scope2_complete':'co2_scope2_s1',
                'total_gj_complete':'total_gj_s1','gj_scope1_complete9':'gj_fuel_s1',
                'gj_scope2_complete':'gj_electricity','co2_scope2_no_grid_carry':'co2_scope2_complete',
                'total_gj_clean_sensitivity':'total_gj_s1'}.items():
        add(n,'alias',[p])
    add('co2_total_complete','sum_strict',['co2_scope1_complete','co2_scope2_complete'])
    add('co2_variant_static_grid','sum_strict',['co2_scope1_s1','co2_scope2_s2'])
    for n,p,k in [('gj_firewood_reference','fuel_firewood_kg',.0156),('gj_charcoal_reference','fuel_charcoal_kg',.0295),('gj_lubricant_potential','fuel_lubricant_ltr',.03538)]:
        add(n,'constant',[p],[k])
    costfuels = 'diesel petrol kerosene coal lpg citygas othergas coalbriq coke firewood charcoal dieseloil fueloil lubricant other'.split()
    add('fuel_components_rp000','sum_nonnegative',[f'fuel_{f}_rp000' for f in costfuels])
    add('fuel_components_extended','sum_nonnegative',['fuel_components_rp000','fuel_biodiesel_rp000','fuel_natgas_rp000'])
    add('fuel_expenditure_rp000','fallback',['fuel_total_reported_rp000','fuel_components_extended'])
    add('fuel_reconciliation_gap','difference',['fuel_total_reported_rp000','fuel_components_rp000'])
    add('fuel_reconciliation_gap_extended','difference',['fuel_total_reported_rp000','fuel_components_extended'])
    add('electricity_expenditure_rp000','sum_nonnegative',['elec_pln_rp000','elec_nonpln_rp000'])
    add('energy_expenditure_rp000','sum_strict',['fuel_expenditure_rp000','electricity_expenditure_rp000'])
    add('energy_exp_observed_repaired','sum_source_valid',['fuel_total_reported_rp000','elec_pln_rp000','elec_nonpln_rp000'])
    for n in ['gj_fuel_s1','elec_purchased_kwh','gj_electricity','co2_scope1_s1','co2_scope2_s1','total_gj_s1','co2_total_s1']:
        add('r_'+n,'alias',[n])
    ratios = {
        'va_share_output_repaired':['value_added_nominal','gross_output_nominal'],
        'ei_money_output_repaired':['energy_exp_observed_repaired','gross_output_nominal'],
        'ei_gj_output_repaired':['total_gj_s1','gross_output_nominal'],
        'ci_co2_output_repaired':['co2_total_s1','gross_output_nominal'],
        'va_signed_per_worker':['va_signed_nominal','workers'],
    }
    pw = {'labor_productivity_nominal':'value_added_nominal','output_per_worker_nominal':'gross_output_nominal',
          'inputs_per_worker_nominal':'intermediate_inputs_nominal','rd_cost_per_worker_nominal':'rd_cost_nominal',
          'energy_cost_per_worker':'energy_expenditure_rp000','total_gj_per_worker':'total_gj_s1',
          'co2_per_worker':'co2_total_s1','capital_stock_per_worker':'capital_stock_nominal',
          'capital_additions_per_worker':'capital_additions_nominal'}
    ratios.update({'r_'+n:[p,'workers'] for n,p in pw.items()})
    ratios.update({'gross_output_real':['gross_output_nominal','deflator_output'],
                   'value_added_real':['value_added_nominal','deflator_output'],
                   'capital_real':['capital_stock_nominal','deflator_capital'],
                   'intermediate_inputs_real':['intermediate_inputs_nominal','deflator_inputs']})
    for n,args in ratios.items():add(n,'ratio',args)
    logs = {'output_nominal':'gross_output_nominal','va_nominal':'value_added_nominal',
            'inputs_nominal':'intermediate_inputs_nominal','workers':'workers','total_gj_s1':'total_gj_s1',
            'co2_total_s1':'co2_total_s1','energy_expenditure':'energy_expenditure_rp000',
            'import_nominal':'import_value_nominal','rd_cost_nominal':'rd_cost_nominal',
            'capital_stock_nominal':'capital_stock_nominal','capital_additions_nominal':'capital_additions_nominal'}
    for n,p in logs.items():add('r_ln_'+n,'log',[p])
    add('va_log_positive','log',['va_signed_nominal'])
    # Broad physical/cost suffixes also match named totals; their explicit
    # formula contract takes precedence over primitive-field detection.
    base -= set(derived)
    return sorted(base),derived
