#import "CrashCounter.h"

@implementation CrashCounter

static NSString *crashKey = @"crashCount";

+ (void)incrementCrashCounter {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:crashKey]) {
        [userDefaults setInteger:1 forKey:crashKey];
    }
    else {
        int currentCount = [userDefaults integerForKey:crashKey];
        [userDefaults setInteger:(currentCount + 1) forKey:crashKey];
    }
}

+ (int)crashCount {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:crashKey]){
        return [defaults integerForKey:crashKey];
    }
    return 0;
}

+ (void)resetCrashCounter {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:crashKey];
}

@end