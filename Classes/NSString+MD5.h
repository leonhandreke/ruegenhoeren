//
//  NSString+MD5.h
//  ruegenhoeren
//
//  Created by Leon on 11/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


@interface NSString (MD5)

- (NSString *) md5Hash;

@end
