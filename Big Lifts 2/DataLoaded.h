@interface DataLoaded : NSObject

@property(nonatomic) BOOL loaded;
@property(nonatomic) BOOL viewLoaded;

@property(nonatomic) BOOL timedOut;

@property(nonatomic) BOOL firstTimeInApp;

+ (DataLoaded *)instance;
@end