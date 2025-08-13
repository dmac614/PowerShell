<#

Child classes

    Class: shopping list i.e food items
    Class: meal 1
    Class: meal 2
    Class: meal 3

#>

class NutritionPlan {

    # The properties of this class
    [ValidateSet('A','B','C')][string]$MealOption
    [ValidateRange(1,3)][int]$MealNumber
    [ValidateRange(1,7)][int]$TimesPerWeek

    [string]$FoodName
    [int]$FoodQuantity
    [ValidateRange(1,2000)][int]$FoodWeight


#region Methods
    [void]IsSnack() {
        #[bool]$true
    }

    [int]TotalQuantity() {
        return $this.FoodQuantity * $this.TimesPerWeek
    }

    [int]TotalWeight() {
        return $this.FoodWeight * $this.TimesPerWeek
    }

    # Test this
    [NutritionPlan] AddFoodItem(
        [string]$FoodName,
        [int]$FoodQuantity,
        [int]$FoodWeight
    ) {
        $this.FoodName = [string](Read-Host "Name of the food item")
        return [NutritionPlan]::new($FoodName,$FoodQuantity,$FoodWeight)
    }

    #[NutritionPlan]AddMeal() {}

    #[NutritionPlan]CreateMeal() {}

#endregion

#region Primary Constructor
# Constructor template
NutritionPlan() {}

    NutritionPlan(
        [string]$FoodName,
        [int]$FoodQuantity,
        [int]$FoodWeight
        ){
            $this.FoodName = $FoodName
            $this.FoodQuantity = $FoodQuantity
            $this.FoodWeight = $FoodWeight
    }
#endregion



} #end class