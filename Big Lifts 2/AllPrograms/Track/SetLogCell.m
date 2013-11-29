#import "SetLogCell.h"
#import "JSetLog.h"
#import "Settings.h"
#import "SettingsStore.h"

@implementation SetLogCell

int const SET_LOG_CELL_HEIGHT = 30;

- (void)setSetLog:(JSetLog *)setLog {
    _setLog = setLog;

    [self.liftNameLabel setText:[self.setLog name]];
    int reps = [[self.setLog reps] intValue];
    if (reps > 0) {
        [self.repsLabel setText:[NSString stringWithFormat:@"%dx", reps]];
    }
    else {
        [self.repsLabel setText:@""];
    }

    Settings *settings = [[SettingsStore instance] first];
    NSString *weightText = [NSString stringWithFormat:@"%@ %@", [self.setLog weight], [settings units]];
    [self.weightLabel setText:weightText];
}

@end