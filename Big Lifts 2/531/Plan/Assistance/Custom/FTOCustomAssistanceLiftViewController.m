#import "FTOCustomAssistanceLiftViewController.h"
#import "AddCell.h"
#import "FTOCustomAssistanceLiftCell.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation FTOCustomAssistanceLiftViewController

const int LIFTS_SECTION = 0;
const int ADD_SECTION = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:FTOCustomAssistanceLiftCell.class];
    [self registerCellNib:AddCell.class];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == LIFTS_SECTION) {
        return [[JFTOCustomAssistanceLiftStore instance] count];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AddCell.class)];
        return cell;
    }
    else {
        FTOCustomAssistanceLiftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOCustomAssistanceLiftCell.class)];

        JFTOCustomAssistanceLift *lift = [[JFTOCustomAssistanceLiftStore instance] atIndex:indexPath.row];
        [cell.name setText:lift.name];
        [cell.weight setText:[NSString stringWithFormat:@"%@ %@", lift.weight ? lift.weight : @"0", [[[JSettingsStore instance] first] units]]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        self.segueLift = [[JFTOCustomAssistanceLiftStore instance] create];
        self.segueLift.name = @"New Lift";
    }
    else {
        self.segueLift = [[JFTOCustomAssistanceLiftStore instance] atIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"ftoCustomAsstEditLift" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FTOCustomAssistanceEditLiftViewController *controller = [segue destinationViewController];
    controller.lift = self.segueLift;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == ADD_SECTION) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[JFTOCustomAssistanceLiftStore instance] removeAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (IBAction)deleteTapped:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.deleteButton setTitle:@"Delete"];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        [self.deleteButton setTitle:@"Done"];
    }
}

@end