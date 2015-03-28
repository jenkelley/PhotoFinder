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

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, BSDataDelegate>

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
    // reload
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewID" forIndexPath:indexPath];


    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
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
