#import "PaddingTextField.h"

@class FTOBoringButBigEditCell;

@interface PaddingRowTextField : PaddingTextField
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, strong) UITableViewCell *cell;
@end