#import "BoringButBigHelper.h"
#import "JWorkout.h"
#import "JLift.h"
#import "JFTOLift.h"
#import "JFTOBoringButBigLift.h"
#import "JFTOBoringButBigLiftStore.h"
#import "JFTOBoringButBigStore.h"
#import "JFTOBoringButBig.h"
#import "JFTOSet.h"
#import "JFTOSetStore.h"

@implementation BoringButBigHelper

+ (void)addSetsToWorkout:(JWorkout *)workout withLift:(JLift *)lift deload:(BOOL)deload {
    int sets = deload ? 3 : 5;
    [workout addSets:[self createBoringSets:sets forLift:(JFTOLift *) lift]];
}

+ (NSArray *)createBoringSets:(int)numberOfSets forLift:(JFTOLift *)mainLift {
    JFTOBoringButBigLift *bbbLift = [[JFTOBoringButBigLiftStore instance] find:@"mainLift" value:mainLift];

    NSMutableArray *sets = [@[] mutableCopy];
    NSDecimalNumber *percentage = [[[JFTOBoringButBigStore instance] first] percentage];
    for (int set = 0; set < numberOfSets; set++) {
        JFTOSet *ftoSet = [[JFTOSetStore instance] create];
        ftoSet.lift = bbbLift.boringLift;
        ftoSet.percentage = percentage;
        ftoSet.reps = @10;
        ftoSet.assistance = YES;
        [sets addObject:ftoSet];
    }
    return sets;
}

@end