#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOBoringButBigLiftStore.h"
#import "JFTOBoringButBigLift.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"

@implementation JFTOBoringButBigLiftStore

- (Class)modelClass {
    return JFTOBoringButBigLift.class;
}

- (void)setupDefaults {
    [[[JFTOLiftStore instance] findAll] each:^(JFTOLift *ftoLift) {
        JFTOBoringButBigLift *bbbLift = [self create];
        bbbLift.mainLift = ftoLift;
        bbbLift.boringLift = ftoLift;
    }];
}

- (void)adjustToMainLifts {
    [self addMissingLifts];
    [self removeUnnecessaryLifts];
}

- (void)addMissingLifts {
    [[[JFTOLiftStore instance] findAll] each:^(JFTOLift *ftoLift) {
        if (![self find:@"mainLift" value:ftoLift]) {
            JFTOBoringButBigLift *bbbLift = [self create];
            bbbLift.boringLift = ftoLift;
            bbbLift.mainLift = ftoLift;
        }
    }];
}

- (void)removeUnnecessaryLifts {
    for (int i = 0; i < [self count]; i++) {
        JFTOBoringButBigLift *bbbLift = [self atIndex:i];
        if (![[JFTOLiftStore instance] find:@"uuid" value:bbbLift.mainLift.uuid]) {
            [self remove:bbbLift];
            i--;
        }

        if (![[JFTOLiftStore instance] find:@"uuid" value:bbbLift.boringLift.uuid]) {
            bbbLift.boringLift = [[JFTOLiftStore instance] first];
        }
    }
}

@end