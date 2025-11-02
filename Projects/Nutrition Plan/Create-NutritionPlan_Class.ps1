<#
Child classes
    Class: shopping list i.e food items
    Class: meal 0 = snack
    Class: meals
#>

#region Baseline Class
class NutritionPlan {

#region Properties
    # Common shopping list items
    [System.Collections.Generic.List[System.Object]] $FoodItems

    [string] $FoodName
    [int] $FoodQuantity # 7 bananas
    
    [ValidateRange(0,2000)]
    [int] $FoodWeight # 150g steak mince
    
    [ValidateRange(0,6)]
    [int] $MealNumber # for child class
    
    [ValidateSet('A','B','C')]
    [string] $MealOption # for child class: probably wont use this
    
    [bool] $Snack 
    [int] $GymDays # gym days change between 2-3 days per week

    [ValidateRange(1,7)]
    [int] $TimesPerWeek
    # Not to be used as a property
    # The items from a meal will be calculated against this property
    # e.g all items in meal 1 option A * TimesPerWeek

#endregion

#region Constructors

# Blank constructor
NutritionPlan() 
{ }

<#
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
#>
    
# Primary constructor
# Meals + Fooditems 
NutritionPlan([string]$FoodName, [int]$FoodWeight, [int]$FoodQuantity) 
{
    $this.FoodName = $FoodName
    $this.FoodWeight = $FoodWeight
    $this.FoodQuantity = $FoodQuantity
}
#endregion 


#region Methods
    [int] TotalWeight() {
        return $this.FoodWeight * $this.TimesPerWeek
    }

    [int] TotalQuantity() {
        return $this.FoodQuantity * $this.TimesPerWeek
    }

    [int] TotalSnack() {
        return $this.FoodQuantity * $this.GymDays 
    }

    [System.Object] AddFoodItem([string]$FoodName, [int]$FoodQuantity, [int]$FoodWeight) 
    {
        <#
        $item = [PSCustomObject]@{
            Name = $this.FoodName
            Quantity = $this.FoodQuantity
            Weight = $this.FoodWeight
        }
        #>
        #return $item
        #return [NutritionPlan]::FoodItems

        return [NutritionPlan]::new()
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

    #[NutritionPlan]CreateMeal() {}

#endregion



} #end baseline class
#endregion Baseline Class



## Do separate .ps1 files for each child class ##

#region ShoppingList class

class ShoppingList : NutritionPlan {
    ShoppingList([string]$FoodName, [int]$FoodQuantity, [int]$FoodWeight) : base($FoodName,$FoodQuantity,$FoodWeight) {
        $this.FoodName
        $this.FoodQuantity
        $this.FoodWeight
    }
}
#endregion