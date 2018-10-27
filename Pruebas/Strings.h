//
//  Strings.h
//  Pruebas
//
//  Created by Julio Banda on 19/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#ifdef DEBUG
#   define DLog(...) NSLog(__VA_ARGS__)
#else
#   define DLog(...)
#endif

#define EMPTY_STRING                        @""
#define PICK_PHOTO                          @"Pick photo"
#define CAMERA_ROLL                         @"Camera roll"
#define SHARE                               @"Share"
#define CREATE_GIF                          @"Create new GIF"
