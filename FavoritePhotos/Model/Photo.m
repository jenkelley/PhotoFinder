//
//  Photo.m
//  FavoritePhotos
//
//  Created by Mick Lerche on 3/24/15.
//  Copyright (c) 2015 Mick Lerche. All rights reserved.
//

#import "Photo.h"

@implementation Photo
@synthesize Id, longitude, latitude, standardImageUrl, arrayIndex, favoriteBool;

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryIn arrayIndex:(NSNumber *)arrayIndexIn {
    self = [super init];
    if (self) {
        self.dictionary = dictionaryIn;
        self.arrayIndex = arrayIndexIn;

        NSDictionary *locationDictionary = [self.dictionary objectForKey:@"location"];
        if (locationDictionary != (id)[NSNull null]) {
            self.latitude = [locationDictionary objectForKey:@"latitude"];
            self.longitude = [locationDictionary objectForKey:@"longitude"];
            self.location = [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];
        } else {
            NSLog(@"NO LOCATION SPECIFIED");
        }

        NSDictionary *images = [self.dictionary objectForKey:@"images"];
        if (images != (id)[NSNull null]) {
            NSDictionary *standardResImage = [images objectForKey:@"standard_resolution"];
            if (standardResImage != (id)[NSNull null]) {
                self.standardImageUrl = [standardResImage objectForKey:@"url"];
                NSLog(@"URL: %@", self.standardImageUrl);
            } else {
                NSLog(@"NO STANDARD IMAGE SPECIFIED");
            }
        } else {
            NSLog(@"NO IMAGES SPECIFIED");
        }
    }

    return self;
}

- (NSString *)getProperty:(NSString *)propertyName {
    return [self.dictionary objectForKey:propertyName];
}

#pragma mark NSCoding

#define kId               @"Id"
#define kLongitude        @"longitude"
#define kLatitude         @"latitude"
#define kStandardImageUrl @"standardImageUrl"
#define kArrayIndex       @"arrayIndex"
#define kFavoriteBool     @"favoriteBool"

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:Id forKey:kId];
    [encoder encodeObject:longitude forKey:kLongitude];
    [encoder encodeObject:latitude forKey:kLatitude];
    [encoder encodeObject:standardImageUrl forKey:kStandardImageUrl];
    [encoder encodeObject:arrayIndex forKey:kArrayIndex];
    [encoder encodeObject:favoriteBool forKey:kFavoriteBool];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.Id = [decoder decodeObjectForKey:kId];
    self.longitude = [decoder decodeObjectForKey:kLongitude];
    self.latitude = [decoder decodeObjectForKey:kLatitude];
    self.standardImageUrl = [decoder decodeObjectForKey:kStandardImageUrl];
    self.arrayIndex = [decoder decodeObjectForKey:kArrayIndex];
    self.favoriteBool = [decoder decodeObjectForKey:kFavoriteBool];

    self.location = [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];

    return self;
}

























@end
