@class JSet;

@interface FTOFullCustomSetEditor : UITableViewController {
}

@property(weak, nonatomic) IBOutlet UISwitch *amrapSwitch;
@property(weak, nonatomic) IBOutlet UISwitch *warmupSwitch;

@property(nonatomic, strong) JSet *set;

- (void)valuesChanged:(id)valuesChanged;
@end