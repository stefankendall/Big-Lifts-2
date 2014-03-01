#import <MRCEnumerable/NSArray+Enumerable.h>
#import <FlurrySDK/Flurry.h>
#import "FTOAddLiftViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JFTOLiftStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOLift.h"

@implementation FTOAddLiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameField setDelegate:self];
    [self.weightField setDelegate:self];
    [self.increaseField setDelegate:self];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.nameField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.increaseField];
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_AddLift"];

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
    JFTOLift *lift = [[JFTOLiftStore instance] create];
    lift.name = [self.nameField text];
    lift.weight = [NSDecimalNumber decimalNumberWithString:[self.weightField text] locale:NSLocale.currentLocale];
    lift.increment = [NSDecimalNumber decimalNumberWithString:[self.increaseField text] locale:NSLocale.currentLocale];
    lift.usesBar = YES;

    [self.navigationController popViewControllerAnimated:YES];
}

@end