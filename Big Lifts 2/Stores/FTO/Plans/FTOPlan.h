#import <Foundation/Foundation.h>

@class Lift;

@protocol FTOPlan <NSObject>
- (NSDictionary *)generate:(Lift *)lift;

- (NSArray *)deloadWeeks;

- (NSArray *)incrementMaxesWeeks;

- (NSArray *)weekNames;
@end