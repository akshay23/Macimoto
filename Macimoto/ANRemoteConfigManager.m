//
//  ANRemoteConfigManager.m
//  RemoteConfigManager
//
//  Created by Robin Hill on 8/21/14.
//  Copyright (c) 2014 Animoto. All rights reserved.
//

#import "ANRemoteConfigManager.h"

@interface ANRemoteConfigManager()

@property (nonatomic, strong) NSCache * createdVars;
@property (nonatomic, strong) NSMutableSet * trackedKeys;

@end

NSString * ANRemoteConfigVariableChangedNotification = @"com.animoto.ANRemoteConfigVariableChangedNotification";
NSString * kANRemoteConfigVariableChangedKey = @"com.animoto.kANReportChangedRemoteConfigVariableKey";

@implementation ANRemoteConfigManager

static dispatch_once_t _ANRemoteConfigManager_dispatch_once_pred;

+ (ANRemoteConfigManager *) sharedManager
{
    static ANRemoteConfigManager *_sharedInstance = nil;
    dispatch_once(&_ANRemoteConfigManager_dispatch_once_pred, ^{
        _sharedInstance = [[ANRemoteConfigManager alloc] init];
    });
    return _sharedInstance;
}

- (id) init {
    self= [super init];
    
    if (self) {
        
        self.trackedKeys = [[NSMutableSet alloc] init];
        self.createdVars = [[NSCache alloc] init];
    }
    
    return self;
}


// Try to get the object associated with the given key. Return nil if object can't be found or is not the desired type.
- (id) getValueForKey:(NSString *) key andEnsureType: (Class) desiredType {
    @try {
        if (key == nil) return nil;
      id val = nil;
        if (val == nil || ![val isKindOfClass:desiredType]) return nil;
        return val;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception thrown while trying to get configuration for %@ : %@", key, exception);
    }
}


#pragma mark - Get Values

// Gets the BOOL value associated with the key. If all else goes wrong, will return NO.
- (BOOL) getBoolForKey: (NSString *) key {
    
    id val = [self getValueForKey:key andEnsureType:[NSNumber class]];
    return [val boolValue];
}

// Gets the NSInteger associated with the key. If all else goes wrong, will return 0;
- (NSInteger) getIntegerForKey: (NSString *) key {
    id val = [self getValueForKey:key andEnsureType:[NSNumber class]];
    return [val integerValue];
}

//Gets the NSString associated with the key. If all else goes wrong, will return nil
- (NSString *) getStringForKey: (NSString *) key {
    id val = [self getValueForKey:key andEnsureType:[NSString class]];
    return (NSString *) val;
}

//Gets the NSArray associated with the key. If all else goes wrong, will return nil
- (NSArray *) getArrayForKey: (NSString *) key {
    id val = [self getValueForKey:key andEnsureType:[NSArray class]];
    
    if ([val isKindOfClass:[NSArray class]]) {
        return (NSArray *) val;
    } else {
        return nil;
    }
}


#pragma mark - Define Values

- (void) defineBoolForKey: (NSString *) key withDefault: (BOOL) defaultValue {
    @try {
//        LPVar * newVar = [LPVar define:key withBool:defaultValue];
//        [self.createdVars setObject:newVar forKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception while trying to define BOOL for key %@ : %@", key, exception);
    }
}

- (void) defineIntegerForKey: (NSString *) key withDefault: (NSInteger) defaultValue {
    @try {
//        LPVar * newVar = [LPVar define:key withInteger:defaultValue];
//        [self.createdVars setObject:newVar forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"Exception while trying to define Integer for key %@ : %@", key, exception);

    }
}

- (void) defineStringForKey: (NSString *) key withDefault: (NSString *) defaultValue {

    @try {
//        LPVar * newVar = [LPVar define:key withString:defaultValue];
//        [self.createdVars setObject:newVar forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"Exception while trying to define String for key %@ : %@", key, exception);
    }
    
}



- (void) defineArrayForKey: (NSString *) key withDefault: (NSArray *) defaultValue {
    
    @try {
//      LPVar * newVar = [LPVar define:key withArray:defaultValue];
//      [self.createdVars setObject:newVar forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"Exception while trying to define Array for key %@ : %@", key, exception);
    }
    
}

- (NSString *) reportChangesForKey: (NSString *) key
{
    if (![self.trackedKeys containsObject:key]) {
        
//        LPVar * keyVar = [self.createdVars objectForKey:key];
//        
//        __block NSString * blockKey = [NSString stringWithString:key];
//        if (keyVar != nil) {
//            [self.trackedKeys addObject:key];
//            [keyVar onValueChanged:^void () {
//                [self notifyValueChanged:blockKey];
//            }];
//        }
//        
//        return key;
    }
    
    return nil;
}

- (void) notifyValueChanged:(NSString *)key
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ANRemoteConfigVariableChangedNotification object:nil userInfo:@{kANRemoteConfigVariableChangedKey : key}];
}




@end
