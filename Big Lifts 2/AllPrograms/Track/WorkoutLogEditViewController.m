#import "WorkoutLogEditViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"

@implementation WorkoutLogEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Log";
    self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteButtonTapped:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor redColor]];

    UIDatePicker *datePicker = [UIDatePicker new];
    if (self.workoutLog.date == nil) {
        [datePicker setDate:[NSDate new]];
    }
    else {
        [datePicker setDate:self.workoutLog.date];
    }
    [self.dateField setInputView:datePicker];
    [datePicker addTarget:self action:@selector(updateWorkoutLog:) forControlEvents:UIControlEventValueChanged];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.dateField];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateDateFieldText];
}

- (void)updateWorkoutLog:(id)sender {
    UIDatePicker *picker = (UIDatePicker *) self.dateField.inputView;
    self.workoutLog.date = picker.date;
    [self updateDateFieldText];
}

- (void)updateDateFieldText {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateField setText:[dateFormatter stringFromDate:self.workoutLog.date]];
}

- (void)deleteButtonTapped:(id)sender {
    [[JWorkoutLogStore instance] remove:self.workoutLog];
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end