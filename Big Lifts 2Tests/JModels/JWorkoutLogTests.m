#import "JWorkoutLogTests.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"
#import "JSetLogStore.h"
#import "JSetLog.h"

@implementation JWorkoutLogTests

- (void)testDoesNotExportAssistance {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    JSetLog *setLog1 = [[JSetLogStore instance] createWithName:@"Bench" weight:N(100) reps:5 warmup:NO assistance:NO amrap:NO];
    JSetLog *setLog2 = [[JSetLogStore instance] createWithName:@"Bench" weight:N(100) reps:10 warmup:YES assistance:YES amrap:NO];
    [workoutLog addSet:setLog1];
    [workoutLog addSet:setLog2];

    STAssertEquals([workoutLog bestSet], setLog1, @"");
}

- (void)testSetLogsCascadeDelete {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    JSetLog *setLog1 = [[JSetLogStore instance] createWithName:@"Bench" weight:N(100) reps:5 warmup:YES assistance:NO amrap:NO];
    [workoutLog addSet:setLog1];

    [[JWorkoutLogStore instance] remove:workoutLog];
    STAssertEquals([[JSetLogStore instance] count], 0, @"");
}

- (void)testSerializesSetsAsUuids {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    JSetLog *setLog1 = [[JSetLogStore instance] createWithName:@"Bench" weight:N(100) reps:5 warmup:YES assistance:NO amrap:NO];
    [workoutLog addSet:setLog1];
    NSArray *serialized = [[JWorkoutLogStore instance] serialize];
    NSString *workoutLogJson = serialized[0];
    NSDictionary *deserialized = [NSJSONSerialization JSONObjectWithData: [workoutLogJson dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options: NSJSONReadingMutableContainers
                                                                   error: nil];
    NSArray *sets = deserialized[@"sets"];
    STAssertEqualObjects(sets[0], setLog1.uuid, @"");
}

- (void)testDeserializesUuidsAsSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    JSetLog *setLog1 = [[JSetLogStore instance] createWithName:@"Bench" weight:N(100) reps:5 warmup:YES assistance:NO amrap:NO];
    [workoutLog addSet:setLog1];
    NSArray *serialized = [[JWorkoutLogStore instance] serialize];
    NSString *workoutLogJson = serialized[0];

    JWorkoutLog *deserializedWorkoutLog = (JWorkoutLog *) [[JWorkoutLogStore instance] deserializeObject:workoutLogJson];
    STAssertEquals([deserializedWorkoutLog.sets count], 1U, @"");
    STAssertEquals(deserializedWorkoutLog.sets[0], setLog1, @"");
}

- (void)testSerializesAndDeserializesSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    JSetLog *setLog1 = [[JSetLogStore instance] createWithName:@"Bench" weight:N(100) reps:5 warmup:YES assistance:NO amrap:NO];
    JSetLog *setLog2 = [[JSetLogStore instance] createWithName:@"Bench" weight:N(120) reps:3 warmup:NO assistance:NO amrap:YES];
    [workoutLog addSet:setLog1];
    [workoutLog addSet:setLog2];

    [[JWorkoutLogStore instance] sync];
    [[JWorkoutLogStore instance] load];

    JWorkoutLog *syncedLog = [[JWorkoutLogStore instance] first];
    STAssertEquals([syncedLog.sets count], 2U, @"");

    JSetLog *syncedLog1 = syncedLog.orderedSets[0];
    STAssertEqualObjects(syncedLog1.name, @"Bench", @"");
    STAssertEqualObjects(syncedLog1.weight, N(100), @"");

    JSetLog *syncedLog2 = syncedLog.orderedSets[1];
    STAssertEqualObjects(syncedLog2.name, @"Bench", @"");
    STAssertEqualObjects(syncedLog2.weight, N(120), @"");
}

- (void)testWorkSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    JSetLog *warmup = [[JSetLogStore instance] create];
    warmup.warmup = YES;
    JSetLog *workout = [[JSetLogStore instance] create];
    workout.warmup = NO;
    [workoutLog.sets addObjectsFromArray:@[warmup, workout]];
    STAssertEquals([[workoutLog workSets] count], 1U, @"");
}

- (void)testFindsBestSetFromWorkoutLog {
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.weight = N(200);
    set1.reps = @3;

    JSetLog *set2 = [[JSetLogStore instance] create];
    set2.weight = N(220);
    set2.reps = @2;

    JSetLog *set3 = [[JSetLogStore instance] create];
    set3.weight = N(200);
    set3.reps = @4;

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    [workoutLog.sets addObjectsFromArray:@[set1, set2, set3]];

    STAssertEquals([workoutLog bestSet], set2, @"");
}

@end