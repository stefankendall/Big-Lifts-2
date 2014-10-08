#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOAssistanceCopyTemplateViewController.h"
#import "JFTOAssistance.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "AssistanceCopyDelegate.h"

@implementation FTOAssistanceCopyTemplateViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.variantToText = @{
            FTO_ASSISTANCE_NONE : @"None",
            FTO_ASSISTANCE_BORING_BUT_BIG : @"Boring But Big",
            FTO_ASSISTANCE_TRIUMVIRATE : @"Triumvirate"
    };

    self.orderedVariants = @[
            FTO_ASSISTANCE_NONE,
            FTO_ASSISTANCE_BORING_BUT_BIG,
            FTO_ASSISTANCE_TRIUMVIRATE
    ];

    self.iapVariants = @{
            FTO_ASSISTANCE_TRIUMVIRATE : IAP_FTO_TRIUMVIRATE
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *assistance = self.purchasedOrderedVariants[(NSUInteger) indexPath.row];
    [self.delegate copyAssistance:assistance];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self purchasedOrderedVariants] count];
}

- (NSArray *)purchasedOrderedVariants {
    return [self.orderedVariants select:^BOOL(NSString *variant) {
        if ([[self.iapVariants allKeys] containsObject:variant]) {
            return [[IAPAdapter instance] hasPurchased:self.iapVariants[variant]];
        }
        else {
            return YES;
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOAssistanceCustomCopyTemplateCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOAssistanceCustomCopyTemplateCell"];
    }
    NSString *variant = self.purchasedOrderedVariants[(NSUInteger) [indexPath row]];
    [cell.textLabel setText:self.variantToText[variant]];
    return cell;
}

@end