# Variations in Hospital Charge in USA and Factors explaining those Variations 

With an aim to understand what explains variations in hospital charge for similar or same procedure, Medicare outpatient data
is combined with hospital information data obtained from CMS web and visualized the charge data by state and by procedures
and mapped by range of charge. Compared distribution of charge for different procedure types. The comparison shows inter state
and intra state level variations in hospital charge. Complex and expensive procedures have more variations than simple or less 
expensive procedures. 

Estimated the model using different Statistical models mainly Lasso Regression using sklearn machine learning tool and 
OLS linear regression.The goal of the prediction model is to see if there are county level health, social and economic
factors explaining variations in average charge in USA counties.  The result indicates that counties with more % of uninsured
population , % of over 65   and % of African-American had higher hospital charge. In contrary, counties with more % of rural communities 
had lower hospital charges in 2016. However, the model explains only 1/3 of variations in the hospital charge. This may imply hospital charge is 
more about market power of hospitals and other factors.  Including Cost to Charge ratio  in the prediction  would be a good 
move to test effect of market power of hospitals.

