@class SSWorkout;

@interface SSState : NSManagedObject
@property(nonatomic) SSWorkout *lastWorkout;
@property(nonatomic) NSNumber *workoutAAlternation;
@property(nonatomic) NSNumber *practicalProgrammingCounter;
@end