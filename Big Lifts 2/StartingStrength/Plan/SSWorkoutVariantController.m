#import "SSWorkoutVariantController.h"
#import "SSWorkoutStore.h"
#import "NSDictionaryMutator.h"
#import "SSVariantStore.h"
#import "SSVariant.h"
#import "IAPAdapter.h"

@interface SSWorkoutVariantController ()

@property(nonatomic, strong) UIView *onusOverlay;
@property(nonatomic, strong) NSDictionary *variantMapping;
@end

@implementation SSWorkoutVariantController

- (void)viewWillAppear:(BOOL)animated {
    if (!([[IAPAdapter instance] hasPurchased:@"ssOnusWunsler"])) {
        [self disableOnusWunsler];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *variantName = [self.variantMapping objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
    [[SSWorkoutStore instance] setupVariant:variantName];

    [self checkSelectedVariant];
}

- (void)disableOnusWunsler {
    if (![self.onusWunslerCell viewWithTag:10]) {
        self.onusOverlay = [[NSBundle mainBundle] loadNibNamed:@"CellPurchaseOverlay" owner:self options:nil][0];
        CGRect frame = CGRectMake(0, 0, [self.onusWunslerCell frame].size.width, [self.onusWunslerCell frame].size.height);
        [self.onusOverlay setFrame:frame];
        [self.onusWunslerCell addSubview:self.onusOverlay];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.variantMapping = @{@0 : @"Standard", @1 : @"Novice", @2 : @"Onus-Wunsler"};
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