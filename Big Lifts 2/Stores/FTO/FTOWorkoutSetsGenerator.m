#import "FTOWorkoutSetsGenerator.h"
#import "SetData.h"

@implementation FTOWorkoutSetsGenerator

- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift {
    NSArray *week1Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift],
            [SetData dataWithReps:5 percentage:N(50) lift:lift],
            [SetData dataWithReps:3 percentage:N(60) lift:lift],
            [SetData dataWithReps:5 percentage:N(65) lift:lift],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:5 percentage:N(85) lift:lift]
    ];

    NSArray *week2Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift],
            [SetData dataWithReps:5 percentage:N(50) lift:lift],
            [SetData dataWithReps:3 percentage:N(60) lift:lift],
            [SetData dataWithReps:3 percentage:N(70) lift:lift],
            [SetData dataWithReps:3 percentage:N(80) lift:lift],
            [SetData dataWithReps:3 percentage:N(90) lift:lift]
    ];

    NSArray *week3Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift],
            [SetData dataWithReps:5 percentage:N(50) lift:lift],
            [SetData dataWithReps:3 percentage:N(60) lift:lift],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:3 percentage:N(85) lift:lift],
            [SetData dataWithReps:1 percentage:N(95) lift:lift]
    ];

    NSArray *week4Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift],
            [SetData dataWithReps:5 percentage:N(50) lift:lift],
            [SetData dataWithReps:5 percentage:N(60) lift:lift],
            [SetData dataWithReps:5 percentage:N(60) lift:lift],
            [SetData dataWithReps:5 percentage:N(60) lift:lift],
            [SetData dataWithReps:5 percentage:N(60) lift:lift]
    ];

    NSDictionary *fresherTemplate = @{
            @1 : week1Lifts,
            @2 : week2Lifts,
            @3 : week3Lifts,
            @4 : week4Lifts
    };
    return fresherTemplate[[NSNumber numberWithInt:week]];
}

@end