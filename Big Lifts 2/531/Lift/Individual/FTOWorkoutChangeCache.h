@class FTOWorkoutChange;
@class JFTOWorkout;
@class SetChange;

@interface FTOWorkoutChangeCache : NSObject

+ (instancetype)instance;

@property(nonatomic, strong) NSMutableArray *ftoWorkoutChanges;

- (void)clear;

- (FTOWorkoutChange *)changeForWorkout:(JFTOWorkout *)workout;

- (SetChange *)changeForWorkout:(JFTOWorkout *)workout set:(int)set;
@end