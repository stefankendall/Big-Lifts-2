#import "JSVWorkoutStore.h"
#import "JSVWorkout.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JSet.h"
#import "JLift.h"
#import "JSVLiftStore.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "JSVLift.h"

@implementation JSVWorkoutStore

- (Class)modelClass {
    return JSVWorkout.class;
}

- (void)setDefaultsForObject:(id)object {
    JSVWorkout *svWorkout = object;
    svWorkout.workout = [[JWorkoutStore instance] create];
}

- (JSVWorkout *)createWithDay:(int)day week:(int)week cycle:(int)cycle {
    JSVWorkout *jsvWorkout = [self create];
    jsvWorkout.day = [NSNumber numberWithInt:day];
    jsvWorkout.week = [NSNumber numberWithInt:week];
    jsvWorkout.cycle = [NSNumber numberWithInt:cycle];
    return jsvWorkout;
}

- (void)setupDefaults {
    [self createIntro];
    [self createBaseMesoCycle];
    [self createSwitchingCycle];
    [self createIntenseCycle];
    [self createTaperCycle];
}

- (void)createIntro {
    JSVLift *primaryLift = [[JSVLiftStore instance] find:@"name" value:@"Squat"];
    JSVLift *lunges = [[JSVLiftStore instance] find:@"name" value:@"Lunges"];
    JSVLift *bulgarianLunges = [[JSVLiftStore instance] find:@"name" value:@"Bulgarian Lunges"];
    JSVWorkout *day1 = [self createWithDay:1 week:1 cycle:1];
    [self addSets:3 withReps:8 atPercentage:N(65) forWorkout:day1 withLift:primaryLift];
    [self addSets:1 withReps:5 atPercentage:N(70) forWorkout:day1 withLift:primaryLift];
    [self addSets:2 withReps:2 atPercentage:N(75) forWorkout:day1 withLift:primaryLift];
    [self addSets:1 withReps:1 atPercentage:N(80) forWorkout:day1 withLift:primaryLift];

    JSVWorkout *day2 = [self createWithDay:2 week:1 cycle:1];
    [self addSets:3 withReps:8 atPercentage:N(65) forWorkout:day2 withLift:primaryLift];
    [self addSets:1 withReps:5 atPercentage:N(70) forWorkout:day2 withLift:primaryLift];
    [self addSets:2 withReps:2 atPercentage:N(75) forWorkout:day2 withLift:primaryLift];
    [self addSets:1 withReps:1 atPercentage:N(80) forWorkout:day2 withLift:primaryLift];

    JSVWorkout *day3 = [self createWithDay:3 week:1 cycle:1];
    [self addSets:4 withReps:5 atPercentage:N(70) forWorkout:day3 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(75) forWorkout:day3 withLift:primaryLift];
    [self addSets:2 withReps:2 atPercentage:N(80) forWorkout:day3 withLift:primaryLift];
    [self addSets:1 withReps:1 atPercentage:N(90) forWorkout:day3 withLift:primaryLift];

    JSVWorkout *day4 = [self createWithDay:4 week:1 cycle:1];
    [self addSets:3 withReps:8 atPercentage:N(100) forWorkout:day4 withLift:lunges];

    JSVWorkout *day5 = [self createWithDay:5 week:1 cycle:1];
    [self addSets:3 withReps:8 atPercentage:N(100) forWorkout:day5 withLift:bulgarianLunges];

    JSVWorkout *day6 = [self createWithDay:6 week:1 cycle:1];
    [self addSets:3 withReps:8 atPercentage:N(100) forWorkout:day6 withLift:lunges];

    JSVWorkout *day1week2 = [self createWithDay:1 week:2 cycle:1];
    [self addSets:2 withReps:2 atPercentage:N(85) forWorkout:day1week2 withLift:primaryLift];

    JSVWorkout *day2week2 = [self createWithDay:2 week:2 cycle:1];
    [self addSets:1 withReps:3 atPercentage:N(85) forWorkout:day2week2 withLift:primaryLift];

    JSVWorkout *day3week2 = [self createWithDay:3 week:2 cycle:1];
    [self addSets:1 withReps:5 atPercentage:N(85) forWorkout:day3week2 withLift:primaryLift];
}

- (void)createBaseMesoCycle {
    JLift *primaryLift = [[JSVLiftStore instance] find:@"name" value:@"Squat"];
    JSVWorkout *day1week1 = [self createWithDay:1 week:1 cycle:2];
    [self addSets:4 withReps:9 atPercentage:N(70) forWorkout:day1week1 withLift:primaryLift];

    JSVWorkout *day2week1 = [self createWithDay:2 week:1 cycle:2];
    [self addSets:5 withReps:7 atPercentage:N(75) forWorkout:day2week1 withLift:primaryLift];

    JSVWorkout *day3week1 = [self createWithDay:3 week:1 cycle:2];
    [self addSets:7 withReps:5 atPercentage:N(80) forWorkout:day3week1 withLift:primaryLift];

    JSVWorkout *day4week1 = [self createWithDay:4 week:1 cycle:2];
    [self addSets:10 withReps:3 atPercentage:N(85) forWorkout:day4week1 withLift:primaryLift];

    JSVWorkout *day1week2 = [self createWithDay:1 week:2 cycle:2];
    [self addSets:4 withReps:9 atPercentage:N(70) forWorkout:day1week2 withLift:primaryLift];
    day1week2.weightAdd = [self incrementInLbsOrKg:N(20)];

    JSVWorkout *day2week2 = [self createWithDay:2 week:2 cycle:2];
    [self addSets:5 withReps:7 atPercentage:N(75) forWorkout:day2week2 withLift:primaryLift];
    day2week2.weightAdd = [self incrementInLbsOrKg:N(20)];

    JSVWorkout *day3week2 = [self createWithDay:3 week:2 cycle:2];
    [self addSets:7 withReps:5 atPercentage:N(80) forWorkout:day3week2 withLift:primaryLift];
    day3week2.weightAdd = [self incrementInLbsOrKg:N(20)];

    JSVWorkout *day4week2 = [self createWithDay:4 week:2 cycle:2];
    [self addSets:10 withReps:3 atPercentage:N(85) forWorkout:day4week2 withLift:primaryLift];
    day4week2.weightAdd = [self incrementInLbsOrKg:N(20)];

    JSVWorkout *day1week3 = [self createWithDay:1 week:3 cycle:2];
    [self addSets:4 withReps:9 atPercentage:N(70) forWorkout:day1week3 withLift:primaryLift];
    day1week3.weightAdd = [self incrementInLbsOrKg:N(30)];

    JSVWorkout *day2week3 = [self createWithDay:2 week:3 cycle:2];
    [self addSets:5 withReps:7 atPercentage:N(75) forWorkout:day2week3 withLift:primaryLift];
    day2week3.weightAdd = [self incrementInLbsOrKg:N(30)];

    JSVWorkout *day3week3 = [self createWithDay:3 week:3 cycle:2];
    [self addSets:7 withReps:5 atPercentage:N(80) forWorkout:day3week3 withLift:primaryLift];
    day3week3.weightAdd = [self incrementInLbsOrKg:N(30)];

    JSVWorkout *day4week3 = [self createWithDay:4 week:3 cycle:2];
    [self addSets:10 withReps:3 atPercentage:N(85) forWorkout:day4week3 withLift:primaryLift];
    day4week3.weightAdd = [self incrementInLbsOrKg:N(30)];

    JSVWorkout *week4 = [self createWithDay:1 week:4 cycle:2];
    week4.testMax = YES;
}

- (NSDecimalNumber *)incrementInLbsOrKg:(NSDecimalNumber *)number {
    if ([[[[JSettingsStore instance] first] units] isEqualToString:@"lbs"]) {
        return number;
    }
    else {
        return [number decimalNumberByDividingBy:N(2.2) withBehavior:
                [NSDecimalNumberHandler
                        decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                       scale:0
                                            raiseOnExactness:NO
                                             raiseOnOverflow:NO
                                            raiseOnUnderflow:NO
                                         raiseOnDivideByZero:NO]];
    }
}

- (void)createSwitchingCycle {
    JLift *negativeSquat = [[JSVLiftStore instance] find:@"name" value:@"Squat Negative"];
    JLift *powerClean = [[JSVLiftStore instance] find:@"name" value:@"Power Clean"];
    JLift *boxSquat = [[JSVLiftStore instance] find:@"name" value:@"Box Squat"];

    JSVWorkout *day1week1 = [self createWithDay:1 week:1 cycle:3];
    [self addSets:1 withReps:1 atPercentage:N(100) forWorkout:day1week1 withLift:negativeSquat];
    day1week1.weightAdd = [self incrementInLbsOrKg:N(10)];

    JSVWorkout *day2week1 = [self createWithDay:2 week:1 cycle:3];
    [self addSets:8 withReps:3 atPercentage:N(60) forWorkout:day2week1 withLift:powerClean];

    JSVWorkout *day3week1 = [self createWithDay:3 week:1 cycle:3];
    [self addSets:12 withReps:2 atPercentage:N(70) forWorkout:day3week1 withLift:boxSquat];

    JSVWorkout *day1week2 = [self createWithDay:1 week:2 cycle:3];
    [self addSets:1 withReps:1 atPercentage:N(100) forWorkout:day1week2 withLift:negativeSquat];
    day1week2.weightAdd = [self incrementInLbsOrKg:N(20)];

    JSVWorkout *day2week2 = [self createWithDay:2 week:2 cycle:3];
    [self addSets:8 withReps:3 atPercentage:N(60) forWorkout:day2week2 withLift:powerClean];

    JSVWorkout *day3week2 = [self createWithDay:3 week:2 cycle:3];
    [self addSets:12 withReps:2 atPercentage:N(75) forWorkout:day3week2 withLift:boxSquat];
}

- (void)createIntenseCycle {
    JLift *primaryLift = [[JSVLiftStore instance] find:@"name" value:@"Squat"];

    JSVWorkout *day1week1 = [self createWithDay:1 week:1 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(65) forWorkout:day1week1 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(75) forWorkout:day1week1 withLift:primaryLift];
    [self addSets:3 withReps:4 atPercentage:N(85) forWorkout:day1week1 withLift:primaryLift];
    [self addSets:1 withReps:5 atPercentage:N(85) forWorkout:day1week1 withLift:primaryLift];

    JSVWorkout *day2week1 = [self createWithDay:2 week:1 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(60) forWorkout:day2week1 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(70) forWorkout:day2week1 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(80) forWorkout:day2week1 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(90) forWorkout:day2week1 withLift:primaryLift];
    [self addSets:2 withReps:5 atPercentage:N(85) forWorkout:day2week1 withLift:primaryLift];

    JSVWorkout *day3week1 = [self createWithDay:3 week:1 cycle:4];
    [self addSets:1 withReps:4 atPercentage:N(65) forWorkout:day3week1 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(70) forWorkout:day3week1 withLift:primaryLift];
    [self addSets:5 withReps:4 atPercentage:N(80) forWorkout:day3week1 withLift:primaryLift];

    JSVWorkout *day1week2 = [self createWithDay:1 week:2 cycle:4];
    [self addSets:1 withReps:4 atPercentage:N(60) forWorkout:day1week2 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(70) forWorkout:day1week2 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(80) forWorkout:day1week2 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(90) forWorkout:day1week2 withLift:primaryLift];
    [self addSets:2 withReps:4 atPercentage:N(90) forWorkout:day1week2 withLift:primaryLift];

    JSVWorkout *day2week2 = [self createWithDay:2 week:2 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(65) forWorkout:day2week2 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(75) forWorkout:day2week2 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(85) forWorkout:day2week2 withLift:primaryLift];
    [self addSets:3 withReps:3 atPercentage:N(90) forWorkout:day2week2 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(95) forWorkout:day2week2 withLift:primaryLift];

    JSVWorkout *day3week2 = [self createWithDay:3 week:2 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(65) forWorkout:day3week2 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(75) forWorkout:day3week2 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(85) forWorkout:day3week2 withLift:primaryLift];
    [self addSets:4 withReps:5 atPercentage:N(90) forWorkout:day3week2 withLift:primaryLift];

    JSVWorkout *day1week3 = [self createWithDay:1 week:3 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(60) forWorkout:day1week3 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(70) forWorkout:day1week3 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(80) forWorkout:day1week3 withLift:primaryLift];
    [self addSets:5 withReps:5 atPercentage:N(90) forWorkout:day1week3 withLift:primaryLift];

    JSVWorkout *day2week3 = [self createWithDay:2 week:3 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(60) forWorkout:day2week3 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(70) forWorkout:day2week3 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(80) forWorkout:day2week3 withLift:primaryLift];
    [self addSets:2 withReps:3 atPercentage:N(95) forWorkout:day2week3 withLift:primaryLift];

    JSVWorkout *day3week3 = [self createWithDay:3 week:3 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(65) forWorkout:day3week3 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(75) forWorkout:day3week3 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(85) forWorkout:day3week3 withLift:primaryLift];
    [self addSets:4 withReps:3 atPercentage:N(95) forWorkout:day3week3 withLift:primaryLift];

    JSVWorkout *day1week4 = [self createWithDay:1 week:4 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(70) forWorkout:day1week4 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(80) forWorkout:day1week4 withLift:primaryLift];
    [self addSets:5 withReps:5 atPercentage:N(90) forWorkout:day1week4 withLift:primaryLift];

    JSVWorkout *day2week4 = [self createWithDay:2 week:4 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(70) forWorkout:day2week4 withLift:primaryLift];
    [self addSets:1 withReps:3 atPercentage:N(80) forWorkout:day2week4 withLift:primaryLift];
    [self addSets:4 withReps:3 atPercentage:N(95) forWorkout:day2week4 withLift:primaryLift];

    JSVWorkout *day3week4 = [self createWithDay:3 week:4 cycle:4];
    [self addSets:1 withReps:3 atPercentage:N(75) forWorkout:day3week4 withLift:primaryLift];
    [self addSets:1 withReps:4 atPercentage:N(90) forWorkout:day3week4 withLift:primaryLift];
    [self addSets:3 withReps:4 atPercentage:N(95) forWorkout:day3week4 withLift:primaryLift];
}

- (void)createTaperCycle {
    JLift *primaryLift = [[JSVLiftStore instance] find:@"name" value:@"Squat"];
    JSVWorkout *day1week1 = [self createWithDay:1 week:1 cycle:5];
    [self addSets:1 withReps:4 atPercentage:N(75) forWorkout:day1week1 withLift:primaryLift];
    [self addSets:4 withReps:4 atPercentage:N(85) forWorkout:day1week1 withLift:primaryLift];

    JSVWorkout *day2week1 = [self createWithDay:2 week:1 cycle:5];
    day2week1.testMax = YES;
}

- (void)addSets:(int)sets withReps:(int)reps atPercentage:(NSDecimalNumber *)percentage forWorkout:(JSVWorkout *)workout withLift:(JLift *)lift {
    for (int i = 0; i < sets; i++) {
        JSet *set = [[JSetStore instance] create];
        set.reps = [NSNumber numberWithInt:reps];
        set.percentage = percentage;
        set.lift = lift;
        [workout.workout addSet:set];
    }
}

- (void)adjustForKg {
    if ([self count] > 0) {
        [self removeAll];
        [self setupDefaults];
    }
}

@end