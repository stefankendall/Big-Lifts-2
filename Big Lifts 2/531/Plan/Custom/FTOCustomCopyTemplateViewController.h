@interface FTOCustomCopyTemplateViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UITableViewCell *standard;
@property (weak, nonatomic) IBOutlet UITableViewCell *pyramid;
@property (weak, nonatomic) IBOutlet UITableViewCell *joker;
@property (weak, nonatomic) IBOutlet UITableViewCell *advanced;

@property(nonatomic, strong) NSDictionary *rowCellMapping;
@property(nonatomic, strong) NSDictionary *variantCellMapping;

- (NSString *)variantForRow:(NSInteger)row;
@end