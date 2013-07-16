#import "FTOWorkoutSetsGenerator.h"
#import "SetData.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"

@implementation FTOWorkoutSetsGenerator

- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift {
    FTOVariant *variant = [[FTOVariantStore instance] first];

    NSDictionary *template = @{};
    if ([variant.name isEqualToString:@"Standard"]) {
        template = [self standard:lift];
    }
    else if ([variant.name isEqualToString:@"Pyramid"]) {
        template = [self pyramid:lift];
    }

    return template[[NSNumber numberWithInt:week]];
}

- (NSDictionary *)standard:(FTOLift *)lift {
    NSArray *week1Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:5 percentage:N(65) lift:lift],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:5 percentage:N(85) lift:lift amrap:YES]
    ];

    NSArray *week2Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:3 percentage:N(70) lift:lift],
            [SetData dataWithReps:3 percentage:N(80) lift:lift],
            [SetData dataWithReps:3 percentage:N(90) lift:lift amrap:YES]
    ];

    NSArray *week3Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:3 percentage:N(85) lift:lift],
            [SetData dataWithReps:1 percentage:N(95) lift:lift amrap:YES]
    ];

    NSArray *week4Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap: NO warmup: YES],
            [SetData dataWithReps:5 percentage:N(60) lift:lift amrap: NO warmup: YES],
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
    return fresherTemplate;
}

- (NSDictionary *)pyramid:(FTOLift *)lift {
    NSDictionary *pyramidSets = @{
            @1: @[
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(65) lift:lift amrap: YES]
            ],
            @2: @[
                    [SetData dataWithReps:3 percentage:N(80) lift:lift],
                    [SetData dataWithReps:3 percentage:N(70) lift:lift amrap: YES]
            ],
            @3: @[
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift amrap: YES]
            ]
    };

    NSMutableDictionary *setsByWeek = [[self standard:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:pyramidSets[week]];
    }
    return setsByWeek;
}

@end