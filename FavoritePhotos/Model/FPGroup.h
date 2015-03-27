//
//  FPGroup.h
//  FavoritePhotos
//
//  Created by Mick Lerche on 3/26/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPGroup : NSObject

@property NSDictionary *dictionary;
//@property NSString *ID;
@property NSString *name;
@property NSString *mediaCount;
@property NSString *standardImageUrl;
@property int arrayIndex;
//@property NSString *ctaStopName;
//@property NSString *interModal;
//@property NSString *address;
//@property BOOL isMetra;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary arrayIndex:(int)arrayIndex;
- (NSString *)getProperty:(NSString *)propertyName;

@end
