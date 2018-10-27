//
//  ObjcNetTableViewController.m
//  Pruebas
//
//  Created by Julio Banda on 06/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "ObjcNetTableViewController.h"
#import "House.h"

@interface ObjcNetTableViewController ()

@end

@implementation ObjcNetTableViewController {
    NSMutableArray *itemInModel;
    NSString *cellIdentifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatingTable];
    itemInModel = [[NSMutableArray alloc] init];
    
    
    NetUtils *utils = [[NetUtils alloc] init];
    [utils prepareForFetching];
    utils.protocol = self;
    
    NSNumber *entero = [NSNumber numberWithInt: 3];
    NSString *string = @"Julio";
    
    NSArray *array = @[entero, string];
    id firstMisteryObject = [array objectAtIndex: 0];
    id secondtMisteryObject = [array objectAtIndex: 1];
    NSLog(@"%@ - %@", [firstMisteryObject class], [secondtMisteryObject class]);
    
    NSMutableString *address = [[NSMutableString alloc] initWithString:@"Prolongación Minerva #6"];
    
    House *house = [[House alloc] initWithAddress: address];
    
    [address appendString: @"La La Land"];
    NSLog(@"House address: %@", [house address]);
    
}

// MARK: - Table view data source and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemInModel count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Model *model = [itemInModel objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [model myDescription];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [model idd]];
    
    return cell;
}

- (void) creatingTable {
    cellIdentifier = @"cell";
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

// MARK: - Fetching data from internet
- (void)fetchData:(NSMutableArray *)array {
    itemInModel = array;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
