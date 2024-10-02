proc import out=Nutrient datafile="C:\Users\bushr\OneDrive\Desktop\nndb_flat.csv"
dbms=csv replace; getnames=yes;
*Summary Table; 
proc sort data=Nutrient;
  by FoodGroup;
run;
proc means data=Nutrient; 
by  FoodGroup; 
where FoodGroup in ('Dairy and Egg Products', 'Poultry Products', 'Sweets');
var VitA_mcg VitB6_mg VitB12_mcg VitC_mg VitE_mg Folate_mcg Niacin_mg Riboflavin_mg Thiamin_mg Calcium_mg	
Copper_mcg	Iron_mg	Magnesium_mg Phosphorus_mg Selenium_mcg Zinc_mg;
run; 
*PCA; 
data Nutrient;
    set Nutrient;
VitA_mcg = log10(VitA_mcg);
VitB6_mg = log10(VitB6_mg);
VitB12_mcg = log10(VitB12_mcg);
VitC_mg = log10(VitC_mg);
VitE_mg = log10(VitE_mg);
Folate_mcg = log10(Folate_mcg);
Niacin_mg = log10(Niacin_mg);
Riboflavin_mg = log10(Riboflavin_mg);
Thiamin_mg = log10(Thiamin_mg);
Calcium_mg = log10(Calcium_mg);
Copper_mcg = log10(Copper_mcg);
Iron_mg = log10(Iron_mg);
Magnesium_mg = log10(Magnesium_mg);
Phosphorus_mg = log10(Phosphorus_mg);
Selenium_mcg = log10(Selenium_mcg);
Zinc_mg = log10(Zinc_mg);
run;
proc sort data=Nutrient;
  by FoodGroup; 
where FoodGroup in ('Dairy and Egg Products', 'Poultry Products', 'Sweets');
run;
title 'PCA on USDA National Nutrient Data';
proc princomp data=Nutrient cov out=n; 
by  FoodGroup; 
where FoodGroup in ('Dairy and Egg Products', 'Poultry Products', 'Sweets');
var VitA_mcg VitB6_mg VitB12_mcg VitC_mg VitE_mg Folate_mcg Niacin_mg Riboflavin_mg Thiamin_mg Calcium_mg	
Copper_mcg	Iron_mg	Magnesium_mg Phosphorus_mg Selenium_mcg Zinc_mg;
run; 

proc corr data=n noprob; 
by  FoodGroup; 
where FoodGroup in ('Dairy and Egg Products', 'Poultry Products', 'Sweets');
var prin1 prin2 prin3 VitA_mcg VitB6_mg VitB12_mcg VitC_mg VitE_mg Folate_mcg Niacin_mg Riboflavin_mg Thiamin_mg Calcium_mg	
Copper_mcg	Iron_mg	Magnesium_mg Phosphorus_mg Selenium_mcg Zinc_mg;
run; 
