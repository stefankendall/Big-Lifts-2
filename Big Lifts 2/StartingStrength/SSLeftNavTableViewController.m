#import "SSLeftNavTableViewController.h"
#import "IIViewDeckController.h"

@implementation SSLeftNavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    float rightLedgeSize = [self.viewDeckController rightLedgeSize];

    NSString *format = @"";
    NSArray *rightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:nil metrics:nil views:nil];
    [[self view] addConstraints:rightConstraints];
}


@end