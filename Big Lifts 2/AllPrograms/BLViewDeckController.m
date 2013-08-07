#import "BLViewDeckController.h"
#import "CurrentProgram.h"
#import "CurrentProgramStore.h"

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
            }
    };

    NSString *program = [[[CurrentProgramStore instance] first] name];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:
            programControllers[program][@"main"]]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:
                                    programControllers[program][@"nav"]]];
    if (self) {
        self.panningCancelsTouchesInView = NO;
        self.enabled = NO;
    }
    return self;
}

- (void)firstTimeInApp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    NSDictionary *firstTimeControllers = @{
            @"5/3/1" : @"ftoEditNavController",
            @"Starting Strength" : @"ssEditViewController"
    };

    NSString *program = [[[CurrentProgramStore instance] first] name];
    [self setCenterController:[storyboard instantiateViewControllerWithIdentifier:
            firstTimeControllers[program]]];
}

@end