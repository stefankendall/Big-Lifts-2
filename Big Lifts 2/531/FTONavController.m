#import <ViewDeck/IIViewDeckController.h>
#import "FTONavController.h"

@implementation FTONavController

- (NSDictionary *)specificTagMapping {
    return @{
            @0 : @"ftoLiftNav",
            @1 : @"ftoEditNavController",
            @3 : @"ftoTrackNavController",
            @7 : @"ftoPlanNav"
    };
}

@end