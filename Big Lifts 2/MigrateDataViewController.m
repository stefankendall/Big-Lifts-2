#import "MigrateDataViewController.h"
#import "LogMigrator.h"

@implementation MigrateDataViewController

- (void)viewWillAppear:(BOOL)animated {
    if (![self hasExistingICloudStore] || [self hasSeenMigrationPrompt]) {
        [self performSegueWithIdentifier:@"startAppFromMigrate" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self markHasSeenMigrationPrompt: YES];
}

- (void)markHasSeenMigrationPrompt: (BOOL) hasSeen {
    [[NSUserDefaults standardUserDefaults] setBool:hasSeen forKey:@"hasSeenMigration"];
}

- (BOOL)hasSeenMigrationPrompt {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenMigration"];
}

- (BOOL)hasExistingICloudStore {
    return YES;
}

- (IBAction)migrateData:(id)sender {
    [self.migrateDataButton setEnabled:NO];
    [self.startFreshButton setEnabled:NO];

    [[LogMigrator new] migrate: ^{
        [self performSegueWithIdentifier:@"startAppFromMigrate" sender:self];
    }];
}

@end