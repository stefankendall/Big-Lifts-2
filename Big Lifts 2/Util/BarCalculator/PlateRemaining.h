@class JPlate;

@interface PlateRemaining : NSObject
@property(nonatomic) int count;
@property(nonatomic) NSDecimalNumber *weight;

+ (PlateRemaining *)fromPlate:(JPlate *)p;

- (id)initWithWeight:(NSDecimalNumber *)weight count:(int)count;
@end