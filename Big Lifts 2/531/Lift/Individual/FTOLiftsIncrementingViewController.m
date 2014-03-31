#import "FTOLiftsIncrementingViewController.h"

@implementation FTOLiftsIncrementingViewController {}

- (IBAction)doneButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoTrackNavController"]];
}

@end