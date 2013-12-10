@class PaddingTextField;
@protocol TimerProtocol;

@interface TimerViewController : UITableViewController {
}
@property(weak, nonatomic) IBOutlet PaddingTextField *restMinutes;
@property(weak, nonatomic) IBOutlet PaddingTextField *restSeconds;

@end