@class BLJStore;

@interface JDataHelper : NSObject

+ (NSArray *)read:(BLJStore *)store fromStore:(id)mainStore;

+ (void)write:(BLJStore *)store values:(NSArray *)values forStore:(id)mainStore;

@end