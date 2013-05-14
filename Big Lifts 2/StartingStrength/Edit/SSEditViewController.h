#import "SSMiddleViewController.h"

@class SSStartingWeightTableDataSource;

@interface SSEditViewController : SSMiddleViewController {
    __weak IBOutlet UITableView *startingWeightTableView;
    __weak IBOutlet UITableView *ssLiftsTableView;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *mainView;


}

@property(nonatomic, strong) SSStartingWeightTableDataSource<UITableViewDataSource> *startingWeightTableDataSource;
@property(nonatomic, strong) NSObject<UITableViewDataSource> *liftsTableDataSource;
@end