#import "BLViewDeckController.h"
#import "JCurrentProgramStore.h"

@implementation BLViewDeckController

- (id)initWithCoder:(NSCoder *)aDecoder {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];

    NSDictionary *programControllers = @{
            @"5/3/1" : @{
                    @"nav" : @"FTONavController",
                    @"main" : @"ftoLiftNav"
            },
            @"Starting Strength" : @{
                    @"nav" : @"SSNavController",
                    @"main" : @"ssLiftViewController"
            },
            @"Smolov Jr" : @{
                    @"nav" : @"SJNavController",
                    @"main" : @"sjLiftNav"
            },
            @"Smolov" : @{
                    @"nav" : @"SVNavController",
                    @"main" : @"svLiftSelectorNav"
            }
    };

    NSString *program = [[[JCurrentProgramStore instance] first] name];
    UIViewController *nav = [[UIStoryboard storyboardWithName:programControllers[program][@"nav"] bundle:nil]
            instantiateInitialViewController];

    UIViewController *main = [storyboard instantiateViewControllerWithIdentifier:
            programControllers[program][@"main"]];

    self = [super initWithCenterViewController:main leftViewController:nav];
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