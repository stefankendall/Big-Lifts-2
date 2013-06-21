#import "SSWorkoutVariantController.h"
#import "SSWorkoutStore.h"

@implementation SSWorkoutVariantController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *variantMapping = @{@0 : @"Standard", @1 : @"Novice"};
    NSString *variantName = [variantMapping objectForKey:[NSNumber numberWithInteger:[indexPath row]]];
    [[SSWorkoutStore instance] setupVariant:variantName];
}

@end