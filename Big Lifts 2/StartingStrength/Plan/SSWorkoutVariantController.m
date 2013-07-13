#import <ViewDeck/IIViewDeckController.h>
#import "SSWorkoutVariantController.h"
#import "SSWorkoutStore.h"
#import "NSDictionaryMutator.h"
#import "SSVariantStore.h"
#import "SSVariant.h"
#import "IAPAdapter.h"
#import "PurchaseOverlay.h"

@interface SSWorkoutVariantController ()
@property(nonatomic, strong) NSDictionary *variantMapping;
@end

@implementation SSWorkoutVariantController

- (void)viewWillAppear:(BOOL)animated {
    if (!([[IAPAdapter instance] hasPurchased:@"ssOnusWunsler"])) {
        [self disable:self.onusWunslerCell];
    }
    else {
        [self enable:self.onusWunslerCell];
    }

    if (!([[IAPAdapter instance] hasPurchased:@"ssPracticalProgramming"])) {
        [self disable:self.practicalProgrammingCell];
    }
    else {
        [self enable:self.practicalProgrammingCell];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[tableView cellForRowAtIndexPath:indexPath] viewWithTag:kPurchaseOverlayTag]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        [self.viewDeckController setCenterController:[storyboard instantiateViewControllerWithIdentifier:@"storeNav"]];
    }
    else {
        NSString *variantName = [self.variantMapping objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
        [[SSWorkoutStore instance] setupVariant:variantName];

        [self checkSelectedVariant];
    }
}

- (void)disable:(UITableViewCell *)cell {
    if (![cell viewWithTag:kPurchaseOverlayTag]) {
        UIView *overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
        CGRect frame = CGRectMake(0, 0, [cell frame].size.width, [cell frame].size.height);
        [overlay setFrame:frame];
        [cell addSubview:overlay];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

- (void)enable:(UITableViewCell *)cell {
    if ([cell viewWithTag:kPurchaseOverlayTag]) {
        UIView *overlay = [cell viewWithTag:kPurchaseOverlayTag];
        [overlay removeFromSuperview];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.variantMapping = @{@0 : @"Standard", @1 : @"Novice", @2 : @"Onus-Wunsler", @3 : @"Practical Programming"};
    [self checkSelectedVariant];
}

- (void)checkSelectedVariant {
    SSVariant *variant = [[SSVariantStore instance] first];
    [self uncheckAllRows];

    int index = [[[NSDictionaryMutator new] invert:self.variantMapping][variant.name] intValue];
    UITableViewCell *cell = [self tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [[cell viewWithTag:1] setHidden:NO];
}

- (void)uncheckAllRows {
    for (int i = 0; i < [self tableView:nil numberOfRowsInSection:0]; i++) {
        UITableViewCell *cell = [self tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [[cell viewWithTag:1] setHidden:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end