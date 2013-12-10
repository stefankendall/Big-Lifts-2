#import <Foundation/Foundation.h>

@protocol TimerObserver <NSObject>

-(void) timerTick;

@end