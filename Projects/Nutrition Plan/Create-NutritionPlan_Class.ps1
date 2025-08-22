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
    
    [bool]$Snack 
    hidden [int]$GymDays = 3

    [ValidateRange(1,7)]
    hidden [int]$TimesPerWeek
    # Not to be used as a property
    # The items from a meal will be calculated against this property
    # e.g all items in meal 1 option A * TimesPerWeek

#endregion

#region Primary Constructor
<#
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
#>

# Default constructor
NutritionPlan(){}
#endregion

#region Child classes

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
        $this.$FoodName = $FoodName
        $this.$FoodWeight = $FoodWeight
        $this.$FoodQuantity = $FoodQuantity
        $this.$MealOption = $MealOption
}

# Constructor for the ShoppingList child class
NutritionPlan(
    [string]$FoodName,
    [string]$MealNumber,
    [string]$MealOption
    ) {
        $this.$FoodName = $FoodName
        $this.$MealNumber = $MealNumber
        $this.$MealOption = $MealOption
}

#endregion


#region Methods
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

    <#
    [NutritionPlan] Meal0(
        [string]$FoodName, 
        [int]$FoodQuantity,
        [bool]$Snack
        ) {
            return [NutritionPlan]::new($FoodName,$FoodQuantity,$Snack)
        }
    #>
        
    [int]CalculateSnack() {
        return $this.FoodQuantity * $this.GymDays 
    }
    
    # return $this.FoodWeight * $this.GymDays



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