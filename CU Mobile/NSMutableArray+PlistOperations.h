//
//  NSMutableArray+PlistOperations.h
//  CU Mobile
//
//  Created by Robert Varga on 28/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (PlistOperations)

+ (NSMutableArray *)loadDataFromPlist:(NSString *)plist forKey:(NSString *)key;
//- (void)saveToPlist:(NSString *)plist forKey:(NSString *)key;

@end
