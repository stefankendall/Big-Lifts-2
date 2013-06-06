#import "AddPlateViewController.h"
#import "PlateStore.h"
#import "Plate.h"

@implementation AddPlateViewController
@synthesize weightTextField, countTextField;

- (IBAction)saveTapped:(id)button {
    double weight = [[weightTextField text] doubleValue];
    int count = [[countTextField text] intValue];
    Plate *p = [[PlateStore instance] create];
    p.weight = [NSNumber numberWithDouble:weight];
    p.count = [NSNumber numberWithInt:count];
}


@end