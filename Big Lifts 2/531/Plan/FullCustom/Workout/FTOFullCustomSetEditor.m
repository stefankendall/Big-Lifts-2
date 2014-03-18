#import <FlurrySDK/Flurry.h>
#import "FTOFullCustomSetEditor.h"
#import "JSet.h"

@implementation FTOFullCustomSetEditor

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_FullCustom_SetEditor"];

    [self.amrapSwitch setOn:self.set.amrap];
    [self.warmupSwitch setOn:self.set.warmup];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.amrapSwitch addTarget:self action:@selector(valuesChanged:) forControlEvents:UIControlEventValueChanged];
    [self.warmupSwitch addTarget:self action:@selector(valuesChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)valuesChanged:(id)valuesChanged {
    self.set.amrap = [self.amrapSwitch isOn];
    self.set.warmup = [self.warmupSwitch isOn];
}

@end