#import "DataLoadingViewController.h"
#import "JCurrentProgramStore.h"
#import "JCurrentProgram.h"
#import "DataLoaded.h"

@implementation DataLoadingViewController

- (void)viewDidAppear:(BOOL)animated {
    [self pollForReady];
    [self waitForTimeout];
}

- (void)waitForTimeout {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (![[DataLoaded instance] viewLoaded]) {
            [self timeout];
        }
    });
}

- (void)timeout {
    [[DataLoaded instance] setTimedOut:YES];
    [self performSegueWithIdentifier:@"appTimedOut" sender:self];
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
    [[DataLoaded instance] setViewLoaded:YES];
}

@end