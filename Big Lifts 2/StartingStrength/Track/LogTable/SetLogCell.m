#import "SetLogCell.h"
#import "Set.h"

@implementation SetLogCell
@synthesize set;

int const SET_LOG_CELL_HEIGHT = 30;

- (void)setSet:(Set *)set1 {
    set = set1;
}

@end