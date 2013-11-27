@class JLift;

@protocol JFTOPlan <NSObject>
- (NSDictionary *)generate:(JLift *)lift;

- (NSArray *)deloadWeeks;

- (NSArray *)incrementMaxesWeeks;

- (NSArray *)weekNames;
@end