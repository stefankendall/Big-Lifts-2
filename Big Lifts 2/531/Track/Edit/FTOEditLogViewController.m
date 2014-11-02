#import "FTOEditLogViewController.h"
#import "JWorkoutLog.h"

@implementation FTOEditLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.deloadSwitch addTarget:self action:@selector(updateWorkoutLog:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.deloadSwitch setOn:self.workoutLog.deload];
}

- (void)updateWorkoutLog:(id)sender {
    [super updateWorkoutLog:sender];
    self.workoutLog.deload = [self.deloadSwitch isOn];
}

@end