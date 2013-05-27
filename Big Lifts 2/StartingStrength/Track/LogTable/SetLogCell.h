#import "CustomTableViewCell.h"

@class Set;

extern int const SET_LOG_CELL_HEIGHT;

@interface SetLogCell : CustomTableViewCell

@property(nonatomic, strong) Set *set;

- (void)setSet:(Set *)set;
@end