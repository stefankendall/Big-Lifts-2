#import "SSMiddleViewController.h"

@interface SSEditViewController : SSMiddleViewController {
    __weak IBOutlet UITableView *startingWeightTableView;
    __weak IBOutlet UITableView *ssLiftsTableView;
}

@property(nonatomic, strong) NSObject<UITableViewDataSource> *startingWeightTableDataSource;
@end