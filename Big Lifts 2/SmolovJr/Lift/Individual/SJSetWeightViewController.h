#import "BLTableViewController.h"

@protocol SetWeightDelegate;

@interface SJSetWeightViewController : BLTableViewController <UITextFieldDelegate> {
}

@property(weak, nonatomic) IBOutlet UITextField *weightField;
@property(nonatomic, strong) NSObject <SetWeightDelegate> *delegate;
@property(nonatomic, strong) NSDecimalNumber *weight;
@end