extern NSString * const FTO_ASSISTANCE_NONE;
extern NSString * const FTO_ASSISTANCE_BORING_BUT_BIG;
extern NSString * const FTO_ASSISTANCE_TRIUMVIRATE;

@interface FTOAssistance : NSManagedObject
@property(nonatomic) NSString *name;
@end