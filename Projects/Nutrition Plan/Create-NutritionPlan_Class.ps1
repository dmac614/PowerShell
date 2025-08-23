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
    [System.Collections.ArrayList]$FoodItems

    [string]$FoodName
    [int]$FoodQuantity
    
    [ValidateRange(0,2000)]
    [int]$FoodWeight
    
    [ValidateRange(0,3)]
    [int]$MealNumber # for child class
    
    [ValidateSet('A','B','C')]
    [string]$MealOption # for child class
    
    [bool]$Snack 
    hidden [int]$GymDays = 3

    [ValidateRange(1,7)]
    [int]$TimesPerWeek
    # Not to be used as a property
    # The items from a meal will be calculated against this property
    # e.g all items in meal 1 option A * TimesPerWeek

#endregion

#region Constructors

# FoodItems constructor
NutritionPlan() {
    $this.FoodItems = [System.Collections.ArrayList]::new()
}

# Meal 0 constructor  
NutritionPlan(
    [string]$FoodName, 
    [int]$FoodQuantity,
    [int]$FoodWeight,
    [bool]$Snack
    ) {
        $this.FoodName = $FoodName
        $this.FoodQuantity = $FoodQuantity
        $this.FoodWeight = $FoodWeight
        $this.Snack = $Snack
}

# Meal 1-3 constructor
NutritionPlan(
    [string]$FoodName,
    [int]$FoodWeight,
    [int]$FoodQuantity,
    [string]$MealOption
    ) {
        $this.FoodName = $FoodName
        $this.FoodWeight = $FoodWeight
        $this.FoodQuantity = $FoodQuantity
        $this.MealOption = $MealOption
}
#endregion


#region Methods
    [int]TotalWeight() {
        return $this.FoodWeight * $this.TimesPerWeek
    }

    [int]TotalQuantity() {
        return $this.FoodQuantity * $this.TimesPerWeek
    }

    [int]TotalSnack() {
        return $this.FoodQuantity * $this.GymDays 
    }

    [void]AddFoodItem(
        [string]$FoodName,
        [int]$FoodQuantity,
        [int]$FoodWeight,
        [string]$MealOption
    ) {
            $item = [PSCustomObject]@{
                Name = $FoodName
                Quantity = $FoodQuantity
                Weight = $FoodWeight
                Option = $MealOption 
            }

        $this.FoodItems.Add($item)
    }
        


<# 
   [int]CalculateSnack($MealNumber){
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

    #[NutritionPlan]AddMeal() {}

#endregion



} #end baseline class
#endregion Baseline Class



## Do separate .ps1 files for each child class ##

#region ShoppingList class

class ShoppingList : NutritionPlan {
    ShoppingList() : base($FoodName,$FoodQuantity,$FoodWeight) {

    }
}

#endregion