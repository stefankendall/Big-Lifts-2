extern NSString * const IAP_BAR_LOADING;
extern NSString * const IAP_SS_WARMUP;
extern NSString * const IAP_SS_ONUS_WUNSLER;
extern NSString * const IAP_SS_PRACTICAL_PROGRAMMING;
extern NSString * const FTO_JOKER;

extern NSString * const IAP_PURCHASED_NOTIFICATION;

@interface Purchaser : NSObject
- (void)purchase:(NSString *)purchaseId;
@end