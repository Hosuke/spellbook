{{
  config(
    schema = 'aave_lido_v3_ethereum',
    alias = 'base_flashloans',
    materialized = 'incremental',
    file_format = 'delta',
    incremental_strategy = 'merge',
    unique_key = ['tx_hash', 'evt_index'],
    incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
  )
}}

{{
  lending_aave_v3_compatible_flashloans(
    blockchain = 'ethereum',
    project = 'aave_lido',
    version = '3',
    decoded_contract_name = 'LidoPool'
  )
}}
