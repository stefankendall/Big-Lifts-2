#import "AddPlateViewController.h"
#import "PlateStore.h"
#import "Plate.h"
#import "TextViewInputAccessoryBuilder.h"
#import "TextFieldCell.h"

@interface AddPlateViewController ()
@property(nonatomic, strong) NSDictionary *formCells;
@end

@implementation AddPlateViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self resetForm];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.weightTextField setDelegate:self];
    [self.countTextField setDelegate:self];

    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.weightTextField];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.countTextField];
}

- (void)resetForm {
    [self.saveButton setEnabled:NO];
    [self.weightTextField setText:@""];
    [self.countTextField setText:@""];
}

- (IBAction)saveTapped:(id)button {
    Plate *p = [[PlateStore instance] create];
    p.weight = [NSDecimalNumber decimalNumberWithString:[self.weightTextField text]];
    p.count = [NSNumber numberWithInt:[[self.countTextField text] intValue]];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    BOOL invalid = [[self.weightTextField text] isEqualToString:@""] || [[self.countTextField text] isEqualToString:@""];
    [self.saveButton setEnabled:!invalid];
}


@end