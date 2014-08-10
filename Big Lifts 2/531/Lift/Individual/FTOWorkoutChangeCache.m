#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOWorkoutChangeCache.h"
#import "JFTOWorkout.h"
#import "FTOWorkoutChange.h"
#import "SetChange.h"

@implementation FTOWorkoutChangeCache

+ (instancetype)instance {
    static FTOWorkoutChangeCache *cache = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        cache = [FTOWorkoutChangeCache new];
    });

    return cache;
}

- (id)init {
    self = [super init];
    if (self) {
        self.ftoWorkoutChanges = [@[] mutableCopy];
        self.completedSets = [@[] mutableCopy];
    }

    return self;
}

- (void)clear {
    self.ftoWorkoutChanges = [@[] mutableCopy];
    self.completedSets = [@[] mutableCopy];
}

- (FTOWorkoutChange *)changeForWorkout:(JFTOWorkout *)workout {
    FTOWorkoutChange *change = [self.ftoWorkoutChanges detect:^BOOL(FTOWorkoutChange *c) {
        return c.workout == workout;
    }];
    if (!change) {
        change = [[FTOWorkoutChange alloc] initWithWorkout:workout];
        [self.ftoWorkoutChanges addObject:change];
    }

    return change;
}

- (SetChange *)changeForWorkout:(JFTOWorkout *)workout set:(int)set {
    FTOWorkoutChange *workoutChange = [self changeForWorkout:workout];
    SetChange *setChange = workoutChange.changesBySet[[NSNumber numberWithInt:set]];
    if (!setChange) {
        setChange = [SetChange new];
        workoutChange.changesBySet[[NSNumber numberWithInt:set]] = setChange;
    }

    return setChange;
}

- (BOOL)isComplete:(NSIndexPath *)path {
    return [self matchingPath:path] != nil;
}

- (NSIndexPath *)matchingPath:(NSIndexPath *)path {
    return [self.completedSets detect:^BOOL(NSIndexPath *testPath) {
        return path.section == testPath.section && path.row == testPath.row;
    }];
}

- (void)toggleComplete:(NSIndexPath *)path {
    if ([self isComplete:path]) {
        [self.completedSets removeObject:[self matchingPath:path]];
    }
    else {
        [self.completedSets addObject:path];
    }
}

@end