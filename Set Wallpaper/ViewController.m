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
@property (weak, nonatomic) IBOutlet UISwitch *parallaxSwitch;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat radius = 12;
    self.lightImageView.layer.cornerRadius = radius;
    self.darkImageView.layer.cornerRadius = radius;
    
    UIColor *backgroundColor = [UIColor lightGrayColor];
    self.lightImageView.backgroundColor = backgroundColor;
    self.darkImageView.backgroundColor = backgroundColor;
}


#pragma mark - Actions

- (IBAction)chooseLightWallpaper:(id)sender {
    self.currentButton = light;
    [self pickImage];
}

- (IBAction)chooseDarkWallpaper:(id)sender {
    self.currentButton = dark;
    [self pickImage];
}

- (IBAction)setWallpaper:(id)sender {
    double parallaxFactor = self.parallaxSwitch.on ? 1.0 : 0.0;
    
    UIAlertController *locationPicker = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [locationPicker addAction:[UIAlertAction actionWithTitle:@"Set Lock Screen" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        setLightAndDarkWallpaperImages(self.lightImage, self.darkImage, 1, parallaxFactor);
    }]];
    [locationPicker addAction:[UIAlertAction actionWithTitle:@"Set Home Screen" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        setLightAndDarkWallpaperImages(self.lightImage, self.darkImage, 2, parallaxFactor);
    }]];
    [locationPicker addAction:[UIAlertAction actionWithTitle:@"Set Both" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        setLightAndDarkWallpaperImages(self.lightImage, self.darkImage, 3, parallaxFactor);
    }]];
    [locationPicker addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [locationPicker setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popPresenter = locationPicker.popoverPresentationController;
    popPresenter.sourceView = self.setWallpaperButton;
    popPresenter.sourceRect = self.setWallpaperButton.bounds;
    
    [self presentViewController:locationPicker animated:YES completion:nil];
}


#pragma mark - Helpers

- (void)pickImage {
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


#pragma mark - UIImagePickerControllerDelegate

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
