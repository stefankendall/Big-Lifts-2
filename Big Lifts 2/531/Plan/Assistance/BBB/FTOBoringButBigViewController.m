#import "FTOBoringButBigViewController.h"
#import "FTOBoringButBigStore.h"
#import "SetData.h"
#import "FTOBoringButBig.h"
#import "FTOAssistanceStore.h"

@implementation FTOBoringButBigViewController

- (void)viewDidLoad {
    FTOBoringButBig *bbb = [[FTOBoringButBigStore instance] first];
    [self.percentageField setText:[bbb.percentage stringValue]];
    [self.threeMonthToggle setOn:bbb.threeMonthChallenge];
}

- (IBAction)percentageChanged:(id)sender {
    UITextField *percentageField = sender;
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithString:[percentageField text] locale:NSLocale.currentLocale];
    [[[FTOBoringButBigStore instance] first] setPercentage:percentage];
    [[FTOAssistanceStore instance] restore];
}

- (IBAction)toggleThreeMonthChallenge:(id)sender {
    UISwitch *toggle = sender;
    [[[FTOBoringButBigStore instance] first] setThreeMonthChallenge:[toggle isOn]];
}

@end