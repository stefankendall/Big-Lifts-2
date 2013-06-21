#import "SSWorkoutVariantController.h"
#import "SSWorkoutStore.h"
#import "NSDictionaryMutator.h"
#import "SSVariantStore.h"
#import "SSVariant.h"

@interface SSWorkoutVariantController ()

@property(nonatomic, strong) NSDictionary *variantMapping;
@end

@implementation SSWorkoutVariantController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *variantName = [self.variantMapping objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
    [[SSWorkoutStore instance] setupVariant:variantName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.variantMapping = @{@0 : @"Standard", @1 : @"Novice"};
    [self checkSelectedVariant];
}

- (void)checkSelectedVariant {
    SSVariant *variant = [[SSVariantStore instance] first];
    int index = [[[NSDictionaryMutator new] invert:self.variantMapping][variant.name] intValue];
    UITableViewCell *cell = [self tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UIButton *button = (UIButton *) [cell viewWithTag:1];
    [button setHidden:NO];
}


@end