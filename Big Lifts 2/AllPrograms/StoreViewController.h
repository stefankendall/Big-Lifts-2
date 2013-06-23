#import "UIViewController+ViewDeckAdditions.h"
#import "IAPAdapter.h"

@interface StoreViewController : UITableViewController
{}
@property (weak, nonatomic) IBOutlet UIButton *barLoadingBuyButton;
@property (weak, nonatomic) IBOutlet UIButton *barLoadingPurchasedButton;

@property (weak, nonatomic) IBOutlet UIButton *onusWunslerBuyButton;
@property (weak, nonatomic) IBOutlet UIButton *onusWunslerPurchasedButton;

- (NSString *)priceOf:(SKProduct *)product;

- (IBAction)buyButtonTapped:(id)sender;

- (NSString *)purchaseIdForButton:(id)sender;
@end