@class JWorkout;
@class FTOLiftWorkoutViewController;

@interface WorkoutSharer : NSObject
- (void)shareOnTwitter:(NSArray *)workouts withController:(UIViewController *)controller;

- (void)shareOnFacebook:(NSArray *)workouts withController:(UIViewController *)controller;

- (NSString *)workoutSummary:(NSArray *)workouts;
@end