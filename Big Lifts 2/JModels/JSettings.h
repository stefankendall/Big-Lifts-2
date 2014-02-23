#import "JModel.h"

extern const NSString *ROUNDING_FORMULA_EPLEY;
extern const NSString *ROUNDING_FORMULA_BRZYCKI;

extern const NSString *ROUNDING_TYPE_NORMAL;

extern NSString *NEAREST_5_ROUNDING;

@interface JSettings : JModel
@property(nonatomic) NSString *units;
@property(nonatomic) NSDecimalNumber *roundTo;
@property(nonatomic) NSString *roundingType;
@property(nonatomic) NSString *roundingFormula;
@property(nonatomic) BOOL screenAlwaysOn;
@property(nonatomic) BOOL isMale;
@property(nonatomic) NSDecimalNumber <Optional> *bodyweight;

@property(nonatomic) BOOL adsEnabled;
@end