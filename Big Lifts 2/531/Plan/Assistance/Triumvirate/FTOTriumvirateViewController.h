@class Workout;
@class Set;
@class FTOTriumvirate;

@interface FTOTriumvirateViewController : UITableViewController {}
- (NSArray *)uniqueSetsFor:(Workout *)workout;
@end