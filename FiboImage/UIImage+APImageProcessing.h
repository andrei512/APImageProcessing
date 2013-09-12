//
//  UIImage+APImageProcessing.h
//  FiboImage
//
//  Created by Andrei on 9/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageProcessingBlock)(unsigned char *rawData, int width, int height);

#define rgbaForIndex(byteIndex)						\
CGFloat red   = (rawData[byteIndex]     * 1.0);		\
CGFloat green = (rawData[byteIndex + 1] * 1.0);		\
CGFloat blue  = (rawData[byteIndex + 2] * 1.0);		\
CGFloat alpha = (rawData[byteIndex + 3] * 1.0);		\
red   = red   / 255.0;								\
green = green / 255.0;								\
blue  = blue  / 255.0;								\
alpha = alpha / 255.0;
						
#define redForIndex(byteIndex) rawData[byteIndex]
#define greenForIndex(byteIndex) rawData[byteIndex + 1]
#define blueForIndex(byteIndex) rawData[byteIndex + 2]
#define alphaForIndex(byteIndex) rawData[byteIndex + 3]

#define redForIndexInContex(byteIndex, imageContext) imageContext[byteIndex]
#define greenForIndexInContex(byteIndex, imageContext) imageContext[byteIndex + 1]
#define blueForIndexInContex(byteIndex, imageContext) imageContext[byteIndex + 2]
#define alphaForIndexInContex(byteIndex, imageContext) imageContext[byteIndex + 3]

#define idx(X, Y) ((bytesPerRow * (Y)) + (X) * bytesPerPixel) 

@interface UIImage (APImageProcessing)

// use rgbaForIndex(byteIndex) :)
+ (UIImage *)processImage:(UIImage*)image with:(ImageProcessingBlock)filter;


@end
