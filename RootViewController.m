//
//  RootViewController.m
//  FavoritePhotos
//
//  Created by Jen Kelley on 3/26/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "RootViewController.h"
#import "BSDataManager.h"
#import "FPGroup.h"
#import "Photo.h"
#import "CollectionViewController.h"
#import "FPCollectionViewCell.h"
#import "FPCollectionView.h"
#import "TableViewController.h"


@interface RootViewController ()<BSDataDelegate>
@property (weak, nonatomic) IBOutlet UIButton *onPhotosButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *onFavoriteButtonTapped;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.photoFavorites = [NSMutableArray new];

    BSDataManager *bsDataManager = [BSDataManager new];

    NSMutableArray *favs = [bsDataManager read];
    if (favs.count > 0) {
        self.photoFavorites = favs;
    }

}



- (IBAction)unwindToRootController:(UIStoryboardSegue *)sender {

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GroupsSegue"]) {
        TableViewController *tvc = segue.destinationViewController;
        //tvc.photos = self.photoFavorites;
    } else {
        CollectionViewController *cvc = segue.destinationViewController;
        cvc.photoFavorites = self.photoFavorites;
        cvc.isFavoritesOnly = YES;
    }

}


/*

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TableViewController *tbc = [TableViewController new];
    tbc = segue.destinationViewController;
    //tbc.photos = self.photos;
    //tbc.groups = self.groups;
}
*/

@end
