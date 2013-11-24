#import "JSONModel/JSONModel.h"

@interface JSettings : JSONModel
@property(nonatomic) NSString *units;
@property(nonatomic) NSDecimalNumber *roundTo;
@property(nonatomic) NSString *roundingFormula;
@end