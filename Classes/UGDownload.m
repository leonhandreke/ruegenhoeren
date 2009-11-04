//
//  UGDownload.m
//  ruegenhoeren
//
//  Created by Leon on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGDownload.h"


@implementation UGDownload

@synthesize request, delegate, destination;


- (UGDownload *) initWithRequest: (NSURLRequest *) newRequest destination: (NSString *) newDestination delegate: (id) newDelegate {
    if ( self = [super init]) {
        [self setRequest: newRequest];
        [self setDelegate: newDelegate];
        [self setDestination: newDestination];
    }
    
    return self;
}

- (double) progress {

}

- (double) lengthReceived {

}

- (void) start {
    connection = [NSURLConnection connectionWithRequest:[self request] delegate: [self delegate]];
    [connection start];
}

- (void) cancel {
    [connection cancel];
    [fileHandle closeFile];
    [[NSFileManager defaultManager] removeItemAtPath: [self destination] error: nil];
}


#pragma mark  NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    NSFileManager *manager = [NSFileManager defaultManager];
    
    if( [manager fileExistsAtPath:[self destination]] )
    {
        [manager removeItemAtPath:[self destination] error:nil];
    }
    [manager createFileAtPath: [self destination] contents:nil attributes:nil];
    fileHandle = [[NSFileHandle fileHandleForWritingAtPath:[self destination]] retain];
    
    downloadedData = [NSMutableData data];
    
    totalLength = [response expectedContentLength];
    receivedLength = 0;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [downloadedData appendData:data];
    receivedLength += data.length;
    //NSTimeInterval elapsedTime = -[startTime timeIntervalSinceNow];
    
    if( [delegate respondsToSelector:@selector(download:didReceiveDataOfLength:)] )
    {
        [delegate download: self didReceiveDataOfLength: data.length];
    }
    //can't keep too much data in memory. Write it to disk to avoid getting low memory error.
    if( downloadedData.length > 1048576 && fileHandle != nil )
    {
        [fileHandle writeData: downloadedData];
        downloadedData = [NSMutableData data];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [fileHandle writeData: downloadedData];
    downloadedData = nil;
    if( [delegate respondsToSelector:@selector(downloadDidFinish:)] )
    {
        [delegate downloadDidFinish: self];
    }
    
}

@end
