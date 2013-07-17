#import "FTOAmrapForm.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOAmrapForm

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
}

- (void)setSet:(Set *)set {
    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [[set roundedEffectiveWeight] stringValue];
    [self.weightField setText:[NSString stringWithFormat:@"%@ %@", weightText, settings.units]];
    [self.repsField setPlaceholder:[set.reps stringValue]];
}

@end