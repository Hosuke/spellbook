{{
  config(
    schema = 'gmx_v2_avalanche_c',
    alias = 'glvs_data',    
    materialized = 'view'
    )
}}

SELECT
    GCE.glv_token AS glv,
    CONCAT(ERC20_LT.symbol, '-', ERC20_ST.symbol) AS glv_name,
    'GLV' AS glv_token_symbol,
    18 AS glv_token_decimals,
    GCE.long_token,
    ERC20_LT.symbol AS long_token_symbol,
    ERC20_LT.decimals AS long_token_decimals,
    GCE.short_token,
    ERC20_ST.symbol AS short_token_symbol,
    ERC20_ST.decimals AS short_token_decimals  
FROM {{ ref('gmx_v2_avalanche_c_glv_created') }} AS GCE
LEFT JOIN {{ ref('gmx_v2_avalanche_c_erc20') }} AS ERC20_LT
    ON ERC20_LT.contract_address = GCE.long_token 
LEFT JOIN {{ ref('gmx_v2_avalanche_c_erc20') }} AS ERC20_ST
    ON ERC20_ST.contract_address = GCE.short_token