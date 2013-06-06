@interface AddPlateViewController : UIViewController
{
}
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;

-(IBAction) saveTapped: (id) button;

@end