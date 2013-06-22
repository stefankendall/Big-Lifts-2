#import "SenTestCase+ControllerTestAdditions.h"

@implementation SenTestCase (ControllerTestAdditions)

- (id)getControllerByStoryboardIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    [controller loadView];
    [controller viewDidLoad];
    [controller viewWillAppear:YES];
    return controller;
}

@end