//
//  Gif.m
//  Pruebas
//
//  Created by Julio Banda on 20/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "Gif.h"
#import "UIImage+Gif.h"

@implementation Gif

- (instancetype)initWithGifURL:(NSURL *)url videoURL:(NSURL *)videoURL caption:(NSString *)caption {
    self = [super init];
    
    if (self) {
        _url = url;
        _videoURL = videoURL;
        _caption = caption;
        _gifImage = [UIImage animatedImageWithAnimatedGIFURL: [url absoluteURL]];
        _gifData = nil;
    }
    
    return self;
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self.url = [aDecoder decodeObjectForKey: @"gifURL"];
    self.caption = [aDecoder decodeObjectForKey: @"caption"];
    
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.url forKey: @"gifURL"];
    [aCoder encodeObject:self.caption forKey: @"caption"];
}

@end
