#import <MRCEnumerable/NSArray+Enumerable.h>
#import <FlurrySDK/Flurry.h>
#import "FTOCustomCopyTemplateViewController.h"
#import "JFTOVariant.h"
#import "JFTOCustomWorkoutStore.h"
#import "Purchaser.h"
#import "IAPAdapter.h"

@implementation FTOCustomCopyTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textToVariant = @{
            @"Standard" : FTO_VARIANT_STANDARD,
            @"Heavier" : FTO_VARIANT_HEAVIER,
            @"Powerlifting" : FTO_VARIANT_POWERLIFTING,
            @"Pyramid" : FTO_VARIANT_PYRAMID,
            @"First Set Last" : FTO_VARIANT_FIRST_SET_LAST,
            @"First Set Last Multiple Sets" : FTO_VARIANT_FIRST_SET_LAST_MULTIPLE_SETS,
            @"5/3/1 with Joker" : FTO_VARIANT_JOKER,
            @"Advanced 5/3/1" : FTO_VARIANT_ADVANCED
    };

    self.orderedVariants = @[
            @"Standard",
            @"Heavier",
            @"Powerlifting",
            @"Pyramid",
            @"First Set Last",
            @"First Set Last Multiple Sets",
            @"5/3/1 with Joker",
            @"Advanced 5/3/1"
    ];

    self.iapVariants = @{
            FTO_VARIANT_ADVANCED : IAP_FTO_ADVANCED,
            FTO_VARIANT_JOKER : IAP_FTO_JOKER
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [Flurry logEvent:@"5/3/1_Custom_Copy_Template"];
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
    [[JFTOCustomWorkoutStore instance] setupVariant:variant];
    [self.navigationController popViewControllerAnimated:YES];
}

@end