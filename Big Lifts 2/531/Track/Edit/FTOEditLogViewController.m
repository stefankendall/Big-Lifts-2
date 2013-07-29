#import "FTOEditLogViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "WorkoutLog.h"

@implementation FTOEditLogViewController

- (void)viewDidLoad {
    UIDatePicker *datePicker = [UIDatePicker new];
    [datePicker setDate:self.workoutLog.date];
    [self.dateField setInputView:datePicker];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.dateField];
    [self updateDateFieldText];
}

- (void)updateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker *) self.dateField.inputView;
    self.workoutLog.date = picker.date;
    [self updateDateFieldText];
}

- (void)updateDateFieldText {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateField setText:[dateFormatter stringFromDate:self.workoutLog.date]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self emptyView];
}

@end