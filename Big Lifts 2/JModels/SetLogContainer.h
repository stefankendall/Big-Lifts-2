@class JSetLog;

@interface SetLogContainer : NSObject

- (id)initWithSetLog:(JSetLog *)setLog;

@property(nonatomic, strong) JSetLog *setLog;
@property(nonatomic) int count;
@end