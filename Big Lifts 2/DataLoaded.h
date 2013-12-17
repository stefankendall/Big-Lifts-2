@interface DataLoaded : NSObject

@property(nonatomic) BOOL loaded;
@property(nonatomic) BOOL viewLoaded;

@property(nonatomic) BOOL timedOut;

+ (DataLoaded *)instance;
@end