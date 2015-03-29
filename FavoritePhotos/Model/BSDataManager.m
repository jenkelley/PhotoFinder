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


#pragma mark Instagram api

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


#pragma mark - Data methods

- (void)write:(NSMutableArray *)array {
    // Save the array
    [NSKeyedArchiver archiveRootObject:array toFile:[BSDataManager fullPathName:@"photoFavorites.data"]];
    NSLog(@"%@", [BSDataManager fullPathName:@"photoFavorites.data"]);
}

- (NSMutableArray *)read {
    // Load the array
    NSMutableArray *tasks = [NSKeyedUnarchiver unarchiveObjectWithFile:[BSDataManager fullPathName:@"photoFavorites.data"]];
    return tasks;

}

+ (NSString *)fullPathName:(NSString *)fileName {
    NSString *adjustedFileName = fileName;
    if ([fileName containsString:@"http"]) {
        adjustedFileName = [fileName lastPathComponent];
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];

    NSLog(@"%@", [NSString stringWithFormat:@"%@/%@", docDir, adjustedFileName]);
    return [NSString stringWithFormat:@"%@/%@", docDir, adjustedFileName];
}



#pragma mark - Image methods

+ (void)writeImageToDisk:(UIImage *)image withFileName:(NSString *)fileName {
    NSLog(@"%f,%f",image.size.width,image.size.height);

    NSLog(@"saving png");
    NSString *pngFilePath = [BSDataManager fullPathName:fileName];
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [data1 writeToFile:pngFilePath atomically:YES];

//    NSLog(@"saving jpeg");
//    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/test.jpeg",docDir];
//    NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
//    [data2 writeToFile:jpegFilePath atomically:YES];

    NSLog(@"saving image done");

}

+ (UIImage *)readImageFromDisk:(NSString *)fileName {

    UIImage *testImage = [UIImage imageWithContentsOfFile:[BSDataManager fullPathName:fileName]];

    return testImage;
}









@end
