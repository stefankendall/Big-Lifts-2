#import "JModel.h"

@class JWorkout;

@interface JFTOWorkout : JModel

@property(nonatomic) JWorkout<Optional> *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL done;
@property(nonatomic) BOOL deload;
@property(nonatomic) BOOL incrementAfterWeek;

@end