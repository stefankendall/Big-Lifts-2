@interface FTOCustomWeekSelectorViewController : UITableViewController <UITextFieldDelegate> {}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editWeekButton;

- (void)copyTemplate;

- (IBAction)editWeekTapped:(id)sender;
@end