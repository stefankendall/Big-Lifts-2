@class Workout;
@class Lift;

@interface FTOTriumvirate : NSManagedObject
@property(nonatomic) Workout *workout;
@property(nonatomic) Lift *mainLift;
@end