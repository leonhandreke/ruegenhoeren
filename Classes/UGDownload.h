//
//  UGDownload.h
//  ruegenhoeren
//
//  Created by Leon on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UGDownload : NSObject {

    id delegate;
    NSURLRequest *request;
    NSString *destination;
    
    NSURLConnection *connection;
    NSFileHandle *fileHandle;
    double totalLength;
    
    NSMutableData *downloadedData;
    double receivedLength;
    
}

- (UGDownload *) initWithRequest: (NSURLRequest *) newRequest destination: (NSString *) newDestination delegate: (id) newDelegate;

- (double) progress;
- (double) lengthReceived;

- (void) start;
- (void) cancel;


@property (assign) id delegate;
@property (copy) NSURLRequest *request;
@property (assign) NSString *destination;

@end