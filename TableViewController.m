//
//  TableViewController.m
//  FavoritePhotos
//
//  Created by Jose Garcia on 3/27/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "BSDataManager.h"
#import "FPGroup.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,BSDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSString *searchedText;
@property NSMutableArray *photosArray;
@property BSDataManager *bsDataManager;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.groups = [NSArray new];
    self.photos = [NSArray new];
    self.searchBar.delegate = self;
    BSDataManager *dataManager = [BSDataManager new];
    dataManager.delegate = self;
    //[dataManager getPhotoData];


    [dataManager getGroupData];
}


- (void)gotPhotoData:(id)array {
    self.photos = array;
}

- (void)gotGroupData:(id)array {
    self.groups = array;
    [self.tableView reloadData];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchedText = self.searchBar.text;
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table View

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotosCellID"];
    FPGroup *fgGroup = [FPGroup new];
    fgGroup = [self.groups objectAtIndex:indexPath.row];
    cell.textLabel.text = fgGroup.name;
    cell.detailTextLabel.text = fgGroup.mediaCount;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CollectionViewController *cvc = [CollectionViewController new];
    cvc = segue.destinationViewController;
}




@end
