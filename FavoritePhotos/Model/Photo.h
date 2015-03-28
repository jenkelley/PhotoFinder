//
//  BSBusStop.h
//  BSBusChallenge
//
//  Created by Mick Lerche on 3/24/15.
//  Copyright (c) 2015 Mick Lerche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Photo : NSObject
@property NSDictionary *dictionary;
@property NSString *ID;
@property CLLocation *location;
@property NSString *longitude;
@property NSString *latitude;
@property NSString *standardImageUrl;
@property int arrayIndex;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary arrayIndex:(int)arrayIndex;
- (NSString *)getProperty:(NSString *)propertyName;

@end
