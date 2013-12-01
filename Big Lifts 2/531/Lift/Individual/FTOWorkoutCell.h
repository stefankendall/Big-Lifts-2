#import "SetCell.h"

@class JSet;

@interface FTOWorkoutCell : CTCustomTableViewCell

@property(nonatomic, strong) SetCell *setCell;

- (void)setSet:(JSet *)set;

- (void)setSet:(JSet *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight;

@end