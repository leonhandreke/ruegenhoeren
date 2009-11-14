//
//  UIImage+Scale.m
//  ruegenhoeren
//
//  Created by Leon on 11/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Scale.h"


@implementation UIImage (INResizeImageAllocator)
+ (UIImage*)imageWithImage:(UIImage*)image 
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    //NSLog(@"%d", [image retainCount]);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (UIImage*)scaleImageToSize:(CGSize)newSize
{
    return [UIImage imageWithImage:self scaledToSize:newSize];
}
@end