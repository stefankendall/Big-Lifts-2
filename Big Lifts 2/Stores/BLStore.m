#import "BLStore.h"
#import "ContextManager.h"

@implementation BLStore

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]
                addObserver:self
                   selector:@selector(contentChange:)
                       name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                     object:nil];
    }

    return self;
}


- (void)contentChange:(NSNotification *)note {
    [[ContextManager context] mergeChangesFromContextDidSaveNotification:note];
}

- (void)empty {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[[ContextManager model] entitiesByName] objectForKey:[self modelName]];
    [request setEntity:entity];
    for (NSManagedObject *object in [[ContextManager context] executeFetchRequest:request error:nil]) {
        [[ContextManager context] deleteObject:object];
    }
}

- (NSString *)modelName {
    [NSException raise:NSInternalInconsistencyException format:@"modelName must be set in store"];
}

- (id) first {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [[[ContextManager  model] entitiesByName] objectForKey:[self modelName]];
    [request setEntity:e];

    NSError *error;
    NSArray *result = [[ContextManager context] executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"%@", [error localizedDescription]];
    }

    if ([result count] == 0) {
        return nil;
    }
    else {
        return result[0];
    }
}

@end