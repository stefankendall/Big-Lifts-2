@interface WilksCoefficientCalculator : NSObject
+ (NSDecimalNumber *)calculate:(NSDecimalNumber *)weight withBodyweight:(NSDecimalNumber *)bodyweight isMale:(BOOL)isMale withUnits:(NSString *)units;
@end