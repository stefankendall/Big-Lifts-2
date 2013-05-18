@interface SSWorkoutDataSource : NSObject <UITableViewDataSource>
@property(nonatomic, strong) NSString *name;

- (id)initWithName:(NSString *)string;
@end