#import "BLTableViewController.h"

@protocol AssistanceCopyDelegate;

@interface FTOAssistanceCopyTemplateViewController : BLTableViewController

@property(nonatomic, strong) NSDictionary *variantToText;
@property(nonatomic, strong) NSArray *orderedVariants;
@property(nonatomic, strong) NSDictionary *iapVariants;
@property(nonatomic, strong) NSObject <AssistanceCopyDelegate> *delegate;
@end