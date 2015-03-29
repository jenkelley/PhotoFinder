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

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, BSDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSString *searchedText;
@property NSMutableArray *photosArray;
@property BSDataManager *bsDataManager;
@property FPGroup *fgGroup;
@property BOOL isFiltered;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.groups = [NSArray new];
    self.photos = [NSArray new];
    self.searchBar.delegate = self;
    self.fgGroup = [FPGroup new];
    self.bsDataManager = [BSDataManager new];
    self.bsDataManager.delegate = self;

}

- (void)gotPhotoData:(id)array {
    self.photos = array;
}

- (void)gotGroupData:(id)array {
    self.groups = array;
    [self.tableView reloadData];
}


//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    self.searchedText = self.searchBar.text;
//    [self.bsDataManager getGroupData:self.searchedText];
//    [self.searchBar resignFirstResponder];
//}


#pragma mark - Table View

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchedText = self.searchBar.text;
    [self.bsDataManager getGroupData:self.searchedText];
    [self.searchBar resignFirstResponder];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotosCellID"];
//    self.fgGroup = [self.groups objectAtIndex:indexPath.row];
//    cell.textLabel.text = self.fgGroup.name;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Photos",self.fgGroup.mediaCount];
//
//    return cell;

    if(self.isFiltered) {
        self.fgGroup = [self.groups objectAtIndex:indexPath.row];
        cell.textLabel.text = self.fgGroup.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Photos", self.fgGroup.mediaCount];
    }
    else {
        self.fgGroup = [self.groups objectAtIndex:indexPath.row];
        cell.textLabel.text = self.fgGroup.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Photos", self.fgGroup.mediaCount];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if(searchText.length == 0)
    {
        self.isFiltered = FALSE;
    } else {
        self.isFiltered = true;
        self.groups = [NSMutableArray new];
        for ( FPGroup *group in self.groups) {
            NSRange stopNameRange = [group.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (stopNameRange.length != NSNotFound) {
                [self.photosArray addObject:group];
            }
        }
    }

    [self.tableView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CollectionViewController *cvc = [CollectionViewController new];
    cvc = segue.destinationViewController;
    cvc.title = self.fgGroup.name;

}


@end
