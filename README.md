APImageProcessing
=================

![Example](http://i.imgflip.com/3k2an.gif)

```objective-c
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
                
                int step = 2;

                redForIndex(index) = redForIndexInContex(idx((x + step) % width, y), buffer);
                blueForIndex(index) = blueForIndexInContex(idx((x + step + 1) % width, y), buffer);
                greenForIndex(index) = greenForIndexInContex(idx((x + step + 2) % width, y), buffer);
            }
        }
        
        memcpy(buffer, rawData, bytesPerRow * height);
        
        NSLog(@"done..");
    };
```
