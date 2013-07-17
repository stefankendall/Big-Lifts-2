#import "FTOAmrapForm.h"
#import "Set.h"
#import "SettingsStore.h"
#import "Settings.h"
#import "TextViewInputAccessoryBuilder.h"
#import "AmrapDelegate.h"

@implementation FTOAmrapForm

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
}

- (void)viewDidLoad {
    [self.repsField setDelegate:self];
    [self setupFields];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSNumber *reps = [NSNumber numberWithInt:[[textField text] intValue]];
    [self.delegate repsChanged: reps];
}

- (void)setupFields {
    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [[self.set roundedEffectiveWeight] stringValue];
    [self.weightField setText:[NSString stringWithFormat:@"%@ %@", weightText, settings.units]];
    [self.repsField setPlaceholder:[self.set.reps stringValue]];
}

@end