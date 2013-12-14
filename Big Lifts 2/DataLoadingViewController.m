#import "DataLoadingViewController.h"
#import "JCurrentProgramStore.h"
#import "JCurrentProgram.h"
#import "DataLoaded.h"

@implementation DataLoadingViewController

- (void)viewDidAppear:(BOOL)animated {
    [self pollForReady];
}

- (void)pollForReady {
    if ([[DataLoaded instance] loaded]) {
        [self segueToApp];
    }
    else {
        [self performSelector:@selector(pollForReady) withObject:nil afterDelay:1];
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