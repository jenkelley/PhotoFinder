//
//  BSBusStop.m
//  BSBusChallenge
//
//  Created by Mick Lerche on 3/24/15.
//  Copyright (c) 2015 Mick Lerche. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithDictionary:(NSDictionary *)dictionary arrayIndex:(int)arrayIndex {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;

        NSDictionary *locationDictionary = [self.dictionary objectForKey:@"location"];
        if (locationDictionary != (id)[NSNull null]) {
            self.latitude = [locationDictionary objectForKey:@"latitude"];
            self.longitude = [locationDictionary objectForKey:@"longitude"];
            self.location = [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];
        } else {
            NSLog(@"NO LOCATION SPECIFIED");
        }

        self.arrayIndex = arrayIndex;

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
//if you need anything else in the json data that we haven't specified, use this
- (NSString *)getProperty:(NSString *)propertyName {

    return [self.dictionary objectForKey:propertyName];
}




@end
