#import "JSONModel/JSONModel.h"

@class Workout;
@class JWorkout;

@interface JFTOCustomWorkout : JSONModel
@property(nonatomic) JWorkout *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic) NSString *name;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL deload;
@property(nonatomic) BOOL incrementAfterWeek;
@end