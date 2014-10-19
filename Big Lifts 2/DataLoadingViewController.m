#import "DataLoadingViewController.h"
#import "JCurrentProgramStore.h"
#import "JCurrentProgram.h"
#import "DataLoaded.h"
#import "CrashCounter.h"

@implementation DataLoadingViewController

- (void)viewDidAppear:(BOOL)animated {
    if ([CrashCounter crashCount] <= 1) {
        [self pollForReady];
    }
    else {
        [self performSegueWithIdentifier:@"appCrashedPreviously" sender:self];
    }
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
        [[DataLoaded instance] setFirstTimeInApp:NO];
        [self performSegueWithIdentifier:@"dataLoadedSegueToProgram" sender:self];
    }
    else {
        [[DataLoaded instance] setFirstTimeInApp:YES];
        [self performSegueWithIdentifier:@"dataLoadedSegue" sender:self];
    }
}

@end