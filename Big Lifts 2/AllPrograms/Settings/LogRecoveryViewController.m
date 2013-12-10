#import "LogRecoveryViewController.h"
#import "LogMigrator.h"

@implementation LogRecoveryViewController

- (IBAction)startButtonTapped:(id) sender {
    [self.startButton setEnabled:NO];
    [self.statusLabel setText:@"Loading old data and importing"];
    [[LogMigrator new] migrate: ^{
        [self.statusLabel setText:@"Migrate finished"];
    }];
}

@end