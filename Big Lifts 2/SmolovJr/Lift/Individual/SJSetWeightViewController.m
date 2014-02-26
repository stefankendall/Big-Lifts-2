#import <FlurrySDK/Flurry.h>
#import "SJSetWeightViewController.h"
#import "SetWeightDelegate.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation SJSetWeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.weightField setDelegate:self];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightField];
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"SmolovJr_SetWeight"];

    [self.weightField setText:[self.weight stringValue]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate weightChanged:
            [NSDecimalNumber decimalNumberWithString:[textField text] locale:NSLocale.currentLocale]];
}

@end