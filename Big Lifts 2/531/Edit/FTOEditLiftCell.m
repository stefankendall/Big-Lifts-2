#import "FTOEditLiftCell.h"
#import "TextViewInputAccessoryBuilder.h"
#import "RowTextField.h"
#import "JFTOSettingsStore.h"
#import "WeightRounder.h"
#import "TrainingMaxRowTextField.h"
#import "JFTOSettings.h"
#import "JLift.h"
#import "DecimalNumberHandlers.h"
#import "JSettings.h"

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
    NSDecimalNumber *trainingWeight = [[weight decimalNumberByMultiplyingBy:settings.trainingMax] decimalNumberByDividingBy:N(100) withBehavior:DecimalNumberHandlers.noRaise];
    [self.trainingMax setText:[[[WeightRounder new] roundTo1:trainingWeight withDirection:ROUNDING_TYPE_NORMAL] stringValue]];
}

@end