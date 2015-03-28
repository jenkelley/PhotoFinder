//
//  BSDataManager.h
//  BSBusChallenge
//
//  Created by Mick Lerche on 3/24/15.
//  Copyright (c) 2015 Mick Lerche. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BSDataDelegate <NSObject>

@optional
- (void)gotPhotoData:(id)array;
- (void)gotGroupData:(id)array;

@end
@interface BSDataManager : NSObject

@property NSString *busUrl;
@property NSDictionary *dictionary;
@property NSArray *array;

@property (nonatomic, assign) id <BSDataDelegate> delegate;

- (void)getPhotoData:(NSString *)searchText;
- (void)getGroupData:(NSString *)searchText;


- (void)write:(NSMutableArray *)array;

- (NSMutableArray *)read;


@end


