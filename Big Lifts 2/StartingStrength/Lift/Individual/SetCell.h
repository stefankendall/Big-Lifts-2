#import "CTCustomTableViewCell.h"

@class Set;

@interface SetCell : CTCustomTableViewCell {
}

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *liftLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionalLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (nonatomic) NSNumber *enteredReps;
@property (nonatomic) NSDecimalNumber *enteredWeight;


- (void)setSet:(Set *) set;

- (void)setSet:(Set *)set withEnteredReps:(NSNumber *)enteredReps withEnteredWeight:(NSDecimalNumber *)weight;

@end