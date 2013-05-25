#import "NSDictionaryMutator.h"

@implementation NSDictionaryMutator
- (NSDictionary *)invert:(NSDictionary *)dictionary {
    NSMutableDictionary *inverted = [@{} mutableCopy];
    for (id key in [dictionary allKeys]) {
        [inverted setObject:key forKey:[dictionary objectForKey:key]];
    }
    return inverted;
}
@end