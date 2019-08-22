//
//  PHAsset+Coofdy.m
//  Set Wallpaper
//
//  Created by Michael Kenny on 22/8/19.
//  Copyright © 2019 Michael Kenny. All rights reserved.
//

#import "PHAsset+Coofdy.h"

#import <UIKit/UIKit.h>


@implementation PHAsset (Coofdy)

- (UIImage *)getImageFromAsset {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = true;
    
    __block UIImage *image;
    [PHCachingImageManager.defaultManager requestImageForAsset:self targetSize:CGSizeMake(self.pixelWidth, self.pixelHeight) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result;
    }];
    return image;
}

@end
