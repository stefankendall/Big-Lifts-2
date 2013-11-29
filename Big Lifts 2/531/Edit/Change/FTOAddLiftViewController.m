#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOAddLiftViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "FTOLift.h"
#import "FTOLiftStore.h"
#import "FTOWorkoutStore.h"

@implementation FTOAddLiftViewController

- (void)viewDidLoad {
    [self.nameField setDelegate:self];
    [self.weightField setDelegate:self];
    [self.increaseField setDelegate:self];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.nameField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.increaseField];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.doneButton setEnabled:NO];
    [self.nameField setText:@""];
    [self.weightField setText:@""];
    [self.increaseField setText:@""];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self allFieldsAreFilled]) {
        [self.doneButton setEnabled:YES];
    }
    else {
        [self.doneButton setEnabled:NO];
    }
}

- (BOOL)allFieldsAreFilled {
    NSArray *fields = @[self.nameField, self.weightField, self.increaseField];
    return [fields detect:^BOOL(UITextField *field) {
        return [[field text] isEqualToString:@""];
    }] == nil;
}

- (IBAction)doneButtonTapped:(id)sender {
    FTOLift *lift = [[FTOLiftStore instance] create];
    lift.name = [self.nameField text];
    lift.weight = [NSDecimalNumber decimalNumberWithString:[self.weightField text] locale:NSLocale.currentLocale];
    lift.increment = [NSDecimalNumber decimalNumberWithString:[self.increaseField text] locale:NSLocale.currentLocale];
    lift.usesBar = YES;

    [[FTOWorkoutStore instance] switchTemplate];

    [self.navigationController popViewControllerAnimated:YES];
}

@end