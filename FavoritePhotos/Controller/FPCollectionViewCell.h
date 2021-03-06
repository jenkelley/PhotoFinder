//
//  FPCollectionViewCell.h
//  FavoritePhotos
//
//  Created by Mick Lerche on 3/26/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *geoCode;
@property (strong, nonatomic) IBOutlet UIImageView *likeImageView;

@end
