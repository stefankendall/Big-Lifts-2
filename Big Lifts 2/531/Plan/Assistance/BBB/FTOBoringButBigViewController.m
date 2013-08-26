#import "FTOBoringButBigViewController.h"
#import "FTOBBBPercentageStore.h"
#import "SetData.h"
#import "FTOBoringButBigAssistance.h"

@implementation FTOBoringButBigViewController

- (IBAction)percentageChanged:(id)sender {
    UITextField *percentageField = sender;
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithString:[percentageField text]];
    [[[FTOBBBPercentageStore instance] first] setPercentage:percentage];
    [[FTOBoringButBigAssistance new] setup];
}

- (IBAction)toggleThreeMonthChallenge:(id)sender {
    UISwitch *toggle = sender;
}

@end