//
//  UIImage+Scale.h
//  ruegenhoeren
//
//  Created by Leon on 11/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (INResizeImageAllocator)
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
- (UIImage*)scaleImageToSize:(CGSize)newSize;
@end
