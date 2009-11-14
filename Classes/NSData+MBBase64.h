//
//  NSData+MBBase64.m
//  ruegenhoeren
//
//  Created by Leon on 11/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSData+MBBase64.h"

@interface NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;
@end
