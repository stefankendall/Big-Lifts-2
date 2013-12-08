#import "FTOBoringButBigViewController.h"
#import "JFTOBoringButBigStore.h"
#import "JFTOBoringButBig.h"
#import "JFTOAssistanceStore.h"

@implementation FTOBoringButBigViewController

- (void)viewWillDisappear:(BOOL)animated {
    [[JFTOAssistanceStore instance] restore];
}

- (void)viewDidLoad {
    JFTOBoringButBig *bbb = [[JFTOBoringButBigStore instance] first];
    [self.percentageField setText:[bbb.percentage stringValue]];
    [self.threeMonthToggle setOn:bbb.threeMonthChallenge];
}

- (IBAction)percentageChanged:(id)sender {
    UITextField *percentageField = sender;
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithString:[percentageField text] locale:NSLocale.currentLocale];
    [[[JFTOBoringButBigStore instance] first] setPercentage:percentage];
}

- (IBAction)toggleThreeMonthChallenge:(id)sender {
    UISwitch *toggle = sender;
    [[[JFTOBoringButBigStore instance] first] setThreeMonthChallenge:[toggle isOn]];
}

@end