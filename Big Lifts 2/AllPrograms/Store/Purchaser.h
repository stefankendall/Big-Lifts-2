extern NSString * const IAP_BAR_LOADING;
extern NSString * const IAP_GRAPHING;
extern NSString * const IAP_SS_WARMUP;
extern NSString * const IAP_SS_ONUS_WUNSLER;
extern NSString * const IAP_SS_PRACTICAL_PROGRAMMING;
extern NSString * const IAP_FTO_JOKER;
extern NSString * const IAP_FTO_ADVANCED;
extern NSString * const IAP_FTO_TRIUMVIRATE;
extern NSString * const IAP_FTO_SST;
extern NSString * const IAP_FTO_FIVES_PROGRESSION;

extern NSString * const IAP_PURCHASED_NOTIFICATION;

@interface Purchaser : NSObject
- (void)purchase:(NSString *)purchaseId;
@end