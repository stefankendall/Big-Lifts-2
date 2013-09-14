@class Workout;

@interface FTOCustomWorkout : NSManagedObject

@property(nonatomic) Workout *workout;
@property(nonatomic) NSNumber *week;
@property(nonatomic, strong) NSNumber *order;
@property(nonatomic) BOOL deload;
@end