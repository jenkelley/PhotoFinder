//
//  FPGroup.m
//  FavoritePhotos
//
//  Created by Mick Lerche on 3/26/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "FPGroup.h"

@implementation FPGroup

-(instancetype)initWithDictionary:(NSDictionary *)dictionary arrayIndex:(int)arrayIndex {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = [self.dictionary objectForKey:@"name"];
        self.mediaCount = [[self.dictionary objectForKey:@"media_count"] stringValue];
        //        self.interModal = [self.dictionary objectForKey:@"inter_modal"];
        //        self.address = [self.dictionary objectForKey:@"_address"];
        //        self.isMetra = [[self.dictionary objectForKey:@"inter_modal"] isEqualToString:@"Metra"];
    }

    return self;
}

- (NSString *)getProperty:(NSString *)propertyName {
    
    return [self.dictionary objectForKey:propertyName];
}


@end
