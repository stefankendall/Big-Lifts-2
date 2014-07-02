#import "Migrate14to15.h"
#import "JDataHelper.h"
#import "JFTOSetStore.h"

@implementation Migrate14to15

- (void)run {
    [self addMaxRepsToSets];
}

- (void)addMaxRepsToSets {
    NSArray *data = [JDataHelper read:[JFTOSetStore instance]];
    for (NSMutableDictionary *object in data) {
        object[@"maxReps"] = @0;
    }
    [JDataHelper write:[JFTOSetStore instance] values:data];
}

@end