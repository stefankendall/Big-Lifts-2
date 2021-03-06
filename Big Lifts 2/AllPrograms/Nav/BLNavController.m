#import <ViewDeck/IIViewDeckController.h>
#import "BLNavController.h"
#import "NavTableViewCell.h"
#import "Mailer.h"
#import "JCurrentProgramStore.h"
#import "Purchaser.h"
#import "IAPAdapter.h"
#import "SKProductStore.h"
#import "PriceFormatter.h"
#import "ExportImportViewController.h"

@implementation BLNavController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < ([[self tableView] numberOfRowsInSection:0]); i++) {
        UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell isKindOfClass:NavTableViewCell.class]) {
            [(NavTableViewCell *) cell setRightMargin:(int) [self.viewDeckController leftSize]];
        }
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(somethingPurchased)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];

    [self makeWhite:self.refreshImage];
}

- (void)somethingPurchased {
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];

    NSString *productId = [self everythingProductId];
    SKProduct *product = [[SKProductStore instance] productById:productId];
    if (product) {
        [self.unlockEverythingLabel setText:[NSString stringWithFormat:@"Unlock! (%@)", [[PriceFormatter new] priceOf:product]]];
    }
}

- (NSString *const)everythingProductId {
    return [Purchaser hasPurchasedAnything] ? IAP_EVERYTHING_DISCOUNT : IAP_EVERYTHING;
}

- (void)presentFeedbackEmail {
    [[[Mailer alloc] initWithSender:self] presentFeedback];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    [self.viewDeckController closeLeftViewAnimated:YES];

    NSMutableDictionary *tagViewMapping = [[self specificTagMapping] mutableCopy];
    tagViewMapping[@2] = @"barLoadingNav";
    tagViewMapping[@4] = @"settingsViewController";
    tagViewMapping[@11] = @"oneRepNav";

    if ([cell tag] == 6) {
        [[[JCurrentProgramStore instance] first] setName:nil];
        [[self.viewDeckController navigationController] popViewControllerAnimated:YES];
    }
    else if ([cell tag] == 8) {
        [self presentFeedbackEmail];
    }
    else if ([cell tag] == 21) {
        ExportImportViewController *controller = [[UIStoryboard storyboardWithName:@"ExportImportViewController" bundle:nil] instantiateInitialViewController];
        [self.viewDeckController setCenterController:controller];
    }
    else if ([cell tag] == 31) {
        [self restorePurchases];
    }
    else if ([cell tag] == 10) {
        [[Purchaser new] purchase:[self everythingProductId]];
    }
    else {
        NSString *storyBoardId = tagViewMapping[@([cell tag])];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:storyBoardId]];
    }
}

- (void)makeWhite:(UIImageView *)imageView {
    if (imageView == nil) {
        return;
    }
    imageView.tintColor = [UIColor whiteColor];
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)restorePurchases {
    [[IAPAdapter instance] restorePurchasesWithCompletion:^{
        UIAlertView *alertView = [[UIAlertView alloc]
                initWithTitle:@""
                      message:@"Purchases Restored!"
                     delegate:nil
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self shouldHide:tableView forPath:indexPath]) {
        [cell setHidden:YES];
    }
}

- (BOOL)shouldHide:(UITableView *)tableView forPath:(NSIndexPath *)path {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:path];
    return [[IAPAdapter instance] hasPurchased:IAP_EVERYTHING] && cell == self.unlockEverythingCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self shouldHide:tableView forPath:indexPath]) {
        return 0;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSDictionary *)specificTagMapping {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end