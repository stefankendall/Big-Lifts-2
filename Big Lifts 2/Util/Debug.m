#import "Debug.h"

@implementation Debug

+ (void)time:(void (^)(void))someBlock {
    clock_t start = clock();
    someBlock();
    double executionTime = (double) (clock() - start) / CLOCKS_PER_SEC;
    NSLog(@"Time: %f", executionTime);
}


@end