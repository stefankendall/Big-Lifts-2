@class SetLog;

@interface SetLogContainer : NSObject

- (id) initWithSetLog: (SetLog*) setLog;

@property(nonatomic, strong) SetLog *setLog;
@property(nonatomic) int count;
@end