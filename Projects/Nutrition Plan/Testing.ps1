$NutritionPlan = [NutritionPlan]::new()


$NutritionPlan.foodItems.Add("Steak mince")
$NutritionPlan.FoodItems.add("Chicken thighs")

$NutritionPlan.FoodName = "Steak mince"
$NutritionPlan.FoodWeight = 150
$NutritionPlan.TimesPerWeek = 7
$NutritionPlan.TotalWeight()

$Banana = [nutritionplan]::new()

$Banana.FoodName = "Banana"
$Banana.FoodQuantity = 1
$Banana.TimesPerWeek = 7
$Banana.TotalQuantity()



Get-Variable Banana,NutritionPlan | Remove-Variable

Get-Variable NutritionPlan | Remove-Variable
