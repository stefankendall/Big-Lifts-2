#import "BLTableViewController.h"

@class JSet;
@class JWorkout;

@interface FTOTriumvirateViewController : BLTableViewController
- (NSArray *)uniqueSetsFor:(JWorkout *)workout;
@end