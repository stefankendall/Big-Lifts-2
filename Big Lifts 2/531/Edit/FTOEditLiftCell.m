#import "FTOEditLiftCell.h"
#import "TextViewInputAccessoryBuilder.h"
#import "RowTextField.h"
#import "FTOSettings.h"
#import "BLStore.h"
#import "FTOSettingsStore.h"
#import "WeightRounder.h"

@implementation FTOEditLiftCell

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.max];
}

- (void)setLift:(FTOLift *)lift {
    [[self liftName] setText:lift.name];
    if ([lift.weight doubleValue] > 0) {
        [[self max] setText:[lift.weight stringValue]];
    }
    [self updateTrainingMax:lift.weight];
}

- (void)updateTrainingMax:(NSDecimalNumber *)weight {
    FTOSettings *settings = [[FTOSettingsStore instance] first];
    NSDecimalNumber *trainingWeight = [[weight decimalNumberByMultiplyingBy:settings.trainingMax] decimalNumberByDividingBy:N(100)];
    [self.trainingWeight setText:[[[WeightRounder new] roundTo1:trainingWeight] stringValue]];
}

@end