#import "JModel.h"

@class JFTOFullCustomWorkout;
@protocol JFTOFullCustomWorkout;

@interface JFTOFullCustomWeek : JModel

@property(nonatomic) NSString *name;
@property(nonatomic) BOOL incrementAfterWeek;
@property(nonatomic) NSNumber *week;
@property(nonatomic) NSMutableArray<JFTOFullCustomWorkout> *workouts;

@end