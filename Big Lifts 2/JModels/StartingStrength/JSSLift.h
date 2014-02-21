#import "JLift.h"

@interface JSSLift : JLift

@property(nonatomic, strong) NSString<Optional> *customName;

- (NSString *)effectiveName;
@end