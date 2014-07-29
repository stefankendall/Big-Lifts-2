#import "JSONModel/JSONModel.h"

extern const int NOT_DEAD;
extern const int DEAD;

@interface JModel : JSONModel

@property(nonatomic, copy) NSString *uuid;
@property(nonatomic) NSNumber<Ignore> *dead;

- (NSArray *)cascadeDeleteProperties;

@end