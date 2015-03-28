//
//  BSDataManager.m
//  BSBusChallenge
//
//  Created by Mick Lerche on 3/24/15.
//  Copyright (c) 2015 Mick Lerche. All rights reserved.
//

#import "BSDataManager.h"
#import "Photo.h"
#import "FPGroup.h"


@implementation BSDataManager

- (void)getPhotoData:(NSString *)searchText {
    NSString *photoUrlText = @"https://api.instagram.com/v1/tags/*****/media/recent?access_token=511875006.1fb234f.0d6beb9217cc493ebfb452c798bcbed2";
    NSString *urlText = [photoUrlText stringByReplacingOccurrencesOfString:@"*****" withString:searchText];

    NSURL *url = [NSURL URLWithString:urlText];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               self.dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:NSJSONReadingAllowFragments
                                                                                   error:&connectionError];
                               self.array = [self.dictionary valueForKey:@"data"];

                               NSMutableArray *photos = [NSMutableArray new];

                               NSLog(@"Data Received");

                               int arrayIndex = 0;
                               for (NSDictionary *photoDictionary in self.array) {
                                   Photo *photo = [[Photo alloc]initWithDictionary:photoDictionary arrayIndex:[NSNumber numberWithInteger:arrayIndex]];
                                   [photos addObject:photo];
                                   arrayIndex++;
                                   NSLog(@" ArrayIndex: %i", arrayIndex);
                                   
                               }

                               [self.delegate gotPhotoData:photos];


                               NSLog(@"Data items: %li", (long)self.array.count);
                               
                           }];
    
}

- (void)getGroupData:(NSString *)searchText {
    NSString *groupUrlText = @"https://api.instagram.com/v1/tags/search?access_token=511875006.1fb234f.0d6beb9217cc493ebfb452c798bcbed2&q=*****";
    NSString *urlText = [groupUrlText stringByReplacingOccurrencesOfString:@"*****" withString:searchText];

    NSURL *url = [NSURL URLWithString:urlText];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               self.dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:NSJSONReadingAllowFragments
                                                                                   error:&connectionError];
                               self.array = [self.dictionary valueForKey:@"data"];

                               NSMutableArray *groups = [NSMutableArray new];

                               NSLog(@"Data Received");

                               int arrayIndex = 0;
                               for (NSDictionary *photoDictionary in self.array) {
                                   FPGroup *photo = [[FPGroup alloc]initWithDictionary:photoDictionary arrayIndex:arrayIndex];
                                   [groups addObject:photo];
                                   arrayIndex++;
                                   NSLog(@" ArrayIndex: %i", photo.arrayIndex);

                               }

                               [self.delegate gotGroupData:groups];

                               NSLog(@"Data items: %li", (long)self.array.count);
                               
                           }];
}

- (void)write:(NSMutableArray *)array {
    // Save the array
    [NSKeyedArchiver archiveRootObject:array toFile:[BSDataManager dataFullPathName]];
    NSLog(@"%@", [BSDataManager dataFullPathName]);
}

- (NSMutableArray *)read {
    // Load the array
    NSMutableArray *tasks = [NSKeyedUnarchiver unarchiveObjectWithFile:[BSDataManager dataFullPathName]];
    return tasks;

}

+ (NSString *)dataFullPathName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/photoFavorites.data", docDir];
}









@end
