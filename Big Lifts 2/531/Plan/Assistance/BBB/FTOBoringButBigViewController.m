#import "FTOBoringButBigViewController.h"
#import "FTOBoringButBigStore.h"
#import "SetData.h"
#import "FTOBoringButBigAssistance.h"

@implementation FTOBoringButBigViewController

- (IBAction)percentageChanged:(id)sender {
    UITextField *percentageField = sender;
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithString:[percentageField text]];
    [[[FTOBoringButBigStore instance] first] setPercentage:percentage];
    [[FTOBoringButBigAssistance new] setup];
}

- (IBAction)toggleThreeMonthChallenge:(id)sender {
    UISwitch *toggle = sender;
}

@end