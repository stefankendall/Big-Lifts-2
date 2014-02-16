@class JWorkout;
@class FTOLiftWorkoutViewController;

@interface WorkoutSharer : NSObject
- (void)shareOnTwitter:(JWorkout *)workout withController:(UIViewController *)controller;

- (void)shareOnFacebook:(JWorkout *)workout withController:(UIViewController *)controller;

- (NSString *)workoutSummary:(JWorkout *)workout;
@end