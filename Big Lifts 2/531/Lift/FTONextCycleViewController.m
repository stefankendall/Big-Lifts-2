#import <FlurrySDK/Flurry.h>
#import "FTONextCycleViewController.h"
#import "FTOCycleAdjustor.h"
#import "JFTOLiftStore.h"

@implementation FTONextCycleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_NextCycle"];
}

- (IBAction)doneButtonTapped:(id)selector {
    FTOCycleAdjustor *cycleAdjustor = [FTOCycleAdjustor new];
    [cycleAdjustor nextCycle];
    [[JFTOLiftStore instance] incrementLifts];
    [self.navigationController popViewControllerAnimated:YES];
}
@end