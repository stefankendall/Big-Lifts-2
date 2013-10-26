#import "SJEditViewController.h"
#import "SJLiftStore.h"
#import "SJLift.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation SJEditViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.liftField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.maxField];

    [self.liftField setDelegate:self];
    [self.maxField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    SJLift *lift = [[SJLiftStore instance] first];
    [self.liftField setText:lift.name];
    if ([lift.weight intValue] > 0) {
        [self.maxField setText:[lift.weight stringValue]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *liftName = [self.liftField text];
    NSString *max = [self.maxField text];

    SJLift *lift = [[SJLiftStore instance] first];
    lift.name = liftName;
    lift.weight = [NSDecimalNumber decimalNumberWithString:max locale:NSLocale.currentLocale];
}

@end