@interface DataLoaded : NSObject

@property(nonatomic) BOOL loaded;
@property(nonatomic) BOOL firstTimeInApp;

+ (DataLoaded *)instance;
@end