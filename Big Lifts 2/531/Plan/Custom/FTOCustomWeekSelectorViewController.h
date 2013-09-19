@interface FTOCustomWeekSelectorViewController : UITableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editWeekButton;

- (IBAction)editWeekTapped:(id)sender;
@end