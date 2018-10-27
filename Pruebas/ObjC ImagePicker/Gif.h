//
//  Gif.h
//  Pruebas
//
//  Created by Julio Banda on 20/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Gif : NSObject <NSCoding>

@property (nonatomic) NSURL *url;
@property (nonatomic) NSString *caption;
@property (nonatomic) UIImage *gifImage;
@property (nonatomic) NSURL *videoURL;
@property (nonatomic) NSData *gifData;

- (instancetype) initWithGifURL: (NSURL *) url videoURL: (NSURL *) videoURL caption: (NSString *) caption;

@end
