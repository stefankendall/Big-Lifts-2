#import "SSTrackViewController.h"
#import "SSLogDataSource.h"
#import "WorkoutLogCell.h"

@implementation SSTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ssLogDataSource = [SSLogDataSource new];
    [logTable setDataSource:ssLogDataSource];
}

@end