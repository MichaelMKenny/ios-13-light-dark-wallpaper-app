//
//  ViewController.m
//  Set Wallpaper
//
//  Created by Michael Kenny on 9/8/19.
//  Copyright © 2019 Michael Kenny. All rights reserved.
//

#import "ViewController.h"
#import "InternalSetWallpaper.h"
#import "PHAsset+Coofdy.h"

@import Photos;

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *setWallpaperButton;
@property (nonatomic) enum {light, dark} currentButton;
@property (weak, nonatomic) IBOutlet UIImageView *lightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *darkImageView;
@property (nonatomic, strong) UIImage *lightImage;
@property (nonatomic, strong) UIImage *darkImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat radius = 12;
    self.lightImageView.layer.cornerRadius = radius;
    self.darkImageView.layer.cornerRadius = radius;
    
    UIColor *backgroundColor = [UIColor lightGrayColor];
    self.lightImageView.backgroundColor = backgroundColor;
    self.darkImageView.backgroundColor = backgroundColor;
}

- (IBAction)chooseLightWallpaper:(id)sender {
    self.currentButton = light;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                [self presentViewController:imagePicker animated:YES completion:^{
                    imagePicker.delegate = self;
                }];
                
            });
        }
    }];
}
- (IBAction)chooseDarkWallpaper:(id)sender {
    self.currentButton = dark;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                [self presentViewController:imagePicker animated:YES completion:^{
                    imagePicker.delegate = self;
                }];
                
            });
        }
    }];
}

- (IBAction)setWallpaper:(id)sender {
    setLightAndDarkWallpaperImages(self.lightImage, self.darkImage);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    PHAsset *asset = info[UIImagePickerControllerPHAsset];
    switch (self.currentButton) {
        case light: {
            self.lightImage = [asset getImageFromAsset];
            self.lightImageView.image = self.lightImage;
        }
            break;
        case dark: {
            self.darkImage = [asset getImageFromAsset];
            self.darkImageView.image = self.darkImage;
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.lightImage != nil && self.darkImage != nil) {
            [UIView transitionWithView:self.setWallpaperButton duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                self.setWallpaperButton.enabled = YES;
            } completion:nil];
        }
    }];
}

@end
