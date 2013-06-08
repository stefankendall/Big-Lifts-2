#import "EZForm.h"

@interface AddPlateViewController : UITableViewController<EZFormDelegate>
{
}
@property(nonatomic, strong) EZForm *form;

@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (weak, nonatomic) IBOutlet UITableViewCell *weightCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *countCell;

-(IBAction) saveTapped: (id) button;

@end