@interface Debug : NSObject
+ (void) time:(void(^)(void))someBlock;
@end