#import "JSONModel/JSONModel.h"

@class Workout;

@interface JFTOCustomWorkout : JSONModel
@property(nonatomic) Workout *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic) NSString *name;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL deload;
@property(nonatomic) BOOL incrementAfterWeek;
@end