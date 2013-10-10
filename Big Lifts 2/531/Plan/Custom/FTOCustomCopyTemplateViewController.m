#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "FTOCustomCopyTemplateViewController.h"
#import "FTOVariant.h"

@implementation FTOCustomCopyTemplateViewController

- (void)viewDidLoad {
    self.rowCellMapping = @{
            @0 : self.standard,
            @1 : self.pyramid,
            @2 : self.joker,
            @3 : self.advanced
    };

    self.variantCellMapping = @{
            FTO_VARIANT_STANDARD : self.standard,
            FTO_VARIANT_PYRAMID : self.pyramid,
            FTO_VARIANT_JOKER : self.joker,
            FTO_VARIANT_SIX_WEEK : self.advanced
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *variant = [self variantForRow:[indexPath row]];
}

- (NSString *)variantForRow:(NSInteger)row {
    NSLog(@"%d", row);
    __block UITableViewCell *cell = nil;
    [self.rowCellMapping each:^(NSNumber *key, UITableViewCell *rowCell) {
        if (row == [key intValue]) {
            cell = rowCell;
        }
    }];

    return [self.variantCellMapping detect:^BOOL(NSString *variant, UITableViewCell *rowCell) {
        return cell == rowCell;
    }];
}


@end