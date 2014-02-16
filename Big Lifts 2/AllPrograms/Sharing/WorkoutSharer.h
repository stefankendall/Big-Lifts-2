@class JWorkout;
@class FTOLiftWorkoutViewController;

@interface WorkoutSharer : NSObject
- (void)shareOnTwitter:(JWorkout *)workout withController:(FTOLiftWorkoutViewController *)controller;

- (void)shareOnFacebook:(JWorkout *)workout withController:(FTOLiftWorkoutViewController *)controller;

- (NSString *)workoutSummary:(JWorkout *)workout;
@end