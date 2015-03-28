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

    self.photoFavorites = [NSArray new];
}



- (IBAction)unwindToRootController:(UIStoryboardSegue *)sender {

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

//    CollectionViewController *cvc = segue.destinationViewController;
//    cvc.photos = self.photoFavorites;
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
