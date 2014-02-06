@interface FTOCustomCopyTemplateViewController : UITableViewController {
}
@property(nonatomic, strong) NSDictionary *textToVariant;
@property(nonatomic, strong) NSDictionary *iapVariants;
@property(nonatomic, strong) NSArray *orderedVariants;

- (NSArray *)purchasedOrderedVariants;
@end