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

@interface RootViewController ()<BSDataDelegate>
@property NSArray *photos;
@property NSArray *groups;
@property (weak, nonatomic) IBOutlet UIButton *onPhotosButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *onFavoriteButtonTapped;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BSDataManager *dataManager = [BSDataManager new];
    dataManager.delegate = self;
    [dataManager getPhotoData];
    NSLog(@"%lu", (unsigned long)self.photos.count);

  //  [dataManager getGroupData];

}


- (void)gotPhotoData:(id)array {
    self.Photos = array;
  //  CollectionViewController *collectionView = [CollectionViewController new];
  //  [collectionView reloadData];
}
//
//-(IBAction)onPhotosButtonTapped:(id)sender{
//    self.photos = [[NSArray alloc] initWithArray:[self gotPhotoData:self.photos]];
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    CollectionViewController *cvc = segue.destinationViewController;
    cvc.photoArray = self.photos;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
