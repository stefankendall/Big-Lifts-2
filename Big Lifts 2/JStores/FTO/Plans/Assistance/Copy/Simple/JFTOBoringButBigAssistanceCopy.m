#import "JFTOBoringButBigAssistanceCopy.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOBoringButBigAssistance.h"
#import "JWorkout.h"

@implementation JFTOBoringButBigAssistanceCopy

- (void)copyTemplate {
    JFTOBoringButBigAssistance *bbb = [JFTOBoringButBigAssistance new];
    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in [[JFTOCustomAssistanceWorkoutStore instance] findAll]) {
        [customAssistanceWorkout.workout addSets:[bbb createBoringSets:5 forLift:(JFTOLift *) customAssistanceWorkout.mainLift]];
    }
}

@end