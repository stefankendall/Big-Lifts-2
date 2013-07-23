#import "CTCustomTableViewCell.h"

@class Set;

@interface SetCell : CTCustomTableViewCell {
}

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *liftLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionalLabel;
@property (nonatomic) int enteredReps;

- (void)setSet:(Set *) set;
- (void)setSet:(Set *)set withEnteredReps: (int) enteredReps;

@end