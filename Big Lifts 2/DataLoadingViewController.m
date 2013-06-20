#import "DataLoadingViewController.h"
#import "BLAppDelegate.h"

@implementation DataLoadingViewController

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoaded) name:@"dataLoaded" object:nil];
}

- (void)dataLoaded {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    BLAppDelegate *app = (BLAppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.window setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"programSelector"]];
}

@end