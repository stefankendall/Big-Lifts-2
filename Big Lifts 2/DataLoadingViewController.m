#import "DataLoadingViewController.h"

@implementation DataLoadingViewController

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoaded) name:@"dataLoaded" object:nil];
}

- (void)dataLoaded {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.navigationController pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"programSelector"] animated:NO];
}

@end