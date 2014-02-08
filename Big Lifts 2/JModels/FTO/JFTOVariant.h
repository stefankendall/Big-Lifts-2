#import "JModel.h"

extern NSString * const FTO_VARIANT_STANDARD;
extern NSString * const FTO_VARIANT_HEAVIER;
extern NSString * const FTO_VARIANT_POWERLIFTING;
extern NSString * const FTO_VARIANT_SIX_WEEK;
extern NSString * const FTO_VARIANT_PYRAMID;
extern NSString * const FTO_VARIANT_JOKER;
extern NSString * const FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS;
extern NSString * const FTO_VARIANT_FIRST_SET_LAST;
extern NSString * const FTO_VARIANT_ADVANCED;
extern NSString * const FTO_VARIANT_FIVES_PROGRESSION;
extern NSString * const FTO_VARIANT_CUSTOM;

@interface JFTOVariant : JModel
@property(nonatomic) NSString *name;
@end