#import "UIViewController+ViewDeckAdditions.h"
#import "IAPAdapter.h"

@interface StoreViewController : UITableViewController
{}
@property (weak, nonatomic) IBOutlet UIButton *barLoadingBuyButton;
@property (weak, nonatomic) IBOutlet UIButton *barLoadingPurchasedButton;

- (NSString *)priceOf:(SKProduct *)product;

- (IBAction)buyBarLoadingButtonTapped:(id)sender;

@end