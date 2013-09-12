//
//  ViewController.m
//  FiboImage
//
//  Created by Andrei on 9/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+APImageProcessing.h"

#define kFramesPerSecond 24.0f
#define kFrameDuration 1.0 / kFramesPerSecond

@interface ViewController ()

@end

CGFloat lerp(CGFloat a, CGFloat b, CGFloat p) {
    return a * p + b * (1.0 - p);
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self yolo:@0];
}

- (void)yolo:(NSNumber *)time {
    static unsigned char *buffer = nil;

    ImageProcessingBlock filter = ^(unsigned char *rawData, int width, int height) {
        NSLog(@"filtering image");
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * width;

        if (buffer == nil) {
            CGImageRef imageRef = [self.original.image CGImage];
            NSUInteger width = CGImageGetWidth(imageRef);
            NSUInteger height = CGImageGetHeight(imageRef);
            buffer = (unsigned char*) calloc(height * width * bytesPerPixel, sizeof(unsigned char));
            memcpy(buffer, rawData, bytesPerRow * height);
        }
        
        
        for (int x = 0; x < width; ++x) {
            for (int y = 0; y < height; ++y) {
                int index = (bytesPerRow * y) + x * bytesPerPixel;
                rgbaForIndex(index)
                
                int step = 3;

                int rightIndex = idx((x + step) % width, y);
                int leftIndex = idx((x + width - step) % width, y);

                
                redForIndex(index) = redForIndexInContex(rightIndex, buffer);
                blueForIndex(index) = blueForIndexInContex(leftIndex, buffer);
            }
        }
        
        memcpy(buffer, rawData, bytesPerRow * height);
        
        NSLog(@"done..");
    };
    
    self.processed.image = [UIImage processImage:self.original.image
                                            with:filter];
    

    
    
    [self performSelector:@selector(yolo:)
               withObject:@(time.floatValue + kFrameDuration)
               afterDelay:kFrameDuration];
}


@end
