@interface WeightsTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (copy) void (^onDataChange) (void);
- (void)plateCountChanged:(UIStepper *) plateStepper;
@end