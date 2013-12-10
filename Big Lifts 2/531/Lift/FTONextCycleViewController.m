#import "FTONextCycleViewController.h"
#import "FTOCycleAdjustor.h"
#import "JFTOLiftStore.h"

@implementation FTONextCycleViewController
- (IBAction)doneButtonTapped:(id)selector {
    FTOCycleAdjustor *cycleAdjustor = [FTOCycleAdjustor new];
    [cycleAdjustor nextCycle];
    [[JFTOLiftStore instance] incrementLifts];
    [self.navigationController popViewControllerAnimated:YES];
}
@end