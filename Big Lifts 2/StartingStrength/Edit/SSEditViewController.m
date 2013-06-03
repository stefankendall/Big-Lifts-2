#import "SSEditViewController.h"
#import "SSLiftFormDataSource.h"

@implementation SSEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    ssLiftFormDataSource = [SSLiftFormDataSource new];
    [ssLiftsForm setDataSource:ssLiftFormDataSource];
}

- (void)handleSingleTap:(id)handleSingleTap {
    [self.view endEditing:YES];
}

@end