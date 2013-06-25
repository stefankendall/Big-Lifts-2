#import "SSViewDeckController.h"

@implementation SSViewDeckController

- (id)initWithCoder:(NSCoder *)aDecoder {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"ssLiftViewController"]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"ssNavViewController"]];
    if (self) {
        self.panningCancelsTouchesInView = NO;
    }
    return self;
}

- (void)firstTimeInApp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ssEditViewController"]];
}


@end