#import "SSTrackViewController.h"
#import "SSLogDataSource.h"

@implementation SSTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ssLogDataSource = [SSLogDataSource new];
    [logTable setDataSource:ssLogDataSource];
    [logTable setDelegate: ssLogDataSource];
}

@end