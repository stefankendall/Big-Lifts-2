#import "FTOBoringButBigEditViewController.h"
#import "JFTOLiftStore.h"
#import "FTOBoringButBigEditCell.h"
#import "JFTOLift.h"
#import "PaddingTextField.h"
#import "PaddingRowTextField.h"
#import "JFTOBoringButBigLift.h"
#import "JFTOBoringButBigLiftStore.h"

@implementation FTOBoringButBigEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib:FTOBoringButBigEditCell.class];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[JFTOBoringButBigLiftStore instance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTOBoringButBigEditCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FTOBoringButBigEditCell.class)];

    JFTOBoringButBigLift *bbbLift = [[JFTOBoringButBigLiftStore instance] atIndex:indexPath.row];
    [[cell forLift] setText:bbbLift.mainLift.name];
    [[cell useLift] setText:bbbLift.boringLift.name];
    [[cell useLift] setDelegate:self];
    [[cell useLift] setIndexPath:indexPath];
    cell.useLift.cell = cell;
    [cell.liftPicker selectRow:[[[JFTOLiftStore instance] findAll] indexOfObject:bbbLift.boringLift] inComponent:0 animated:NO];
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    PaddingRowTextField *rowTextField = (PaddingRowTextField *) textField;
    JFTOBoringButBigLift *bbbLift = [[JFTOBoringButBigLiftStore instance] atIndex:rowTextField.indexPath.row];
    FTOBoringButBigEditCell *editCell = (FTOBoringButBigEditCell *) rowTextField.cell;
    int selectedRow = [editCell.liftPicker selectedRowInComponent:0];
    bbbLift.boringLift = [[JFTOLiftStore instance] atIndex:selectedRow];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

@end