@class JSet;
@class JWorkout;

@interface FTOTriumvirateViewController : UITableViewController {}
- (NSArray *)uniqueSetsFor:(JWorkout *)workout;
@end