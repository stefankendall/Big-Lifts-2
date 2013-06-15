#import "UIViewController+ViewDeckAdditions.h"

@interface StoreViewController : UITableViewController
{}
@property (weak, nonatomic) IBOutlet UIButton *barLoadingBuyButton;
@property (weak, nonatomic) IBOutlet UIButton *barLoadingPurchasedButton;
- (IBAction)buyBarLoadingButtonTapped:(id)sender;

@end