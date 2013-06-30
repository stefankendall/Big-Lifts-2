#import "BarWeightTextFieldDelegate.h"
#import "BarStore.h"
#import "Bar.h"

@implementation BarWeightTextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *newWeight = [textField text];
    Bar *bar = [[BarStore instance] first];
    bar.weight = [NSNumber numberWithDouble:[newWeight doubleValue]];
}

@end