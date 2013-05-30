#import "SSMiddleViewController.h"

@class SSLiftFormDataSource;

@interface SSEditViewController : SSMiddleViewController {
    __weak IBOutlet UITableView *ssLiftsForm;
    SSLiftFormDataSource *ssLiftFormDataSource;
}


@end