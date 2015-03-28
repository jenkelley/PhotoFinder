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


#define KAUTHURL @"https://api.instagram.com/oauth/authorize/"
#define kAPIURl @"https://api.instagram.com/v1/users/"
#define KCLIENTID @"5de4ae86fa5e47cbbaa0196f5944eaeb"
#define KCLIENTSERCRET @"Y35e4404d6a914c4cb68bc64fb9e3292d"
#define kREDIRECTURI @"http://www.grumpydane.com/index.html"


@implementation BSDataManager

- (void)getPhotoData {
    //%@?client_id=%@&redirect_uri=%@&response_type=token

    //NSString *urlText = [NSString stringWithFormat:@"%@%@&redirect_uri= %@&response_type=token",KAUTHURL,KCLIENTID,kREDIRECTURI];

    //NSString *urlText = @"https://api.instagram.com/v1/tags/sailboat/media/recent";
    NSString *urlText = @"https://api.instagram.com/v1/tags/knitter/media/recent?access_token=511875006.1fb234f.0d6beb9217cc493ebfb452c798bcbed2";

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
                                   Photo *photo = [[Photo alloc]initWithDictionary:photoDictionary arrayIndex:arrayIndex];
                                   [photos addObject:photo];
                                   arrayIndex++;
                                   NSLog(@" ArrayIndex: %i", photo.arrayIndex);
                                   
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









@end
