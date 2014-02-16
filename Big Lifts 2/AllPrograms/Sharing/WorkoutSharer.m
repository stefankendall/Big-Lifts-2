#import <Social/Social.h>
#import "WorkoutSharer.h"
#import "JWorkout.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JSet.h"
#import "JLift.h"

@implementation WorkoutSharer

- (void)shareOnTwitter:(NSArray *)workouts withController:(UIViewController *)controller {
    SLComposeViewController *sheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [sheet setInitialText:[self workoutSummary:workouts]];
    [sheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/big-lifts-2/id661503150?mt=8"]];
    [controller presentViewController:sheet animated:YES completion:nil];
}

- (void)shareOnFacebook:(NSArray *)workouts withController:(UIViewController *)controller {
    SLComposeViewController *sheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString *summary = [self workoutSummary:workouts];
    [sheet setInitialText:summary];
    [sheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/big-lifts-2/id661503150?mt=8"]];
    [controller presentViewController:sheet animated:YES completion:nil];
}

- (NSString *)workoutSummary:(NSArray *)workouts {
    NSMutableString *summary = [@"My workout:\n" mutableCopy];
    NSString *units = [[[JSettingsStore instance] first] units];
    for (JWorkout *workout in workouts) {
        NSString *lastLiftName = nil;
        for (JSet *set in workout.sets) {
            NSString *liftName = [set.lift.name stringByAppendingString:@" "];
            if ([liftName isEqualToString:lastLiftName]) {
                liftName = @"";
            }
            else {
                lastLiftName = liftName;
            }
            [summary appendString:[NSString stringWithFormat:@"%@%@%@ %@%@\n",
                                                             liftName,
                                                             set.reps,
                                                             set.amrap ? @"+" : @"x",
                                                             [set roundedEffectiveWeight],
                                                             units]
            ];
        }
    }

    return summary;
}

@end