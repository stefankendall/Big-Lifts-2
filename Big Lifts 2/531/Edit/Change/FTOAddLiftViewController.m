#import <MRCEnumerable/NSArray+Enumerable.h>
#import <FlurrySDK/Flurry.h>
#import "FTOAddLiftViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "DecimalNumberHelper.h"

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
    [self.doneButton setEnabled:[self allFieldsAreFilled]];
}

- (BOOL)allFieldsAreFilled {
    NSArray *fields = @[self.nameField, self.weightField];
    return [fields detect:^BOOL(UITextField *field) {
        return [[field text] isEqualToString:@""];
    }] == nil;
}

- (IBAction)doneButtonTapped:(id)sender {
    JFTOLift *lift = [[JFTOLiftStore instance] create];
    lift.name = [self.nameField text];
    lift.weight = [NSDecimalNumber decimalNumberWithString:[self.weightField text] locale:NSLocale.currentLocale];
    lift.increment = [DecimalNumberHelper nanOrNil:
                    [NSDecimalNumber decimalNumberWithString:[self.increaseField text]
                                                      locale:NSLocale.currentLocale]
                                                to:N(0)];
    lift.usesBar = YES;

    [self.navigationController popViewControllerAnimated:YES];
}

@end