#import "SetLogCell.h"
#import "SetLog.h"
#import "Settings.h"
#import "SettingsStore.h"
#import "SetLogContainer.h"

@implementation SetLogCell

int const SET_LOG_CELL_HEIGHT = 30;

- (void)setSetLogContainer:(SetLogContainer *)setLogContainer {
    self.setLog = setLogContainer.setLog;
    [self.liftNameLabel setText:[self.setLog name]];
    [self.setsLabel setText:[NSString stringWithFormat:@"%dx", setLogContainer.count]];
    int reps = [[self.setLog reps] intValue];
    if (reps > 0) {
        [self.repsLabel setText:[NSString stringWithFormat:@"%d", reps]];
    }
    else {
        [self.repsLabel setText:@""];
    }

    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [NSString stringWithFormat:@"%@ %@", [self.setLog weight], [settings units]];
    [self.weightLabel setText:weightText];
}

@end