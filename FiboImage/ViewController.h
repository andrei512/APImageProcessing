//
//  ViewController.h
//  FiboImage
//
//  Created by Andrei on 9/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UIImageView *sampleImage;
@property (weak, nonatomic) IBOutlet UIImageView *original;
@property (weak, nonatomic) IBOutlet UIImageView *processed;

@end
