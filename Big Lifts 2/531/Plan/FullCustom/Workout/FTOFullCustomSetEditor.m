#import <FlurrySDK/Flurry.h>
#import "FTOFullCustomSetEditor.h"
#import "JSet.h"
#import "PaddingTextField.h"
#import "DecimalNumberHelper.h"

@implementation FTOFullCustomSetEditor

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Flurry logEvent:@"5/3/1_FullCustom_SetEditor"];

    [self.reps setText:[NSString stringWithFormat:@"%@", self.set.reps]];
    [self.percentage setText:[NSString stringWithFormat:@"%@", self.set.percentage]];
    [self.amrapSwitch setOn:self.set.amrap];
    [self.warmupSwitch setOn:self.set.warmup];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.reps setDelegate:self];
    [self.percentage setDelegate:self];
    [self.amrapSwitch addTarget:self action:@selector(valuesChanged:) forControlEvents:UIControlEventValueChanged];
    [self.warmupSwitch addTarget:self action:@selector(valuesChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)valuesChanged:(id)valuesChanged {
    self.set.reps = [NSNumber numberWithInt:[[self.reps text] intValue]];
    self.set.percentage = [DecimalNumberHelper nanTo0:[NSDecimalNumber decimalNumberWithString:[self.percentage text]]];
    self.set.amrap = [self.amrapSwitch isOn];
    self.set.warmup = [self.warmupSwitch isOn];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self valuesChanged:textField];
}

@end