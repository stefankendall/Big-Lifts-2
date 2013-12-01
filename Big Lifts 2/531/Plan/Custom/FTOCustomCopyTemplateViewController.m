#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOCustomCopyTemplateViewController.h"
#import "JFTOVariant.h"
#import "FTOCustomWorkoutStore.h"
#import "Purchaser.h"
#import "IAPAdapter.h"
#import "FTOVariant.h"

@implementation FTOCustomCopyTemplateViewController

- (void)viewDidLoad {
    self.textToVariant = @{
            @"Standard" : FTO_VARIANT_STANDARD,
            @"Pyramid" : FTO_VARIANT_PYRAMID,
            @"5/3/1 with Joker" : FTO_VARIANT_JOKER,
            @"Advanced 5/3/1" : FTO_VARIANT_ADVANCED
    };

    self.orderedVariants = @[
            @"Standard",
            @"Pyramid",
            @"5/3/1 with Joker",
            @"Advanced 5/3/1"
    ];

    self.iapVariants = @{
            FTO_VARIANT_ADVANCED : IAP_FTO_ADVANCED,
            FTO_VARIANT_JOKER : IAP_FTO_JOKER
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self purchasedOrderedVariants] count];
}

- (NSArray *)purchasedOrderedVariants {
    return [self.orderedVariants select:^BOOL(NSString *text) {
        NSString *variant = self.textToVariant[text];
        if ([[self.iapVariants allKeys] containsObject:variant]) {
            return [[IAPAdapter instance] hasPurchased:self.iapVariants[variant]];
        }
        else {
            return YES;
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FTOCustomCopyTemplateCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FTOCustomCopyTemplateCell"];
    }
    [cell.textLabel setText:self.purchasedOrderedVariants[(NSUInteger) [indexPath row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.purchasedOrderedVariants[(NSUInteger) [indexPath row]];
    NSString *variant = self.textToVariant[text];
    [[FTOCustomWorkoutStore instance] setupVariant:variant];
    [self.navigationController popViewControllerAnimated:YES];
}

@end