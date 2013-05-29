@class SetLog;

@interface SetLogContainer : NSObject

- (id) initWithSetLog: (SetLog*) setLog;

@property(nonatomic, strong) SetLog *setLog;
@end