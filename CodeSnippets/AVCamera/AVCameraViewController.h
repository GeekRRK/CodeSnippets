//
//  ViewController.h
//  Demo_Camera
//
//  Created by UGOMEDIA on 16/4/9.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAPLPreviewView.h"

@interface AVCameraViewController : UIViewController


@property (weak, nonatomic) IBOutlet AAPLPreviewView *previewView;

@end

