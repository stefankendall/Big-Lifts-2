@class Plate;

@interface PlateRemaining : NSObject
@property(nonatomic) int count;
@property(nonatomic) NSDecimalNumber *weight;

+ (PlateRemaining *)fromPlate:(Plate *)p;

- (id)initWithWeight:(NSDecimalNumber *)weight count:(int)count;
@end