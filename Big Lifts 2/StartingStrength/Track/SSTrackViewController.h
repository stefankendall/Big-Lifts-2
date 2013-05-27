#import "SSMiddleViewController.h"

@class SSLogDataSource;

@interface SSTrackViewController : SSMiddleViewController
{
    __weak IBOutlet UITableView *logTable;
    SSLogDataSource *ssLogDataSource;
}


@end