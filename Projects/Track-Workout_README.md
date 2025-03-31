# Workout Tracker

## Workout Template

The class is a template for each of the following workouts. 

1. Upper #1: Chest and Biceps
2. Legs and Delts
3. Upper #2: Back and Triceps

### Properties
- Exercise name
- Weight
- Reps
- Notes

### Methods
- AddSet()
- ModifyWeight()
- ModifyReps()
- AddExercise()
- RemoveExercise()


## Plan 

Rough idea -- this will be elaborated as time goes on

1. Get input about which workout was performed (date)? -- display the workouts
2. If workout X is selected, retrieve the data from the previous workout
3. Invoke methods to modify weight and reps
4. Write updated data to the new workout based on the date
5. Monitor progress: you have increased exercise X by X KG since (date)

- Create the WorkoutTemplate class
- Each object will represent an exercise and will be stored in a variable i.e $LyingLegCurl
- All objects in one workout will be stored in a variable i.e $Upper1
- Test the methods and properties
- Create functions: UpdateWorkout; ? 

Structure:
Workout Date | Exercise | Reps | Weight | Notes
