#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import <MRCEnumerable/NSArray+Enumerable.h>
#import "StoreViewController.h"
#import "SKProductStore.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"
#import "Purchaser.h"

@interface StoreViewController ()

@property(nonatomic, strong) NSDictionary *purchaseIdToStoreInfo;
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.purchaseIdToStoreInfo = @{
            @"barLoading" : @{
                    @"buyButton" : self.barLoadingBuyButton,
                    @"purchasedButton" : self.barLoadingPurchasedButton
            },
            @"ssOnusWunsler" : @{
                    @"buyButton" : self.onusWunslerBuyButton,
                    @"purchasedButton" : self.onusWunslerPurchasedButton
            },
            @"ssPracticalProgramming" : @{
                    @"buyButton" : self.ssPracticalProgrammingBuyButton,
                    @"purchasedButton" : self.ssPracticalProgrammingPurchasedButton
            },
            @"ssWarmup" : @{
                    @"buyButton" : self.ssWarmupBuyButton,
                    @"purchasedButton" : self.ssWarmupPurchasedButton
            }
    };
    [[self.purchaseIdToStoreInfo allKeys] each:^(NSString *purchaseId) {
        [self setProductPrice:[[SKProductStore instance] productById:purchaseId]];
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideShowBuyButtons)
                                                 name:@"iapPurchased"
                                               object:nil];
}

- (void)setProductPrice:(SKProduct *)product {
    if (product) {
        UIButton *button = self.purchaseIdToStoreInfo[product.productIdentifier][@"buyButton"];
        [button setTitle:[self priceOf:product] forState:UIControlStateNormal];
        [button setUserInteractionEnabled:YES];
    }
}

- (NSString *)priceOf:(SKProduct *)product {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:product.priceLocale];
    return [numberFormatter stringFromNumber:product.price];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideShowBuyButtons];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self sectionShouldBeVisible:section]) {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self sectionShouldBeVisible:section]) {
        return [super tableView:tableView viewForHeaderInSection:section];
    }
    else {
        return [self emptyView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self sectionShouldBeVisible:section]) {
        return [super tableView:tableView heightForHeaderInSection:section];
    }
    else {
        return 0;
    }
}

- (BOOL)sectionShouldBeVisible:(int)section {
    NSDictionary *sectionMapping = @{@"Starting Strength" : @1, @"5/3/1" : @2};
    CurrentProgram *program = [[CurrentProgramStore instance] first];
    return section == 0 || section == [sectionMapping[program.name] intValue];
}

- (void)hideShowBuyButtons {
    [self.purchaseIdToStoreInfo each:^(NSString *purchaseId, NSDictionary *purchaseInfo) {
        BOOL barLoadingPurchased = [[IAPAdapter instance] hasPurchased:purchaseId];

        [purchaseInfo[@"buyButton"] setHidden:barLoadingPurchased];
        [purchaseInfo[@"purchasedButton"] setHidden:!barLoadingPurchased];
    }];
}

- (IBAction)buyButtonTapped:(id)sender {
    NSString *purchaseId = [self purchaseIdForButton:sender];
    [[Purchaser new] purchase:purchaseId];
}

- (NSString *)purchaseIdForButton:(id)sender {
    return [self.purchaseIdToStoreInfo detect:^BOOL(id key, NSDictionary *purchaseInfo) {
        return purchaseInfo[@"buyButton"] == sender;
    }];
}

@end