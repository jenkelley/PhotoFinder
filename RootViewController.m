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
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface RootViewController ()<BSDataDelegate>
@property (weak, nonatomic) IBOutlet UIButton *onPhotosButtonTapped;
@property (weak, nonatomic) IBOutlet UIButton *onFavoriteButtonTapped;
@property BSDataManager *bsDataManager;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.photoFavorites = [NSMutableArray new];

    self.bsDataManager = [BSDataManager new];

    NSMutableArray *favs = [self.bsDataManager read];
    if (favs.count > 0) {
        self.photoFavorites = favs;
    }

}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    NSMutableArray *favs = [self.bsDataManager read];
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
        CollectionViewController *cvc = [CollectionViewController new];
        cvc = segue.destinationViewController;
        cvc.photoFavorites = self.photoFavorites;
        cvc.isFavoritesOnly = YES;
    }


}

- (IBAction)onMapButtonPressed:(id)sender {
    NSMutableArray *mapItems = [NSMutableArray new];

    for (Photo *photo in self.photoFavorites) {
        if (photo.latitude != nil && ![photo.latitude isEqualToString:@""] && ![photo.longitude isEqualToString:@""]) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([photo.latitude doubleValue], [photo.longitude doubleValue]);
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            [mapItem setName:photo.caption];

            [mapItems addObject:mapItem];
            NSLog(@"Pins added: %li  (%@,%@)", mapItems.count, photo.latitude, photo.longitude);
        }
    }

    if (mapItems.count > 0) {
        [MKMapItem openMapsWithItems:mapItems launchOptions:nil];
    } else {
        UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"No Favs with locations:" message:@"Pick some with long and lat" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [removeSuccessFulAlert show];
    }




}




@end
