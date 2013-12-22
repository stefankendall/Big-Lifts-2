#import "FTOCustomAssistanceEditSetViewController.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JSet.h"
#import "FTOCustomAssistanceEditLiftViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "PaddingTextField.h"

@implementation FTOCustomAssistanceEditSetViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.percentageTextField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.repsTextField];
    [self.percentageTextField setDelegate:self];
    [self.repsTextField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL hasLifts = [[JFTOCustomAssistanceLiftStore instance] count] > 0;
    [self.addLiftButton setHidden:hasLifts];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateSet];
}

- (void)updateSet {
    self.set.percentage = [NSDecimalNumber decimalNumberWithString:[self.percentageTextField text]];
    self.set.reps = [NSNumber numberWithInt:[[self.repsTextField text] intValue]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ftoCustomAsstEditSetAddLift"]) {
        self.set.lift = [[JFTOCustomAssistanceLiftStore instance] create];
        FTOCustomAssistanceEditLiftViewController *controller = [segue destinationViewController];
        controller.lift = (id) self.set.lift;
    }
}

@end