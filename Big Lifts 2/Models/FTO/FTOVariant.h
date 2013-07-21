extern NSString * const FTO_VARIANT_STANDARD;
extern NSString * const FTO_VARIANT_SIX_WEEK;
extern NSString * const FTO_VARIANT_PYRAMID;
extern NSString * const FTO_VARIANT_JOKER;
extern NSString * const FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS;

@interface FTOVariant : NSManagedObject
@property(nonatomic) NSString *name;
@end