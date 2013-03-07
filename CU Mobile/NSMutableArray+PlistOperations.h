//
//  NSMutableArray+PlistOperations.h
//  CU Mobile
//
//  Created by Robert Varga on 28/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (PlistOperations)

    //CRUD operations on plist

//Load data from Plist file
+ (NSMutableArray *)loadDataFromPlist:(NSString *)plist forKey:(NSString *)key;

//create, update on Plist file
- (void)saveToPlist:(NSString *)plist forKey:(NSString *)key;

@end
