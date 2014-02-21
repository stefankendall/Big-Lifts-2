#import "JDataHelper.h"
#import "BLJStore.h"
#import "BLKeyValueStore.h"

@implementation JDataHelper

+ (NSArray *)read:(BLJStore *)store {
    NSArray *jsonArray = [[BLKeyValueStore store] objectForKey:[store keyNameForStore]];
    NSMutableArray *objects = [@[] mutableCopy];
    if ([jsonArray count] > 0) {
        for (NSString *json in jsonArray) {
            [objects addObject:[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                               options:NSJSONReadingMutableContainers
                                                                 error:nil]];
        }
    }
    return objects;
}

+ (void)write:(BLJStore *)store values:(NSArray *)values {
    NSMutableArray *jsonArray = [@[] mutableCopy];
    for (id obj in values) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:nil error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [jsonArray addObject:jsonString];
    }
    [[BLKeyValueStore store] setObject:jsonArray forKey:[store keyNameForStore]];
}


@end