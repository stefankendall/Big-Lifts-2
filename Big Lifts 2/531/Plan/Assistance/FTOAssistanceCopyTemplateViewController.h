@interface FTOAssistanceCopyTemplateViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UITableViewCell *noAssistanceCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bbbAssistanceCell;

@property(nonatomic, strong) NSDictionary *variantToText;
@property(nonatomic, strong) NSArray *orderedVariants;
@property(nonatomic, strong) NSDictionary *iapVariants;
@end