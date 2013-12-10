@interface LogRecoveryViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)startButtonTapped:(id) sender;

@end