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

#import <Foundation/Foundation.h>

@interface NSURL(UbiquityStoreManager)

/** Starts downloading of the ubiquitous content for this URL if it isn't locally available yet, and blocks until it is.
*
 *  @return YES when the URL's contents is available locally.  NO when there is no resource for the URL.
 */
- (BOOL)downloadUbiquitousContent;

@end
