@class Plate;

@interface PlateRemaining : NSObject
@property(nonatomic) int count;
@property(nonatomic) double weight;

+ (PlateRemaining *)fromPlate:(Plate *)p;

- (id)initWithWeight:(double)weight count:(int)count;
@end