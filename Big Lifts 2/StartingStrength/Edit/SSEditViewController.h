#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class SSLiftFormDataSource;

@interface SSEditViewController : UITableViewController {
    SSLiftFormDataSource *ssLiftFormDataSource;
}

@end