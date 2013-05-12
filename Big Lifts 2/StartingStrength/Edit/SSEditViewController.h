#import "SSMiddleViewController.h"

@interface SSEditViewController : SSMiddleViewController {
    __weak IBOutlet UITableView *startingWeightTableView;
    __weak IBOutlet UITableView *ssLiftsTableView;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *mainView;

}

@property(nonatomic, strong) NSObject<UITableViewDataSource> *startingWeightTableDataSource;
@property(nonatomic, strong) NSObject<UITableViewDataSource> *liftsTableDataSource;
@end