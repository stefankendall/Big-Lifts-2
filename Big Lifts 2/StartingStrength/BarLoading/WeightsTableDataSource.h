@interface WeightsTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (copy) void (^onDataChange) (void);
- (void)plateCountChanged:(UIStepper *) plateStepper;
@end