#import "BLViewDeckController.h"
#import "JCurrentProgramStore.h"

@implementation BLViewDeckController

- (id)initWithCoder:(NSCoder *)aDecoder {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];

    NSDictionary *programControllers = @{
            @"5/3/1" : @{
                    @"nav" : @"ftoNavigation",
                    @"main" : @"ftoLiftNav"
            },
            @"Starting Strength" : @{
                    @"nav" : @"ssNavViewController",
                    @"main" : @"ssLiftViewController"
            },
            @"Smolov Jr" : @{
                    @"nav" : @"sjNavViewController",
                    @"main" : @"sjLiftNav"
            },
            @"Smolov" : @{
                    @"nav" : @"svNavViewController",
                    @"main" : @"svLiftSelectorNav"
            }
    };

    NSString *program = [[[JCurrentProgramStore instance] first] name];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:
            programControllers[program][@"main"]]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:
                                    programControllers[program][@"nav"]]];
    if (self) {
        self.panningCancelsTouchesInView = NO;
        self.enabled = NO;
        self.leftSize = 60;
        self.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    }

    return self;
}

- (void)firstTimeInApp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    NSDictionary *firstTimeControllers = @{
            @"5/3/1" : @"ftoEditNavController",
            @"Starting Strength" : @"ssEditViewController",
            @"Smolov Jr" : @"sjEditNav",
            @"Smolov" : @"svEditNav"
    };

    NSString *program = [[[JCurrentProgramStore instance] first] name];
    [self setCenterController:[storyboard instantiateViewControllerWithIdentifier:
            firstTimeControllers[program]]];
}

@end