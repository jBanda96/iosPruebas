//
//  PickerViewController+Picker.m
//  Pruebas
//
//  Created by Julio Banda on 19/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "PickerViewController+Picker.h"
#import "UIImage+Gif.h"
#import "NSGIF.h"

@implementation PickerViewController (Picker)


- (void) launchCamera {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    [pickerController setSourceType: UIImagePickerControllerSourceTypeCamera];
    [pickerController setMediaTypes: @[(NSString *) kUTTypeMovie]];
    [pickerController setAllowsEditing: NO];
    [pickerController setDelegate: self];
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    NSURL *videoURL = [info objectForKey: UIImagePickerControllerMediaURL];
    
    
    self.gif = [[Gif alloc] initWithGifURL:videoURL videoURL:videoURL caption:@""];
    [NSGIF createGIFfromURL:[self.gif.videoURL absoluteURL] withFrameCount:64 delayTime:0 loopCount:0 completion:^(NSURL *GifURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage animatedImageWithAnimatedGIFURL: GifURL];
        });
    }];
    
    
    [self.imageView setImage: [UIImage animatedImageWithAnimatedGIFURL: videoURL]];
    
    
    UISaveVideoAtPathToSavedPhotosAlbum([videoURL path], nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"User did cancel");
}

@end
