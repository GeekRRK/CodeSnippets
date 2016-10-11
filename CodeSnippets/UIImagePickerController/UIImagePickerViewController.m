//
//  UIImagePickerViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 1/8/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "UIImagePickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^ALAssetsEnumeration)(id);

@interface UIImagePickerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *assetArray;

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
    
    UIView *backgroupView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].applicationFrame.size.width, 20)];
    backgroupView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_status_bg"]];
    [picker.navigationBar addSubview:backgroupView];
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_status_bg"] forBarMetrics:UIBarMetricsDefault];
    picker.navigationBar.tintColor = [UIColor whiteColor];
    [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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
    
    UIView *backgroupView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].applicationFrame.size.width, 20)];
    backgroupView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_status_bg"]];
    [pickerImage.navigationBar addSubview:backgroupView];
    [pickerImage.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_status_bg"] forBarMetrics:UIBarMetricsDefault];
    pickerImage.navigationBar.tintColor = [UIColor whiteColor];
    [pickerImage.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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

- (void)setupImgPickerVC {
    __block UIImagePickerViewController *thisVC = self;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [self enumerateAssetForGroup:group forFilter:[ALAssetsFilter allPhotos] withCompletionBlock:^(id object) {
                thisVC.assetArray = object;
                [thisVC.assetArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    NSDate *date1 = [obj1 valueForProperty:ALAssetPropertyDate];
                    NSDate *date2 = [obj2 valueForProperty:ALAssetPropertyDate];
                    
                    return ([date1 compare:date2] == NSOrderedAscending ? NSOrderedDescending : NSOrderedAscending);
                }];
//                [thisVC.tableView reloadData];
            }];
        }
    } failureBlock:nil];
}

- (void)enumerateAssetForGroup:(ALAssetsGroup*)group forFilter:(ALAssetsFilter*)filter withCompletionBlock:(ALAssetsEnumeration)enumerationCompletionBlock {
    [group setAssetsFilter:filter];
    __block NSInteger assetsCount = [group numberOfAssets];
    __block NSMutableArray *assetArray = [[NSMutableArray alloc] init];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [assetArray addObject:result];
            if (*stop) {
                enumerationCompletionBlock(assetArray);
            }
        } else if (assetsCount == 0) {
            enumerationCompletionBlock(nil);
        }
    }];
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        if (buttonIndex == 0) {
//            [self openCamera];
//        } else if (buttonIndex == 1) {
//            if (IPad) {
//                [self openPhotoLibraryForIpad];
//            } else {
//                [self openPhotoLibrary];
//            }
//        }
//    }];
//}

@end
