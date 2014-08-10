#import "SetCell.h"
#import "RMSwipeTableViewCell.h"

@class JSet;

@interface FTOWorkoutCell : RMSwipeTableViewCell

@property(nonatomic, strong) SetCell *setCell;

@property(nonatomic, strong) NSIndexPath *indexPath;

- (void)setSet:(JSet *)set;

- (void)setSet:(JSet *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight;

@end