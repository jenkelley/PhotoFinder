//
//  TableViewController.m
//  FavoritePhotos
//
//  Created by Jose Garcia on 3/27/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "TableViewController.h"
#import "CollectionViewController.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    BSDataManager *dataManager = [BSDataManager new];
//    dataManager.delegate = self;
//    [dataManager getPhotoData];
//
//    [dataManager getGroupData];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//- (void)gotPhotoData:(id)array {
//    self.Photos = array;
//    [self.collectionView reloadData];
//}
//
//- (void)gotGroupData:(id)array {
//    self.Groups = array;
//    //[self.collectionView reloadData]; where to load it
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotosCellID"];
    cell.textLabel.text = @"Yes!!";
    cell.detailTextLabel.text = @"OHHHH!";

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CollectionViewController *cvc = [CollectionViewController new];
    cvc = segue.destinationViewController;
}


@end
