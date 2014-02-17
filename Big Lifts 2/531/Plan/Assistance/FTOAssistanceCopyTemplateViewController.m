#import "FTOAssistanceCopyTemplateViewController.h"
#import "JFTOAssistanceStore.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOAssistance.h"

@interface FTOAssistanceCopyTemplateViewController ()
@property(nonatomic, strong) NSArray *assistanceVariants;
@end

@implementation FTOAssistanceCopyTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assistanceVariants = @[
            FTO_ASSISTANCE_NONE,
            FTO_ASSISTANCE_BORING_BUT_BIG
    ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[JFTOCustomAssistanceWorkoutStore instance] copyTemplate:self.assistanceVariants[(NSUInteger) indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end