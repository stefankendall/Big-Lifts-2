@interface AddPlateViewController : UITableViewController<UITextFieldDelegate>
{
}
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

-(IBAction) saveTapped: (id) button;

@end