# Workout Tracker

## Workout Template

The class is a template for each of the following workouts. 

1. Full body (1): Hamstrings; incline chest; back thickness 
2. Full body (2): Quads; inner chest; back width
3. Arms: Triceps; biceps; Front delt; side delt; rear delt

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
- All objects in one workout will be stored in a variable i.e $FullBody1
- Test the methods and properties
- Create functions: UpdateWorkout; ? 

Structure:
Workout Date | Exercise | Reps | Weight | Notes
