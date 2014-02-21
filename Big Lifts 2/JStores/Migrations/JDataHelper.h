@class BLJStore;

@interface JDataHelper : NSObject

+ (NSArray *)read:(BLJStore *)store;

+ (void)write:(BLJStore *)store values:(NSArray *)values;

@end