#import <Foundation/Foundation.h>

@protocol AssistanceCopyDelegate <NSObject>

-(void) copyAssistance: (NSString *)variant;

@end