//
//  UIImagePickerViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "UIImagePickerViewController.h"

@interface UIImagePickerViewController ()
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation UIImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)openCamera{
    UIImagePickerControllerSourceType sourceType =
    UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController
          isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)openPhotoLibrary{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc]
                                            init];
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController
                                  availableMediaTypesForSourceType:
                                  pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

- (void)openPhotoLibraryForIpad{
    UIImagePickerControllerSourceType sourceType =
    UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = sourceType;
    /*
     If present from a bar buttton:
     presentPopoverFromBarButtonItem:permittedArrowDirections:animated:；
     If present from a view:
     presentPopoverFromRect:inView:permittedArrowDirections:animated:
     
     Relocate when the device rotates:
     didRotateFromInterfaceOrientation:（Reconfigure the rect)
     
     Invoke the method again:
     - (void)presentPopoverFromRect:inView:permittedArrowDirections:animated:
     */
    
    //UIPopoverController only for iPad
    UIPopoverController *popover = [[UIPopoverController alloc]
                                    initWithContentViewController:picker];
    [popover presentPopoverFromRect:CGRectMake(0, 0, 300, 300)
                             inView:self.view
           permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    NSLog(@"%@", img);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
