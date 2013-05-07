#import "SSIIViewDeckController.h"

@implementation SSIIViewDeckController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"ssEditViewController"]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"ssNavViewController"]];
    if (self) {
    }
    return self;
}

@end