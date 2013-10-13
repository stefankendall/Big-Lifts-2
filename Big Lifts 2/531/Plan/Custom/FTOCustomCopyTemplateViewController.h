@interface FTOCustomCopyTemplateViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UITableViewCell *standard;
@property (weak, nonatomic) IBOutlet UITableViewCell *pyramid;
@property (weak, nonatomic) IBOutlet UITableViewCell *joker;
@property (weak, nonatomic) IBOutlet UITableViewCell *advanced;

@property(nonatomic, strong) NSDictionary *textToVariant;
@property(nonatomic, strong) NSDictionary *iapVariants;
@property(nonatomic, strong) NSArray *orderedVariants;

- (NSArray *)purchasedOrderedVariants;
@end