@class FTOWorkoutChange;
@class JFTOWorkout;
@class SetChange;

@interface FTOWorkoutChangeCache : NSObject

+ (instancetype)instance;

@property(nonatomic, strong) NSMutableArray *ftoWorkoutChanges;

@property(nonatomic, strong) NSMutableArray *completedSets;

- (void)clear;

- (FTOWorkoutChange *)changeForWorkout:(JFTOWorkout *)workout;

- (SetChange *)changeForWorkout:(JFTOWorkout *)workout set:(int)set;

- (BOOL)isComplete:(NSIndexPath *)path;

- (void)toggleComplete:(NSIndexPath *)path;
@end