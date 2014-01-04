@class JSVWorkout;
@class PaddingTextField;

@interface SVWorkoutViewController : UITableViewController <UITextFieldDelegate> {}

@property(nonatomic, strong) JSVWorkout *svWorkout;
@property(nonatomic, strong) PaddingTextField *oneRepField;

- (IBAction)doneButtonTapped:(id)sender;
@end