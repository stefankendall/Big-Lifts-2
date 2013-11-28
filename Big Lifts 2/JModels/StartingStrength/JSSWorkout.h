#import <JSONModel/JSONModel.h>

@interface JSSWorkout : JSONModel

@property(nonatomic) NSString *name;
@property(nonatomic) NSNumber *order;
@property(nonatomic) NSMutableArray *workouts;
@property(nonatomic) NSNumber *alternation;
@end