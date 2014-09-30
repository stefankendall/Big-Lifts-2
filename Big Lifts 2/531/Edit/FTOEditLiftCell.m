#import "FTOEditLiftCell.h"
#import "TextViewInputAccessoryBuilder.h"
#import "RowTextField.h"
#import "JFTOSettingsStore.h"
#import "TrainingMaxRowTextField.h"
#import "JFTOSettings.h"
#import "JLift.h"
#import "DecimalNumberHandlers.h"

@implementation FTOEditLiftCell

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.max];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.trainingMax];
}

- (void)setLift:(JLift *)lift {
    [[self liftName] setText:lift.name];
    if ([lift.weight doubleValue] > 0) {
        [[self max] setText:[lift.weight stringValue]];
    }
    [self updateTrainingMax:lift.weight];
}

- (void)updateTrainingMax:(NSDecimalNumber *)weight {
    JFTOSettings *settings = [[JFTOSettingsStore instance] first];
    NSDecimalNumber *trainingWeight = [
            [weight decimalNumberByMultiplyingBy:settings.trainingMax withBehavior:DecimalNumberHandlers.noRaise]
            decimalNumberByDividingBy:N(100) withBehavior:DecimalNumberHandlers.noRaise];
    NSNumberFormatter *nf = [NSNumberFormatter new];
    [nf setMaximumFractionDigits:1];
    [self.trainingMax setText:[nf stringFromNumber:trainingWeight]];
}

@end