//
//  UIImage+APImageProcessing.m
//  FiboImage
//
//  Created by Andrei on 9/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "UIImage+APImageProcessing.h"

@implementation UIImage (APImageProcessing)

+ (UIImage *)processImage:(UIImage*)image with:(ImageProcessingBlock)filter {
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    filter(rawData, width, height);
    
    CIImage *ciimage = [CIImage imageWithBitmapData:[NSData dataWithBytes:rawData
                                                                   length:height * width * 4]
                                        bytesPerRow:bytesPerRow
                                               size:image.size
                                             format:kCIFormatRGBA8
                                         colorSpace:colorSpace];
    
    
    free(rawData);
    
    return [UIImage imageWithCIImage:ciimage];
}


@end
