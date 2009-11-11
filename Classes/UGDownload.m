//
//  UGDownload.m
//  ruegenhoeren
//
//  Created by Leon on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGDownload.h"


@implementation UGDownload

@synthesize request, delegate, destination, receivedLength;


- (UGDownload *) initWithRequest: (NSURLRequest *) newRequest destination: (NSString *) newDestination delegate: (id) newDelegate {
    if ( self = [super init]) {
        [self setRequest: newRequest];
        [self setDelegate: newDelegate];
        [self setDestination: [newDestination stringByAppendingPathExtension:@"download"]];
        // Make sure the directory is there
        [[NSFileManager defaultManager] createDirectoryAtPath: [self destination] withIntermediateDirectories: YES attributes: nil error: nil];
        // Delete the old file in case it's still there
        [[NSFileManager defaultManager] removeItemAtPath: newDestination error: nil];
    }
    
    return self;
}

- (double) progress {
    return receivedLength / totalLength;
}

- (void) start {
    connection = [NSURLConnection connectionWithRequest:[self request] delegate: self];
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
    
    //DebugLog([self destination]);
    if( [manager fileExistsAtPath: [self destination]] )
    {
        [manager removeItemAtPath:[self destination] error:nil];
    }
    [manager createFileAtPath: [self destination] contents:nil attributes:nil];
    fileHandle = [[NSFileHandle fileHandleForWritingAtPath:[self destination]] retain];
    
    downloadedData = [[NSMutableData alloc] init];
    
    totalLength = [response expectedContentLength];
    receivedLength = 0;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //DebugLog(@"Received Data of length %d from connection", [data length]);
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
        [downloadedData release];
        downloadedData = [[NSMutableData alloc] init];
    }
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [fileHandle writeData: downloadedData];
    [downloadedData release];
    downloadedData = nil;
    
    //Move the file to it's 'complete' location
    [[NSFileManager defaultManager] moveItemAtPath: [self destination] toPath: [[self destination] stringByDeletingPathExtension] error: nil];
    
    if( [delegate respondsToSelector:@selector(downloadDidFinish:)] )
    {
        [delegate downloadDidFinish: self];
    }
    
}

@end
