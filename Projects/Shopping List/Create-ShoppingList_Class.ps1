class ShoppingList {

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

    [void]TotalQuantity() {
        $this.FoodQuantity * $this.TimesPerWeek
    }

    [void]TotalWeight() {
        $this.FoodWeight * $this.TimesPerWeek
    }

    # Test this
    [ShoppingList] AddFoodItem(
        [string]$FoodName,
        [int]$FoodQuantity,
        [int]$FoodWeight
    ) {
        $this.FoodName = [string](Read-Host "Name of the food item")
        return [ShoppingList]::new($FoodName,$FoodQuantity,$FoodWeight)
    }

    #[ShoppingList]AddMeal() {}

    #[ShoppingList]CreateMeal() {}

#endregion

#region Primary Constructor
# Constructor template
ShoppingList() {}

    ShoppingList(
        [string]$FoodName,
        [int]$FoodQuantity,
        [int]$FoodWeight
        ){
    }
#endregion



} #end class