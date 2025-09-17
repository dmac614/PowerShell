<#
    Aim: multiply the values of items within a hashtable by the value of the respective "Day" variable
#>
param(
    #[int]$SnackDays = 7,
    [int]$GymDays = 3,
    [int]$HighDays = 3,
    [int]$LowDays = 4 # $Snack * LowDays
)
#region All meals

    #region Small meals
    # Snack
        $Snack = [ordered]@{
            Egg = 2
            Feta = 20
        }

    # Pre-gym
        $PreGym = [ordered]@{
            Dates = 3
            Butter = 8
        }
    #endregion

    #region Low days
    # Meal 1
        $SmoothieLow = [ordered]@{
            "Yogurt 0%" = 400
            "Frozen Berries" = 100
            Banana = 1
        }
        $BeefEggsLow = [ordered]@{
            "Ground Beef" = 150
            Egg = 4
            Berries = 200
        }
        
    # Meal 2
        $BeefLow = @{
            "Ground Beef" = 200
            Feta = 30
            "Bell pepper" = 1
            Courgette = 0.5
            Passata = 125
        }

        $ChickenLow = [ordered]@{
            "Chicken thigh" = 250
            Feta = 30
            "Bell pepper" = 1
            Courgette = 0.5
            Passata = 125
        }
        
    # Meal 3
        $SteakLow = [ordered]@{
            Steak = 200
            Egg = 3
            Butter = 5
            "Bell pepper" = 1
            Courgette = 0.5
            Passata = 125
        }

        $SalmonLow = @{
            Salmon = 200
            "Avocado (small)" = 1
            "Bell pepper" = 1
            Courgette = 0.5
            Passata = 125
        }
    #endregion Low days

    #region High days
    # Meal 1
        $SmoothieHigh = [ordered]@{
            "Yogurt 0%" = 400
            "Frozen Berries" = 100
            Banana = 1
            Raisins = 20
        }

        $BeefEggsHigh = [ordered]@{
            "Ground Beef" = 100
            Egg = 4
            Berries = 200
            Apple = 1
        }

    # Meal 2
        $ChickenHigh = [ordered]@{
            "Chicken thigh" = 250
            Berries = 250
            Banana = 1
        }

        $BeefHigh = [ordered]@{
            "Ground Beef" = 200
            Berries = 250
            Banana = 1
        }

    # Meal 3
        $SteakHigh = [ordered]@{
            Steak = 200
            Potatoes = 350
            Kiwi = 2
        }

        $ChickenHigh = [ordered]@{
            "Chicken breast" = 200
            Sourdough = 125
            Jam = 50
            Ghee = 10
            Berries = 100
        }
    #endregion High days

#endregion All meals


#region combine meals
$AllLowMeals = @(
    "$BeefEggsLow","$BeefLow","$ChickenLow","$SteakLow","$SalmonLow"
)

$AllHighMeals = @(
    "$SmoothieHigh","$BeefEggsHigh","$ChickenHigh","$BeefHigh","$SteakHigh","$ChickenHigh"
)
#endregion




#region Create functions
    function CalculateSnack {
        "The following totals are for the weekly snack meals`n"
        $Snack.GetEnumerator().ForEach({
            "$($_.Key): $($_.Value * $SnackDays)"
        })
    }

    function CalculatePreGym {
        "The following totals are for the weekly pre-gym meals`n"
        $PreGym.GetEnumerator().ForEach({
            "$($_.Key): $($_.Value * $GymDays)"
        })
    }

    function FirstMeal_Low {
        param(
            # Choose which meal to have
            [ValidateSet("Smoothie","Beef and eggs")]$MealOption
        )
    }

    function SecondMeal_Low {
        param(
            # Choose which meal to have
            [ValidateSet("Chicken","Beef")]$MealOption
        )
    }

    function ThirdMeal_Low {
        param(
            # Choose which meal to have
            [ValidateSet("Steak","Salmon")]$MealOption
        )
    }
#endregion


#region Call functions
    CalculateSnack
    CalculatePreGym
#endregion




