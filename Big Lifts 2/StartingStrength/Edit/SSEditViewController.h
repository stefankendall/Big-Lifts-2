#import "SSMiddleViewController.h"

@class SSStartingWeightTableDataSource;
@class SSLiftsTableDataSource;

@interface SSEditViewController : SSMiddleViewController {
    __weak IBOutlet UITableView *startingWeightTableView;
    __weak IBOutlet UITableView *ssLiftsTableView;
}

@property(nonatomic, retain) SSStartingWeightTableDataSource <UITableViewDataSource> *startingWeightTableDataSource;
@property(nonatomic, retain) SSLiftsTableDataSource <UITableViewDataSource> *liftsTableDataSource;
@end