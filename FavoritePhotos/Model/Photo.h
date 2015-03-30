//
//  Photo.m
//  FavoritePhotos
//
//  Created by Mick Lerche on 3/24/15.
//  Copyright (c) 2015 Mick Lerche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Photo : NSObject {
    NSDictionary *dictionary;
    NSString     *Id;
    CLLocation   *location;
    NSString     *longitude;
    NSString     *latitude;
    NSString     *standardImageUrl;
    NSNumber     *arrayIndex;
    NSNumber     *favoriteBool;
    NSString     *caption;

}
@property (nonatomic, retain) NSDictionary *dictionary;
@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *standardImageUrl;
@property (nonatomic, retain) NSNumber *arrayIndex;
@property (nonatomic, retain) NSNumber *favoriteBool;
@property (nonatomic, retain) NSString *caption;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary arrayIndex:(NSNumber *)arrayIndex;
- (NSString *)getProperty:(NSString *)propertyName;

@end
