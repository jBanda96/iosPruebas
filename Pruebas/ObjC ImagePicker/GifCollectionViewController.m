//
//  GifCollectionViewController.m
//  Pruebas
//
//  Created by Julio Banda on 21/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "GifCollectionViewController.h"
#import "Gif.h"
#import "xibViewController.h"

#define GIFURL [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gifts"]

@interface Bird : NSObject
@property NSString *type;
@property NSNumber *amount;

-(instancetype)init: (NSString *) bird amount: (NSNumber *) amount;

@end

@implementation Bird

-(instancetype)init: (NSString *) bird amount: (NSNumber *) amount {
    self = [super init];
    if (self) {
        self.type = bird;
        self.amount = amount;
    }
    
    return self;
}

@end

@interface GifCollectionViewController () {
    NSMutableArray *savedGifs;
}

@end

@implementation GifCollectionViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    savedGifs = [NSMutableArray arrayWithArray: [NSKeyedUnarchiver unarchiveObjectWithFile: GIFURL]];
    
    NSLog(@"%@", [self birds]);
    
    NSArray *bill = [[NSArray alloc] initWithObjects:
                     [NSNumber numberWithInt: 3],
                     [NSNumber numberWithInt: 10],
                     [NSNumber numberWithInt: 2],
                     [NSNumber numberWithInt: 9],
                     nil];
    [self bonAppetit: bill  k: [NSNumber numberWithInt: 1] b: [NSNumber numberWithInt: 12]];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [NSKeyedArchiver archiveRootObject: savedGifs toFile: GIFURL];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [savedGifs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath: indexPath];
    NSString *title = [savedGifs objectAtIndex:indexPath.row];
    
    [cell setUpCellWith: title];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.frame.size.width - (12 * 2)) / 2.0;
    return CGSizeMake(width, width);
}

- (IBAction) saveGif: (UIButton *) button {
    [savedGifs addObject: @"Hola"];
    [self.collection reloadData];
    
    CGPoint point = CGPointMake(0, self.collection.contentSize.height - self.collection.bounds.size.height);
    [self.collection setContentOffset: point animated: YES];
    
    [self.indicator startAnimating];
    [self makeRequest];
    
}

- (void) makeRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"https://jsonplaceholder.typicode.com/users/1"]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [dict objectForKey: @"name"];
        [dict objectForKey: @"email"];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
            
            xibViewController *viewController = [[UIStoryboard storyboardWithName: @"Picker" bundle: nil] instantiateViewControllerWithIdentifier: @"xib"];
            [self.navigationController pushViewController:viewController
                                                 animated:YES];
        });
        
    }] resume];
}

- (NSNumber *) birds {
    NSMutableDictionary *birds = [[NSMutableDictionary alloc] init];
    NSArray *arr = [[NSArray alloc] initWithObjects:
                    [NSNumber numberWithInt:1],
                    [NSNumber numberWithInt:2],
                    [NSNumber numberWithInt:3],
                    [NSNumber numberWithInt:4],
                    [NSNumber numberWithInt:5],
                    [NSNumber numberWithInt:4],
                    [NSNumber numberWithInt:3],
                    [NSNumber numberWithInt:2],
                    [NSNumber numberWithInt:1],
                    [NSNumber numberWithInt:3],
                    [NSNumber numberWithInt:4],
                    nil];
    
    for (int i = 0; i < [arr count]; i++) {
        int currentNumber = [[arr objectAtIndex: i] intValue];
        NSString *key = [NSString stringWithFormat: @"%i", currentNumber];
        
        if ([birds valueForKey: key]) {
            Bird *bird = [birds objectForKey: key];
            int birdAmount = [[bird amount] intValue] + 1;
            bird.amount = [NSNumber numberWithInt: birdAmount];
        } else {
            Bird *bird = [[Bird alloc] init: key amount: [NSNumber numberWithInt: 1]];
            [birds setValue:bird forKey:key];
        }
        
    }
    
    NSArray *birdValues = [birds allValues];
    Bird *max = [birdValues objectAtIndex: 0];
    for(Bird *bird in birdValues){
        if ([[max amount] intValue] < [[bird amount] intValue]) {
            max = bird;
        }
    }
    
    NSMutableArray *maxBirds = [[NSMutableArray alloc] init];
    for(Bird *bird in birdValues){
        if ([[bird amount] intValue] == [[max amount] intValue]) {
            [maxBirds addObject: bird];
        }
    }
    
    Bird *birdToReturn = [maxBirds objectAtIndex: 0];
    for (Bird *bird in maxBirds) {
        if ([[birdToReturn type] intValue] > [[bird type] intValue]) {
            birdToReturn = bird;
        }
    }
    
    return [NSNumber numberWithInt: [[birdToReturn type] intValue]];
}

- (void) bonAppetit:(NSArray *)bill k:(NSNumber *)k b:(NSNumber *)b {
    
    int totalBill = 0;
    int annasBill = 0;
    
    for (int i = 0; i < [bill count]; i++) {
        if (i != [k intValue]) {
            totalBill += [[bill objectAtIndex: i] intValue];
        }
    }
    
    annasBill = [b intValue] - (totalBill / 2);
    
    if (annasBill == 0) {
        NSLog(@"Bon Appetit");
    } else {
        NSLog(@"%i", annasBill);
    }
    
}

@end
