#import "JSONModel/JSONModel.h"

@interface JLift : JSONModel

@property(nonatomic) NSString *name;
@property(nonatomic) NSDecimalNumber<Optional> *weight;
@property(nonatomic) NSNumber<Optional> *order;
@property(nonatomic) NSDecimalNumber<Optional> *increment;
@property(nonatomic) BOOL usesBar;

@end