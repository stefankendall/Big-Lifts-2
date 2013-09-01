@protocol SetWeightDelegate;

@interface SJSetWeightViewController : UITableViewController <UITextFieldDelegate> {
}

@property(weak, nonatomic) IBOutlet UITextField *weightField;
@property(nonatomic, strong) NSObject <SetWeightDelegate> *delegate;
@property(nonatomic, strong) NSDecimalNumber *weight;
@end