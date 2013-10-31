#import "SetCell.h"

@interface FTOWorkoutCell : CTCustomTableViewCell

@property(nonatomic, strong) SetCell *setCell;

- (void)setSet:(Set *)set;

- (void)setSet:(Set *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight;

@end