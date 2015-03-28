//
//  CollectionViewController.h
//  FavoritePhotos
//
//  Created by Jose Garcia on 3/27/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController
@property NSArray *photos;
@property NSMutableArray *photoFavorites;
@property BOOL isFavoritesOnly;

@end
