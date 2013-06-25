#import "FTOViewDeckController.h"

@implementation FTOViewDeckController

- (id)initWithCoder:(NSCoder *)aDecoder {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"ftoEditNavController"]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"ftoNavigation"]];
    if (self) {
        self.panningCancelsTouchesInView = NO;
    }
    return self;
}

- (void)firstTimeInApp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"ftoEditNavController"]];
}

@end