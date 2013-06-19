/**
 * Copyright Maarten Billemont (http://www.lhunath.com, lhunath@lyndir.com)
 *
 * See the enclosed file LICENSE for license information (LASGPLv3).
 *
 * @author   Maarten Billemont <lhunath@lyndir.com>
 * @license  Lesser-AppStore General Public License
 */

//
//  NSURL(UbiquityStoreManager)
//
//  Created by lhunath on 2013-05-08.
//  Copyright, lhunath (Maarten Billemont) 2013. All rights reserved.
//

#import "NSURL+UbiquityStoreManager.h"

@implementation NSURL(UbiquityStoreManager)

- (BOOL)downloadUbiquitousContent {

    do {
        // We use CF API here because it gives us complete control over resetting the property cache.
        // Without this, we sometimes land in an infinite "downloading" loop.
        // I've seen at least one instance where we get stuck in an infinite "downloading" loop without any download actually progressing
        // while the data is already present, which was resolved only by .. rebooting the device.
        CFURLRef cfSelf = (__bridge CFURLRef)(self);
        CFURLClearResourcePropertyCache( cfSelf );
        NSDictionary *properties = (__bridge_transfer NSDictionary *)CFURLCopyResourcePropertiesForKeys( cfSelf, (__bridge CFArrayRef)@[
                NSURLIsUbiquitousItemKey,
                NSURLUbiquitousItemHasUnresolvedConflictsKey,
                NSURLUbiquitousItemIsDownloadedKey,
                NSURLUbiquitousItemIsDownloadingKey
        ], NULL );
        if (!properties)
                // No resources available for this URL: resource doesn't exist.
            return NO;

        if (![properties[NSURLIsUbiquitousItemKey] boolValue])
                // URL is not ubiquitous: no need to wait for it.
            return YES;

        if ([properties[NSURLUbiquitousItemIsDownloadedKey] boolValue])
                // URL is downloaded: done waiting for it.
            return YES;

        if ([properties[NSURLUbiquitousItemHasUnresolvedConflictsKey] boolValue])
                // URL is in conflict: its data is present, just needs resolution.
            return YES;

        if (![properties[NSURLUbiquitousItemIsDownloadingKey] boolValue] &&
            ![[NSFileManager defaultManager] startDownloadingUbiquitousItemAtURL:self error:nil])
                // Couldn't start downloading URL: resource probably disappeared.
            return NO;

        [NSThread sleepForTimeInterval:0.1];
    } while (YES);
}

@end
