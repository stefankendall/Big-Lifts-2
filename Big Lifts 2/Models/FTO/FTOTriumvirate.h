@class Workout;
@class Lift;
@class Set;

@interface FTOTriumvirate : NSManagedObject
@property(nonatomic) Workout *workout;
@property(nonatomic) Lift *mainLift;

- (int)countMatchingSets:(Set *)set;

- (NSArray *)matchingSets:(Set *)set;
@end