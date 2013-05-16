#import "SSMiddleViewController.h"

@class SSStartingWeightTableDataSource;
@class SSStartingWeightTableDelegate;

@interface SSEditViewController : SSMiddleViewController {
    __weak IBOutlet UITableView *startingWeightTableView;
    __weak IBOutlet UITableView *ssLiftsTableView;
    __weak IBOutlet UIView *mainView;
}

@property(nonatomic, strong) SSStartingWeightTableDataSource <UITableViewDataSource> *startingWeightTableDataSource;
@property(nonatomic, strong) SSStartingWeightTableDelegate <UITableViewDelegate> *startingWeightTableDelegate;
@property(nonatomic, strong) NSObject <UITableViewDataSource> *liftsTableDataSource;
@end