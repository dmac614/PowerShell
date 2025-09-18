## This is for testing purposes ##

[NutritionPlan]::new
$NutritionPlan = [NutritionPlan]::new()
$NutritionPlan

$Chicken = [NutritionPlan]@{
    FoodName = 'Chicken breast'
    FoodWeight = 200
    MealNumber = 3
    MealOption = 'C'
}

$Dates = [NutritionPlan]@{
    FoodName = 'Medjool dates'
    FoodQuantity = 3
    Snack = $true
}

$Butter = [NutritionPlan]@{
    FoodName = 'Grass-fed butter'
    FoodWeight = 5
    Snack = $true
}

$Sausage = $NutritionPlan.AddFoodItem('Sausage',0,200,'A')
$LambLiver = $NutritionPlan.AddFoodItem('Lamb liver',0,150,'C')



$x = 3
$y = 250
$Times = 7

Return $x * $Times -or $y * $Times