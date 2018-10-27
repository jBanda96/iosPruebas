//
//  NetUtils.m
//  Pruebas
//
//  Created by Julio Banda on 06/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "NetUtils.h"

@implementation NetUtils
@synthesize protocol;

-(void) prepareForFetching {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        NSArray *info = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        for (int i = 0; i < [info count]; i++) {
            NSDictionary *model = [info objectAtIndex:i];
            Model *modelToSave = [[Model alloc] initWithInfo:model];
            [modelArray addObject: modelToSave];
        }
        
        [self.protocol fetchData:modelArray];
        
    }] resume];
}

@end
