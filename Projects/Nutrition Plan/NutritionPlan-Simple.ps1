<#
    Aim: multiply the values of items within a hashtable by the value of the respective "Day" variable

    Create a third function which combines the totals of items in low and high days to give me a final shopping list
    -- store the totals in an array so they can be retrieved
#>
param(
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
        $BeefLow = [ordered]@{
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

        $SalmonLow = [ordered]@{
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

        $ChickenSourdough = [ordered]@{
            "Chicken breast" = 200
            Sourdough = 125
            Jam = 50
            Ghee = 10
            Berries = 100
        }
    #endregion High days

#endregion All meals

#region Create functions
    function SmallMeals {
        
        "Weekly snack meals"
        $Snack.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $LowDays)" })

        "`nWeekly pre-gym meals"
        $PreGym.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $GymDays)" })

        "`n#########################`n"
    }


    ## Low meals ##
    function LowDay_Meals {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory)]
            [ValidateSet("Smoothie","Beef and eggs")]$MealOne,

            [Parameter(Mandatory)]
            [ValidateSet("Chicken","Beef")]$MealTwo,

            [Parameter(Mandatory)]
            [ValidateSet("Steak","Salmon")]$MealThree
        )

        "`nThe following totals are for 4 x low carb days`n"
        "Meal 1:"
            if ($MealOne -eq "Smoothie"){
                $SmoothieLow.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $LowDays)" })
            } 
            
            elseif ($MealOne -eq "Beef and eggs"){
                $BeefEggsLow.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $LowDays)" })
            } 
            
            else {
                Write-Error "Please choose a correct meal"
            }

            "`nMeal 2:"
            if ($MealTwo -eq "Chicken"){
                $ChickenLow.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $LowDays)" })
            } 
            
            elseif ($MealTwo -eq "Beef"){
                $BeefLow.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $LowDays)" })
            } 
            
            else {
                Write-Error "Please choose a correct meal"
            }

        "`nMeal 3:"
            if ($MealThree -eq "Steak"){
                $SteakLow.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $LowDays)" })
            } 
            
            elseif ($MealThree -eq "Salmon"){
                $SalmonLow.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $LowDays)" })
            } 
            
            else {
                Write-Error "Please choose a correct meal"
        }

            "`n#########################`n"
    }


    ## High meals ##
    function HighDay_Meals {
        [CmdletBinding()]
        param(
            # Choose which meal to have
            [Parameter(Mandatory)]
            [ValidateSet("Smoothie","Beef and eggs")]$MealOne,

            [Parameter(Mandatory)]
            [ValidateSet("Chicken","Beef")]$MealTwo,
            
            [Parameter(Mandatory)]
            [ValidateSet("Steak","Chicken")]$MealThree
        )

        "`nThe following totals are for 3 x high carb days`n"

        "Meal 1:"
            if ($MealOne -eq "Smoothie"){
                $SmoothieHigh.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $HighDays)" })
            } elseif ($MealOne -eq "Beef and eggs"){
                $BeefEggsHigh.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $HighDays)" })
            } else {
                Write-Error "Please choose a correct meal"
            }

        "`nMeal 2:"
            if ($MealTwo -eq "Chicken"){
                $ChickenHigh.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $HighDays)" })
            } elseif ($MealTwo -eq "Beef"){
                $BeefHigh.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $HighDays)" })
            } else {
                Write-Error "Please choose a correct meal"
            }

        "`nMeal 3:"
            if ($MealThree -eq "Steak"){
                $SteakHigh.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $HighDays)" })
            } elseif ($MealThree -eq "Chicken"){
                $ChickenSourdough.GetEnumerator().ForEach({ "$($_.Key): $($_.Value * $HighDays)" })
            } else {
                Write-Error "Please choose a correct meal"
            }
    
            "`n#########################`n"
        } #end function
#endregion


#region Call functions
    SmallMeals
    LowDay_Meals -MealOne Smoothie -MealTwo Beef -MealThree Salmon
    HighDay_Meals -MealOne Smoothie -MealTwo Beef -MealThree Chicken
#endregion




