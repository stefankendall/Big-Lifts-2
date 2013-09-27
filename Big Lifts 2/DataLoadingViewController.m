#import "DataLoadingViewController.h"
#import "NSDictionaryMutator.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"

@implementation DataLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(pollForReady) withObject:nil afterDelay:0.5];
}

- (void)pollForReady {
    if (self.dataLoaded) {
        [self performSelector:@selector(segueToApp) withObject:nil afterDelay:1];
    }
    else {
        [self performSelector:@selector(pollForReady) withObject:nil afterDelay:1];
    }
}

- (void)segueToApp {
    CurrentProgram *program = [[CurrentProgramStore instance] first];
    if (program.name) {
        [self performSegueWithIdentifier:@"dataLoadedSegueToProgram" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"dataLoadedSegue" sender:self];
    }

}

@end