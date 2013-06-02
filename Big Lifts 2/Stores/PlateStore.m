#import "PlateStore.h"
#import "Plate.h"

@implementation PlateStore

- (void)setupDefaults {
    [self createPlateWithWeight:45.0 count:6];
    [self createPlateWithWeight:35.0 count:6];
    [self createPlateWithWeight:25.0 count:6];
    [self createPlateWithWeight:10.0 count:6];
    [self createPlateWithWeight:5.0 count:6];
    [self createPlateWithWeight:2.5 count:6];
}

- (void)createPlateWithWeight:(double)weight count:(int)count {
    Plate *p = [self create];
    p.weight = [NSNumber numberWithDouble:weight];
    p.count = [NSNumber numberWithInt:count];
}

- (NSArray *)findAll {
    return [super findAllWithSort:[[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO]];
}


@end