extern NSString * const FTO_VARIANT_STANDARD;
extern NSString * const FTO_VARIANT_SIX_WEEK;
extern NSString * const FTO_VARIANT_PYRAMID;
extern NSString * const FTO_VARIANT_JOKER;

@interface FTOVariant : NSManagedObject
@property(nonatomic) NSString *name;
@end