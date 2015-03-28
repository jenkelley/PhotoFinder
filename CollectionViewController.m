//
//  CollectionViewController.m
//  FavoritePhotos
//
//  Created by Jose Garcia on 3/27/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "CollectionViewController.h"

#import "BSDataManager.h"
#import "Photo.h"
#import "FPCollectionViewCell.h"
#import "FPCollectionView.h"

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, BSDataDelegate>
@property (strong, nonatomic) IBOutlet FPCollectionView *collectionView;
@property FPCollectionViewCell *collectionCell;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BSDataManager *dataManager = [BSDataManager new];
    dataManager.delegate = self;

    [dataManager getPhotoData];






}

- (void)gotPhotoData:(id)array {
    self.photos = array;
    [self.collectionView reloadData];
  //  [self.collectionCell reloadInputViews];

    // reload
}


    //need to set array here.



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewID" forIndexPath:indexPath];

    Photo *photo = [self.photos objectAtIndex:indexPath.row];


    self.collectionCell.urlLabel.text = photo.standardImageUrl;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo.standardImageUrl]];

    self.collectionCell.imageView.image = [UIImage imageWithData:imageData];


    return self.collectionCell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
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
