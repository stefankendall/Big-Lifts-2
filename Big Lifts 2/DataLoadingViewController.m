#import "DataLoadingViewController.h"

@implementation DataLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(pollForReady) withObject:nil afterDelay:0.5];
}

- (void)pollForReady {
    if (self.dataLoaded) {
        [self performSelector:@selector(segueToApp) withObject:nil afterDelay:0.5];
    }
    else {
        [self performSelector:@selector(pollForReady) withObject:nil afterDelay:0.5];
    }
}

- (void)segueToApp {
    [self performSegueWithIdentifier:@"dataLoadedSegue" sender:self];
}

@end