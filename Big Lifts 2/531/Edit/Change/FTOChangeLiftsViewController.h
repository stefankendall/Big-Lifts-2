@interface FTOChangeLiftsViewController : UITableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *arrangeButton;

- (IBAction)arrangeButtonTapped:(id)sender;
@end