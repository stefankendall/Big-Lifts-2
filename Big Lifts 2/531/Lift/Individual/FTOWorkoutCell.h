#import "SetCell.h"

@interface FTOWorkoutCell : CTCustomTableViewCell

@property(nonatomic, strong) SetCell *setCell;

- (void)setSet:(Set *)set;
- (void)setSet:(Set *)set withEnteredReps:(int)enteredReps;

@end