#import "FTOWorkoutSetsGenerator.h"
#import "SetData.h"
#import "FTOVariant.h"
#import "FTOVariantStore.h"

@implementation FTOWorkoutSetsGenerator

- (NSArray *)setsForWeek:(int)week lift:(FTOLift *)lift {
    return [self setsFor:lift][[NSNumber numberWithInt:week]];
}

- (NSDictionary *)setsFor:(FTOLift *)lift {
    FTOVariant *variant = [[FTOVariantStore instance] first];

    NSDictionary *template = @{};
    if ([variant.name isEqualToString:FTO_VARIANT_STANDARD]) {
        template = [self standard:lift];
    }
    else if ([variant.name isEqualToString:FTO_VARIANT_PYRAMID]) {
        template = [self pyramid:lift];
    }
    else if ([variant.name isEqualToString:FTO_VARIANT_JOKER]) {
        template = [self joker:lift];
    }
    else if ([variant.name isEqualToString:FTO_VARIANT_SIX_WEEK]) {
        template = [self sixWeek:lift];
    }

    return template;
}

- (NSDictionary *)standard:(FTOLift *)lift {
    NSArray *week1Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(65) lift:lift],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:5 percentage:N(85) lift:lift amrap:YES]
    ];

    NSArray *week2Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(70) lift:lift],
            [SetData dataWithReps:3 percentage:N(80) lift:lift],
            [SetData dataWithReps:3 percentage:N(90) lift:lift amrap:YES]
    ];

    NSArray *week3Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:3 percentage:N(85) lift:lift],
            [SetData dataWithReps:1 percentage:N(95) lift:lift amrap:YES]
    ];

    NSArray *week4Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(60) lift:lift amrap:NO warmup:YES],
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
            @1 : @[
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(65) lift:lift amrap:YES]
            ],
            @2 : @[
                    [SetData dataWithReps:3 percentage:N(80) lift:lift],
                    [SetData dataWithReps:3 percentage:N(70) lift:lift amrap:YES]
            ],
            @3 : @[
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift amrap:YES]
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

- (NSDictionary *)joker:(FTOLift *)lift {
    NSDictionary *jokerSets = @{
            @1 : @[
                    [SetData dataWithReps:5 percentage:N(95) lift:lift],
                    [SetData dataWithReps:5 percentage:N(105) lift:lift],
                    [SetData dataWithReps:2 percentage:N(110) lift:lift]
            ],
            @2 : @[
                    [SetData dataWithReps:3 percentage:N(100) lift:lift],
                    [SetData dataWithReps:3 percentage:N(105) lift:lift],
                    [SetData dataWithReps:1 percentage:N(115) lift:lift]
            ],
            @3 : @[
                    [SetData dataWithReps:1 percentage:N(105) lift:lift],
                    [SetData dataWithReps:1 percentage:N(115) lift:lift],
                    [SetData dataWithReps:1 percentage:N(120) lift:lift]
            ]
    };

    NSMutableDictionary *setsByWeek = [[self standard:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:jokerSets[week]];
    }
    return setsByWeek;
}

- (NSDictionary *)sixWeek:(FTOLift *)lift {
    NSMutableDictionary *setsByWeek = [[self standard:lift] mutableCopy];
    [setsByWeek removeObjectForKey:@4];

    NSDictionary *secondHalf = [self standard:lift];
    for (int i = 4; i <= 7; i++) {
        setsByWeek[[NSNumber numberWithInt:i]] = secondHalf[[NSNumber numberWithInt:(i - 3)]];
    }

    return setsByWeek;
}

@end