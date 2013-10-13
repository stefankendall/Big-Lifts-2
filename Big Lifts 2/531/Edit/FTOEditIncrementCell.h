#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@class RowTextField;

@interface FTOEditIncrementCell : CTCustomTableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *liftLabel;
@property(weak, nonatomic) IBOutlet RowTextField *increment;
@end