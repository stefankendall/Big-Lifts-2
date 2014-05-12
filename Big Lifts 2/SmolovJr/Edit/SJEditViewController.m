#import <FlurrySDK/Flurry.h>
#import "SJEditViewController.h"
#import "JSJLiftStore.h"
#import "JSJLift.h"
#import "TextViewInputAccessoryBuilder.h"
#import "DecimalNumberHelper.h"

@implementation SJEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.liftField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.maxField];

    [self.liftField setDelegate:self];
    [self.maxField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"SmolovJr_Edit"];

    JSJLift *lift = [[JSJLiftStore instance] first];
    [self.liftField setText:lift.name];
    if ([lift.weight intValue] > 0) {
        [self.maxField setText:[lift.weight stringValue]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *liftName = [self.liftField text];
    NSString *max = [self.maxField text];

    JSJLift *lift = [[JSJLiftStore instance] first];
    lift.name = liftName;
    lift.weight = [DecimalNumberHelper nanTo0: [NSDecimalNumber decimalNumberWithString:max locale:NSLocale.currentLocale]];
}

@end