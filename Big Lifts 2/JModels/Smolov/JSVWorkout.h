#import "JModel.h"

@class JWorkout;

@interface JSVWorkout : JModel

@property(nonatomic) JWorkout *workout;

@property(nonatomic) NSNumber *day;
@property(nonatomic) NSNumber *week;
@property(nonatomic) NSNumber *cycle;

@property(nonatomic) BOOL testMax;
@property(nonatomic) BOOL done;
@property(nonatomic) NSDecimalNumber<Optional> *weightAdd;

@end