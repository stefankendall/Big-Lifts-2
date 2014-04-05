@class JFTOWorkout;
@class SetChange;

@interface FTOWorkoutChange : NSObject

@property(nonatomic, strong) JFTOWorkout *workout;
@property(nonatomic, strong) NSMutableDictionary *changesBySet;

- (instancetype)initWithWorkout:(JFTOWorkout *)workout;

@end