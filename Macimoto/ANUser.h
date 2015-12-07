//
//  ANUser.h
//  AppServiceClient
//
//  Created by Robin Hill on 10/24/13.
//  Copyright (c) 2013 Animoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANSongLibrary, ANUserCapability;

@interface ANUser : NSManagedObject

@property (nonatomic, retain) NSString * appServiceId;
@property (nonatomic, retain) NSString * appServiceUrl;
@property (nonatomic, retain) NSString * asFacebookTokenUrl;
@property (nonatomic, retain) NSString * facebookAccessToken;
@property (nonatomic, retain) NSNumber * facebookUserID;
@property (nonatomic, retain) NSString * youtubeTokenUrl;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * lastSubscriptionReminder;
@property (nonatomic, retain) NSString * oKey;
@property (nonatomic, retain) NSString * subscriptionDisplayName;
@property (nonatomic, retain) NSDate * subscriptionExpiresAt;
@property (nonatomic, retain) NSString * subscriptionType;
@property (nonatomic, retain) NSString * subscriptionPurchaseService;
@property (nonatomic) BOOL * hasActiveRecurringPayment;
@property (nonatomic, retain) NSSet *fkANUserToANUserCapability;
@property (nonatomic, retain) NSString * vimeoAccessToken;
@end

@interface ANUser (CoreDataGeneratedAccessors)

- (void)addFkANUserToANUserCapabilityObject:(ANUserCapability *)values;
- (void)removeFkANUserToANUserCapabilityObject:(ANUserCapability *)values;
- (void)addFkANUserToANUserCapability:(NSSet *)values;
- (void)removeFkANUserToANUserCapability:(NSSet *)values;

@end
