@class Workout;

@interface SJWorkout : NSManagedObject

@property(nonatomic) Workout *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL done;

@property(nonatomic) NSDecimalNumber *minWeightAdd;
@property(nonatomic) NSDecimalNumber *maxWeightAdd;

@end