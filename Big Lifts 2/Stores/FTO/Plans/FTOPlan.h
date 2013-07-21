#import <Foundation/Foundation.h>

@class Lift;

@protocol FTOPlan <NSObject>
-(NSDictionary *) generate: (Lift *) lift;
@end