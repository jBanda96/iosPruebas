//
//  DidTakePhotoProtocol.h
//  Pruebas
//
//  Created by Julio Banda on 19/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DidTakePhotoProtocol <NSObject>
- (void) userDidPickPhoto: (NSURL *) url;
@end

NS_ASSUME_NONNULL_END
