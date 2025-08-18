<#
Child classes
    Class: shopping list i.e food items
    Class: meal 0 = snack
    Class: meal 1
    Class: meal 2
    Class: meal 3
#>

#region Baseline Class
class NutritionPlan {

#region Properties
    # The properties of this class
    [string]$FoodName
    [int]$FoodQuantity
    
    [ValidateRange(0,2000)]
    [int]$FoodWeight
    
    [ValidateRange(0,3)]
    [int]$MealNumber # for child class
    
    [ValidateSet('A','B','C')]
    [string]$MealOption # for child class
    
    [ValidateRange(1,7)]
    [int]$TimesPerWeek

    [bool]$Snack 
    #[int]$Snack = 0 # Meal 0 should be fixed as a pre training snack    
    hidden [int]$GymDays = 3

#endregion

#region Primary Constructor
NutritionPlan(
    [string]$FoodName,
    [int]$FoodQuantity,
    [int]$FoodWeight,
    [bool]$Snack,
    [int]$MealNumber,
    [string]$MealOption,
    [int]$TimesPerWeek
    ){
        $this.FoodName = $FoodName
        $this.FoodQuantity = $FoodQuantity
        $this.FoodWeight = $FoodWeight
        $this.Snack = $Snack
        $this.MealNumber = $MealNumber
        $this.MealOption = $MealOption
        $this.TimesPerWeek = $TimesPerWeek
}

# Default constructor
NutritionPlan(){}
#endregion

#region Child classes
# Constructor for the ShoppingList child class
#NutritionPlan(){}

# Constructor for pre-training snacks
NutritionPlan([string]$FoodName, [int]$FoodQuantity, [bool]$Snack) {
    $this.FoodName = $FoodName
    $this.FoodQuantity = $FoodQuantity
    $this.Snack = $Snack
}

#endregion


#region Methods
#[int]IsSnack($FoodQuantity) {
    #return $this.FoodQuantity * $this.GymDays
#}

#return $this.FoodWeight * $this.GymDays

<#
   [int]IsSnack($MealNumber){
    #if ($this.MealNumber = 0) {
        $this.MealNumber = 0
            return $this.FoodQuantity * $this.GymDays
            return $this.FoodWeight * $this.GymDays
        #} else {
            # Specify that it's not a snack
            # I'm thinking of a property which says true or false
            #    Write-Output "This is not a snack"
        #}   
    }
#>

    [int]TotalQuantity() {
        return $this.FoodQuantity * $this.TimesPerWeek
    }

    [int]TotalWeight() {
        return $this.FoodWeight * $this.TimesPerWeek
    }

    [NutritionPlan] AddFoodItem(
        [string]$FoodName,
        [int]$FoodQuantity,
        [int]$FoodWeight
    ) {
        $this.FoodName = [string](Read-Host "Name of the food item")
        return [NutritionPlan]::new($this.FoodName,$FoodQuantity,$FoodWeight)
    }

    #[NutritionPlan]AddMeal() {}

    #[NutritionPlan]CreateMeal() {}

#endregion



} #end baseline class
#endregion Baseline Class


#region ShoppingList class

class ShoppingList : NutritionPlan {
    ShoppingList() : base($FoodName,$FoodQuantity,$FoodWeight) {

    }
}

#endregion