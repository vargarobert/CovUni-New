//
//  NSMutableArray+PlistOperations.m
//  CU Mobile
//
//  Created by Robert Varga on 28/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "NSMutableArray+PlistOperations.h"

@implementation NSMutableArray (PlistOperations)

+ (NSMutableArray *)loadDataFromPlist:(NSString *)plist forKey:(NSString *)key {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *path = [docDir stringByAppendingPathComponent:plist];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:path]) {
        NSArray *fileArray = [plist componentsSeparatedByString:@"."];
        NSString *name = [fileArray objectAtIndex:0];
        NSString *ext = [fileArray objectAtIndex:1];
        NSString *bundle = [[NSBundle mainBundle] pathForResource:name ofType:ext];
        [fileMgr copyItemAtPath:bundle toPath:path error:&error];
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSMutableArray *data = [dict objectForKey:key];
    return data;
}

- (void)saveToPlist:(NSString *)plist forKey:(NSString *)key {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *path = [docDir stringByAppendingPathComponent:plist];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    [data setObject:self forKey:key];
    [data writeToFile: path atomically:YES];
}

@end
