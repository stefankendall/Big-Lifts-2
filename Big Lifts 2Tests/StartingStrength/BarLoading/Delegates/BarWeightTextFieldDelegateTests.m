#import "BarWeightTextFieldDelegateTests.h"
#import "Bar.h"
#import "BLStore.h"
#import "BarStore.h"
#import "BarWeightTextFieldDelegate.h"

@implementation BarWeightTextFieldDelegateTests

- (void)testBarWeightCanBeChanged {
    UITextField *textField = [UITextField new];
    [textField setText:@"33"];
    [[BarWeightTextFieldDelegate new] textFieldDidEndEditing:textField];

    Bar *bar = [[BarStore instance] first];
    STAssertEquals( [bar.weight doubleValue], 33.0, @"");
}

@end