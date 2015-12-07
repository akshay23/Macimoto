//
//  ANRemoteConfigManager.h
//  RemoteConfigManager
//
//  Created by Robin Hill on 8/21/14.
//  Copyright (c) 2014 Animoto. All rights reserved.
//




/**
 ANRemoteConfigManager allows apps to setup and use a consistent interface to fetch key/value pairs that may be synced with a remote service. Currently,
 only a Leanplum backend is supported, but eventually this can grow to add other types of backends with the interface to client code remaining consistent
 around the "define..." and "get..." methods declared here.
 
 Client code is expected to know which backend it is using, since vendored backends like Leanplum have special setup requirements (eg. app-specific keys). 
 However, that setup should be done in a contained subclass that does setup at the appropriate time. The only requirement there is to assign the ANRemoteConfigType 
 property so that this module knows how to set and get values from the backend.
 
 === Subclassing ANRemoteConfigManager
 
 The purpose of subclassing ANRemoteConfigManager is to create a hook that allows initializing of any remote configuration backend. You should define a method "start" in
 your subclass that gets invoked whenever the application launches. Use the method the setup Leanplum or any other supported backend in the future. 
 
 
 === ANConfigurationDefinition
 
 ANConfigurationDefinition is a hook to allow multiple modules to define variables for the remote configuration separately and independently, but have them all tied together
 in one initialization pass. Specifically, each module can define its own class implementing the ANConfigurationDefinition protocol that supports the 
 -[ANConfigurationDefinition loadConfigurationsIntoManager:] method. This method's job is to define configuration mappings within the supplied configuration manager. You can 
 chain these methods -- have a base ANConfigurationDefinition in your app that contains references to other ANConfigurationDefinition objects from other modules and invoke the 
 loadConfigurationManager for all of them from the main app's method. 
 
 
 === Edge case behavior
 
 See the unit tests (RemoteConfigManagerTests) for more specific guidance, but generally the "get..." methods will always return some value.  Almost all of the time, this will be
 a value you define either as the default or as a remotely configured value that was successfully fetched. The only time where a fallback value will be used is if client code 
 supplies an invalid or unknown key. In those cases, you should be prepared to handle the fallback value, which is documented above each "get..." method below.
 
 
 === Future work
 
 ** Add a local dictionary storing the default defined values as a fallback in case Leanplum or other remote backend communication cannot be established. 
 
 
 **/


#import <Foundation/Foundation.h>

// Indicates the type of backend that is going to be used 
typedef enum {
    ANRemoteConfigWithLeanPlum = 0
} ANRemoteConfigType;

extern NSString * ANRemoteConfigVariableChangedNotification;
extern NSString * kANRemoteConfigVariableChangedKey;

@interface ANRemoteConfigManager : NSObject

@property (nonatomic, assign) ANRemoteConfigType configType;


#pragma mark - Define Values
- (void) defineBoolForKey: (NSString *) key withDefault: (BOOL) defaultValue;
- (void) defineIntegerForKey: (NSString *) key withDefault: (NSInteger) defaultValue;
- (void) defineStringForKey: (NSString *) key withDefault: (NSString *) defaultValue;
- (void) defineArrayForKey: (NSString *) key withDefault: (NSArray *) defaultValue; 

#pragma mark - Get Values

// Gets the BOOL value associated with the key. If all else goes wrong, will return NO.
- (BOOL) getBoolForKey: (NSString *) key;

// Gets the NSInteger associated with the key. If all else goes wrong, will return 0;
- (NSInteger) getIntegerForKey: (NSString *) key;

//Gets the NSString associated with the key. If all else goes wrong, will return nil
- (NSString *) getStringForKey: (NSString *) key;

//Gets the NSArray associated with the key. If all else goes wrong, will return nil
- (NSArray *) getArrayForKey: (NSString *) key; 

/**
 Will report changes to values for the given key using a notifcation (on the default notification center) whenever
 the value for that key changes. If this method is called multiple times, there is no effect after the first time ...
 it will always report changes with the same notification.
 **/
- (NSString *) reportChangesForKey: (NSString *) key;

@end
