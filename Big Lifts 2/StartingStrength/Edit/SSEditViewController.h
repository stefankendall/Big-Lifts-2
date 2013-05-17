#import "SSMiddleViewController.h"

@class SSStartingWeightTableDataSource;

@interface SSEditViewController : SSMiddleViewController {
    __weak IBOutlet UITableView *startingWeightTableView;
    __weak IBOutlet UITableView *ssLiftsTableView;
}

@property(nonatomic, strong) SSStartingWeightTableDataSource <UITableViewDataSource> *startingWeightTableDataSource;
@property(nonatomic, strong) NSObject <UITableViewDataSource> *liftsTableDataSource;
@end