@interface DataLoaded : NSObject

@property(nonatomic) BOOL loaded;

+ (DataLoaded *)instance;
@end