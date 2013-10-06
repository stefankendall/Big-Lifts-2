extern const NSString *ROUNDING_FORMULA_EPLEY;
extern const NSString *ROUNDING_FORMULA_BRZYCKI;

@interface Settings : NSManagedObject
@property(nonatomic) NSString *units;
@property(nonatomic) NSDecimalNumber *roundTo;
@property(nonatomic) NSString *roundingFormula;
@end