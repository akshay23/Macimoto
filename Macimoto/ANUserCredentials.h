//
//  ANUserCredentials.h
//  AppServiceClient
//
//  Created by Nathan Rowe on 1/17/13.
//  Copyright (c) 2013 Animoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANUserCredentials : NSObject
@end



@interface ANUserAnimotoLoginCredentials : ANUserCredentials
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@end



@interface ANUserFacebookLoginCredentials : ANUserCredentials
@property (nonatomic, strong) NSString *facebookAccessToken;
@end



@interface ANUserRegistrationCredentials: ANUserCredentials
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@end



