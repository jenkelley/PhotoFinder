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
#import "FPCollectionView.h"
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
