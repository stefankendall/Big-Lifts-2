#import "PlateRemaining.h"
#import "Plate.h"

@implementation PlateRemaining
+ (PlateRemaining *)fromPlate:(Plate *)p {
    PlateRemaining *r = [PlateRemaining new];
    r.count = [p.count intValue];
    r.weight = p.weight;
    return r;
}

- (id)initWithWeight:(NSDecimalNumber *)weight count:(int)count {
    if(self = [super init]){
        self.weight = weight;
        self.count = count;
    }
    return self;
}


@end