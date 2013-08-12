#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "FTOAssistanceViewController.h"
#import "FTOAssistance.h"
#import "FTOAssistanceStore.h"
#import "UITableViewController+NoEmptyRows.h"

@interface FTOAssistanceViewController ()
@property(nonatomic, strong) NSDictionary *cellMapping;
@end

@implementation FTOAssistanceViewController

- (void)viewDidLoad {
    self.cellMapping = @{
            FTO_ASSISTANCE_NONE : self.noneCell,
            FTO_ASSISTANCE_BORING_BUT_BIG : self.bbbCell
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [self checkCurrentAssistance];
}

- (void)checkCurrentAssistance {
    [[self.cellMapping allValues] each:^(UITableViewCell *cell) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }];
    NSString *name = [[[FTOAssistanceStore instance] first] name];
    [self.cellMapping[name] setAccessoryType:UITableViewCellAccessoryCheckmark];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *assistanceType = [self.cellMapping detect:^BOOL(NSString *type, UITableViewCell *cell) {
        return selectedCell == cell;
    }];
    FTOAssistance *assistance = [[FTOAssistanceStore instance] first];
    assistance.name = assistanceType;
    [self checkCurrentAssistance];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end