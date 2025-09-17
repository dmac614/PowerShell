<#
    Aim: multiply the values of items within a hashtable by the value of the respective "Day" variable
#>
param(
    [int]$GymDays = 3,
    [int]$HighDays = 3,
    [int]$LowDays = 4
)

    # Snack + pre-gym
    $Snack = @{
        Egg = 2
        Feta = 20
        Dates = 3
        Butter = 8
    }

    # Snack (array)
    $snack1 = @(
        "Egg","Feta","Dates","Butter"
    )

    function CalculateSnack {
        $Snack * $GymDays
    }

    CalculateSnack





    # # Meal 1
    #     $MealOne = @{
    #         "Yogurt 0%" = 400
    #         "Frozen Berries" = 100
    #         Banana = 1
    #     }

    # # Meal 2
    #     $MealTwo = @{
    #         "Ground Beef" = 200
    #         Feta = 30
    #         "Bell pepper" = 1
    #         Courgette = 0.5
    #         Passata = 125
    #     }

    # # Meal 3
    #     $MealThree = @{
    #         Salmon = 200
    #         "Avocado (small)" = 1
    #         "Bell pepper" = 1
    #         Courgette = 0.5
    #         Passata = 125
    #     }