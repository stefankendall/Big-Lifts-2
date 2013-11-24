#import "JSONModel/JSONModel.h"

@class JWorkout;

@interface JFTOWorkout : JSONModel

@property(nonatomic) JWorkout *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL done;
@property(nonatomic) BOOL deload;
@property(nonatomic) BOOL incrementAfterWeek;

@end