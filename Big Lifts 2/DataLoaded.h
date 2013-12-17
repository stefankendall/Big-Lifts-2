@interface DataLoaded : NSObject

@property(nonatomic) BOOL loaded;
@property(nonatomic) BOOL viewLoaded;

+ (DataLoaded *)instance;
@end