#import "UIViewController+ViewDeckAdditions.h"
#import "IAPAdapter.h"
#import "UITableViewController+NoEmptyRows.h"

@interface StoreViewController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet UIButton *barLoadingBuyButton;
@property(weak, nonatomic) IBOutlet UIButton *barLoadingPurchasedButton;

@property(weak, nonatomic) IBOutlet UIButton *onusWunslerBuyButton;
@property(weak, nonatomic) IBOutlet UIButton *onusWunslerPurchasedButton;

@property (weak, nonatomic) IBOutlet UIButton *ssPracticalProgrammingBuyButton;
@property (weak, nonatomic) IBOutlet UIButton *ssPracticalProgrammingPurchasedButton;

@property (weak, nonatomic) IBOutlet UIButton *ssWarmupBuyButton;
@property (weak, nonatomic) IBOutlet UIButton *ssWarmupPurchasedButton;

- (NSString *)priceOf:(SKProduct *)product;

- (BOOL)sectionShouldBeVisible:(int)section;

- (IBAction)buyButtonTapped:(id)sender;

- (NSString *)purchaseIdForButton:(id)sender;
@end