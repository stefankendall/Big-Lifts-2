/**
 * Copyright Maarten Billemont (http://www.lhunath.com, lhunath@lyndir.com)
 *
 * See the enclosed file LICENSE for license information (LASGPLv3).
 *
 * @author   Maarten Billemont <lhunath@lyndir.com>
 * @license  Lesser-AppStore General Public License
 */


#import "NSError+UbiquityStoreManager.h"

NSString *const UbiquityManagedStoreDidDetectCorruptionNotification = @"UbiquityManagedStoreDidDetectCorruptionNotification";

@implementation NSError(UbiquityStoreManager)

- (id)init_USM_WithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict {

    self = [self init_USM_WithDomain:domain code:code userInfo:dict];
    if ([domain isEqualToString:NSCocoaErrorDomain] && code == 134302) {
        if (![self handleError:self]) {
            NSLog( @"===" );
            NSLog( @"Detected unknown ubiquity import error." );
            NSLog( @"Please report this at http://lhunath.github.io/UbiquityStoreManager" );
            NSLog( @"and provide details of the conditions and whether or not you notice" );
            NSLog( @"any sync issues afterwards.  Error userInfo:" );
            for (id key in dict) {
                id value = [dict objectForKey:key];
                NSLog( @"[%@] %@ => [%@] %@", [key class], key, [value class], value );
            }
            NSLog( @"Error Debug Description:\n%@", [self debugDescription] );
            NSLog( @"===" );
        }
    }

    return self;
}

- (BOOL)handleError:(NSError *)error {

    if (!error)
        return NO;
    
    if ([error.domain isEqualToString:NSCocoaErrorDomain] && error.code == 1570) {
        // Severity: Critical To Cloud Content
        // Cause: Validation Error -- The object being imported does not pass model validation: It is corrupt.
        // (it passed model validation on the other device just fine since it got saved!).
        // Action: Mark corrupt, request rebuild.
        [[NSNotificationCenter defaultCenter] postNotificationName:UbiquityManagedStoreDidDetectCorruptionNotification object:self];
        return YES;
    }
    if ([(NSString *)[error.userInfo objectForKey:@"reason"] hasPrefix:@"Error reading the log file at location: (null)"]) {
        // Severity: Delayed Import?
        // Cause: Log file failed to download?
        // Action: Ignore.
        return YES;
    }

    if ([self handleError:[error.userInfo objectForKey:NSUnderlyingErrorKey]])
        return YES;
    if ([self handleError:[error.userInfo objectForKey:@"underlyingError"]])
        return YES;

    NSArray *errors = [error.userInfo objectForKey:@"NSDetailedErrors"];
    for (NSError *error_ in errors)
        if ([self handleError:error_])
            return YES;

    return NO;
}

@end
