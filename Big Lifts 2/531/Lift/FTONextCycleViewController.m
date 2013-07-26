#import "FTONextCycleViewController.h"
#import "FTOCycleAdjustor.h"

@implementation FTONextCycleViewController
- (IBAction)doneButtonTapped:(id)selector {
    FTOCycleAdjustor *cycleAdjustor = [FTOCycleAdjustor new];
    [cycleAdjustor nextCycle];
    [self.navigationController popViewControllerAnimated:YES];
}
@end