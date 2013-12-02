#import "DataLoadingViewController.h"
#import "JCurrentProgramStore.h"
#import "JCurrentProgram.h"

@implementation DataLoadingViewController

- (void)viewDidAppear:(BOOL)animated {
    self.dataLoaded = YES;
    [self performSelector:@selector(pollForReady) withObject:nil afterDelay:0.5];
}

- (void)pollForReady {
    if (self.dataLoaded) {
        [self segueToApp];
    }
    else {
        [self performSelector:@selector(pollForReady) withObject:nil afterDelay:0.5];
    }
}

- (void)segueToApp {
    JCurrentProgram *program = [[JCurrentProgramStore instance] first];
    if (program.name) {
        [self performSegueWithIdentifier:@"dataLoadedSegueToProgram" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"dataLoadedSegue" sender:self];
    }
}

@end