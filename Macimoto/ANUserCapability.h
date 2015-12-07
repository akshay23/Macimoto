//
//  ANUserCapability.h
//  AppServiceClient
//
//  Created by Robin Hill on 10/25/13.
//  Copyright (c) 2013 Animoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ANUser;

@interface ANUserCapability : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) ANUser *fkANUserCapabilityToANUser;

@end
