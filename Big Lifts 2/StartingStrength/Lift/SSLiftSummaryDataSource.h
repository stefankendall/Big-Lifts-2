@class SSWorkout;

@interface SSLiftSummaryDataSource : NSObject <UITableViewDataSource>
- (id)initWithSsWorkout:(id)o;

@property(nonatomic, strong) SSWorkout *ssWorkout;

@end