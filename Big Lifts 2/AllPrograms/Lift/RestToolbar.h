#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@protocol ShareDelegate;

@interface RestToolbar : CTCustomTableViewCell <UIActionSheetDelegate> {
}
@property(weak, nonatomic) IBOutlet UIButton *timerButton;

@property(weak, nonatomic) IBOutlet UIButton *shareButton;
@property(nonatomic, strong) UIViewController <ShareDelegate> *shareDelegate;

- (void)updateTime;
@end