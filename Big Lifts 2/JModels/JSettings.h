#import "JModel.h"

@interface JSettings : JModel
@property(nonatomic) NSString *units;
@property(nonatomic) NSDecimalNumber *roundTo;
@property(nonatomic) NSString *roundingFormula;
@end