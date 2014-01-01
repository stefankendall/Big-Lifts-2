#import "JSVLiftStore.h"
#import "JSVLift.h"

@implementation JSVLiftStore

- (Class)modelClass {
    return JSVLift.class;
}

- (void)setupDefaults {
    [self createWithName:@"Squat" order:@0 usesBar:YES];
    [self createWithName:@"Lunges" order:@1 usesBar:NO];
    [self createWithName:@"Bulgarian Lunges" order:@2 usesBar:NO];

    [self createWithName:@"Squat Negative" order:@3 usesBar:YES];
    [self createWithName:@"Power Clean" order:@4 usesBar:YES];
    [self createWithName:@"Box Squat" order:@5 usesBar:YES];
}

- (void)createWithName: (NSString *)name order: (NSNumber *) order usesBar: (BOOL) bar {
    JSVLift *lift = [self create];
    lift.name = name;
    lift.order = order;
    lift.usesBar = bar;
}

@end