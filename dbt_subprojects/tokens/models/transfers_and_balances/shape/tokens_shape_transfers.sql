{{config(
     schema = 'tokens_shape'
     , alias = 'transfers'
     , partition_by = ['block_month']
     , materialized = 'incremental'
     , file_format = 'delta'
     , incremental_strategy = 'merge'
     , unique_key = ['block_date','unique_key']
     , incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_date')]
     , post_hook='{{ expose_spells(blockchains = \'["shape"]\',
                                spell_type = "sector",
                                spell_name = "tokens",
                                contributors = \'["hosuke"]\') }}'
 )
}}

{{
     transfers_enrich(
         base_transfers = ref('tokens_shape_base_transfers')
         , tokens_erc20_model = source('tokens', 'erc20')
         , prices_model = source('prices', 'usd')
         , evms_info_model = source('evms','info')
         , transfers_start_date = '2024-07-23'
         , blockchain = 'shape'
     )
}}
