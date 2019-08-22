//
//  PHAsset+Coofdy.h
//  Set Wallpaper
//
//  Created by Michael Kenny on 22/8/19.
//  Copyright © 2019 Michael Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (Coofdy)

- (UIImage *)getImageFromAsset;

@end

NS_ASSUME_NONNULL_END
