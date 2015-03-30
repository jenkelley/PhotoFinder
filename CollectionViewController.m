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
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>


@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, BSDataDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet FPCollectionView *collectionView;
@property FPCollectionViewCell *collectionCell;
@property BSDataManager *bsDataManger;
@property NSIndexPath *indexPath;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bsDataManger = [BSDataManager new];
    self.bsDataManger.delegate = self;

    if (self.isFavoritesOnly) {
        self.photos = [NSMutableArray arrayWithArray:self.photoFavorites];
    } else {
        [self.bsDataManger getPhotoData:self.title];
    }
    if (self.photoFavorites == nil) {
        self.photoFavorites = [NSMutableArray new];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)gotPhotoData:(id)array {
    self.photos = array;
    [self.collectionView reloadData];
  //  [self.collectionCell reloadInputViews];

    // reload
}


    //need to set array here.



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewID" forIndexPath:indexPath];

    Photo *photo = [self.photos objectAtIndex:indexPath.row];
    NSLog(@"(%@,%@)", photo.longitude, photo.latitude);

    //self.collectionCell.urlLabel.text = photo.standardImageUrl;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo.standardImageUrl]];

    if (imageData != nil) {
        self.collectionCell.imageView.image = [UIImage imageWithData:imageData];
    } else  if (photo.favoriteBool == [NSNumber numberWithBool:YES]) {
        self.collectionCell.imageView.image = [BSDataManager readImageFromDisk:photo.standardImageUrl];
    }
    self.indexPath = indexPath;
    self.collectionCell.geoCode.text = (![photo.longitude isEqualToString:@""]) ? [NSString stringWithFormat:@"(%@,%@)", photo.longitude, photo.latitude] : @"";
    if ([self.collectionCell.geoCode.text isEqualToString:@"((null),(null))"]) {
        self.collectionCell.geoCode.text = @"";
    }
    self.collectionCell.captionLabel.text = photo.caption;
    self.collectionCell.likeImageView.hidden = !photo.favoriteBool;
    return self.collectionCell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Photo *photoz = [self.photos objectAtIndex:indexPath.row];
    FPCollectionViewCell *cell = (FPCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (photoz.favoriteBool == NO) {
        photoz.favoriteBool = [NSNumber numberWithBool:YES];
        NSLog(@"FAVORITE FOREVER");
        [self.photoFavorites addObject:photoz];

        // save the image to disk
        [BSDataManager writeImageToDisk:cell.imageView.image withFileName:photoz.standardImageUrl];

    } else {
        photoz.favoriteBool = [NSNumber numberWithBool:NO];
        [self.photoFavorites removeObject:photoz];
    }

    NSLog(@"%lu", (unsigned long)self.photoFavorites.count);
    cell.likeImageView.hidden = ![photoz.favoriteBool boolValue];

    [self.bsDataManger write:self.photoFavorites];
}


#pragma mark Twitter & email stuff

- (IBAction)onTweetButtonPressed:(id)sender {
    FPCollectionViewCell *cell = ((FPCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.indexPath]);

    NSArray *imageArray = [[NSArray alloc]initWithObjects:cell.imageView.image, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:imageArray applicationActivities:nil];
    [self presentViewController:activityViewController
                                       animated:YES
                                     completion:^{
                                     }];
}







@end
