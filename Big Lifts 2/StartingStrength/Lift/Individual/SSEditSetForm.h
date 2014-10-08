#import "BLTableViewController.h"

@class JSet;
@class PaddingTextField;
@protocol SetChangeDelegate;
@class SetChange;

@interface SSEditSetForm : BLTableViewController <UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet PaddingTextField *weightField;
@property(weak, nonatomic) IBOutlet PaddingTextField *repsField;

@property(nonatomic, strong) JSet *set;
@property(nonatomic, strong) SetChange *previousChange;
@property(nonatomic, strong) NSObject <SetChangeDelegate> *delegate;
@end