#import "FTOEditLogViewController.h"
#import "TextViewInputAccessoryBuilder.h"
#import "WorkoutLog.h"

@implementation FTOEditLogViewController

- (void)viewDidLoad {
    UIDatePicker *datePicker = [UIDatePicker new];
    [datePicker setDate:self.workoutLog.date];
    [self.dateField setInputView:datePicker];
    [datePicker addTarget:self action:@selector(updateWorkoutLog:) forControlEvents:UIControlEventValueChanged];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.dateField];
    [self.deloadSwitch addTarget:self action:@selector(updateWorkoutLog:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateDateFieldText];
}

- (void)updateWorkoutLog:(id)sender {
    UIDatePicker *picker = (UIDatePicker *) self.dateField.inputView;
    self.workoutLog.date = picker.date;
    self.workoutLog.deload = [self.deloadSwitch isOn];

    [self updateDateFieldText];
}

- (void)updateDateFieldText {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateField setText:[dateFormatter stringFromDate:self.workoutLog.date]];
}

@end