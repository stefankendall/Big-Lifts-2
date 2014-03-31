#import "FTOLiftsIncrementingViewController.h"
#import "JFTOLiftStore.h"
#import "FTOLiftsIncrementingCell.h"

@implementation FTOLiftsIncrementingViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOLiftsIncrementingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOLiftsIncrementingCell.class)];
    if (!cell) {
        cell = [FTOLiftsIncrementingCell create];
    }
    [cell setLift:[[JFTOLiftStore instance] atIndex:indexPath.row]];

    return cell;
}

- (IBAction)doneButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoTrackNavController"]];
}

@end