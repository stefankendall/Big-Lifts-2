#import "JModel.h"

@class JWorkout;

@interface JFTOCustomWorkout : JModel
@property(nonatomic) JWorkout<Optional> *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic) NSString *name;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL deload;
@property(nonatomic) BOOL incrementAfterWeek;
@end