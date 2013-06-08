#import "AddPlateViewController.h"
#import "PlateStore.h"
#import "Plate.h"

#define kFieldLabelTag 101

@interface AddPlateViewController ()
@property(nonatomic, strong) NSDictionary *formCells;
@end

@implementation AddPlateViewController

- (void)awakeFromNib {
    [self initializeForm];
}

- (void)initializeForm {
    self.form = [EZForm new];
    self.form.inputAccessoryType = EZFormInputAccessoryTypeStandard;
    [self.form setDelegate:self];

    EZFormTextField *weightField = [[EZFormTextField alloc] initWithKey:@"weight"];
    weightField.validationMinCharacters = 1;
    [self.form addFormField:weightField];

    EZFormTextField *countField = [[EZFormTextField alloc] initWithKey:@"count"];
    countField.validationMinCharacters = 1;
    [self.form addFormField:countField];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    EZFormTextField *weightFormField = [self.form formFieldForKey:@"weight"];
    [weightFormField useTextField:self.weightTextField];

    EZFormTextField *countFormField = [self.form formFieldForKey:@"count"];
    [countFormField useTextField:self.countTextField];

    [self.form autoScrollViewForKeyboardInput:self.tableView];

    self.formCells = @{@"weight" : self.weightCell, @"count" : self.countCell};
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self resetForm];
}

- (void)resetForm {
    [self.saveButton setEnabled:NO];
    [self.weightTextField setText:@""];
    [self.countTextField setText:@""];
}

- (IBAction)saveTapped:(id)button {
    double weight = [[self.weightTextField text] doubleValue];
    int count = [[self.countTextField text] intValue];
    Plate *p = [[PlateStore instance] create];
    p.weight = [NSNumber numberWithDouble:weight];
    p.count = [NSNumber numberWithInt:count];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateValidityIndicatorForField:(EZFormField *)formField {
    UITableViewCell *cell = [self.formCells valueForKey:[formField key]];
    UILabel *label = (UILabel *) [cell viewWithTag:kFieldLabelTag];
    if ([formField isValid]) {
        label.textColor = [UIColor blackColor];
        if ([label.text hasSuffix:@"*"]) {
            label.text = [label.text substringToIndex:[label.text length] - 1];
        }
    }
    else {
        label.textColor = [UIColor redColor];
        if (![label.text hasSuffix:@"*"]) {
            label.text = [label.text stringByAppendingString:@"*"];
        }
    }
}

- (void)form:(EZForm *)form didUpdateValueForField:(EZFormField *)formField modelIsValid:(BOOL)isValid {
    [self updateValidityIndicatorForField:formField];
    if ([form isFormValid]) {
        [self.saveButton setEnabled:YES];
    }
    else {
        [self.saveButton setEnabled:NO];
    }
}

@end