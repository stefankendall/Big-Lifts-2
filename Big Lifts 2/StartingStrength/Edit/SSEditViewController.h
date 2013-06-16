#import "UIViewController+ViewDeckAdditions.h"

@class SSLiftFormDataSource;

@interface SSEditViewController : UIViewController {
    __weak IBOutlet UITableView *ssLiftsForm;
    SSLiftFormDataSource *ssLiftFormDataSource;
}


@end