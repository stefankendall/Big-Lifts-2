@interface Migrator : NSObject
- (void)migrateStores;

- (NSArray *)sortedKeys:(NSDictionary *)migrations;
@end