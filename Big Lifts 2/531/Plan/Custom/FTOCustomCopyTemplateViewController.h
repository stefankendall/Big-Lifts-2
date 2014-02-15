#import "BLTableViewController.h"

@interface FTOCustomCopyTemplateViewController : BLTableViewController {
}
@property(nonatomic, strong) NSDictionary *textToVariant;
@property(nonatomic, strong) NSDictionary *iapVariants;
@property(nonatomic, strong) NSArray *orderedVariants;

- (NSArray *)purchasedOrderedVariants;
@end