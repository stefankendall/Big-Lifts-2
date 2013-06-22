@class SSWorkout;

@interface SSState : NSManagedObject
@property(nonatomic) SSWorkout *lastWorkout;
@end