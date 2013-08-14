@class Workout;
@class Set;

@interface FTOTriumvirateViewController : UITableViewController {}
- (int)countSetsInWorkout:(Workout *)workout forSet:(Set *)set;

- (NSArray *)uniqueSetsFor:(Workout *)workout;
@end