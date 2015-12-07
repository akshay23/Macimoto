//
//  ANUserCredentials.m
//  AppServiceClient
//
//  Created by Nathan Rowe on 1/17/13.
//  Copyright (c) 2013 Animoto. All rights reserved.
//

#import "ANUserCredentials.h"

/*! @discussion
 Backend needs to get the Animoto access token as well for actual login
 */


@implementation ANUserCredentials
@end



@implementation ANUserAnimotoLoginCredentials
- (NSString *)description
{
	return [NSString stringWithFormat:@"[%@  userName:%@  password:%@]", [super description], self.userName, self.password];
}
@end



@implementation ANUserFacebookLoginCredentials : ANUserCredentials
- (NSString *)description
{
	return [NSString stringWithFormat:@"[%@  fb AT:%@]", [super description], self.facebookAccessToken];
}
@end



@implementation ANUserRegistrationCredentials
- (NSString *)description
{
	return [NSString stringWithFormat:@"[%@ firstName:%@  lastName:%@  userName:%@  password:%@]", [super description], self.firstName, self.lastName, self.userName, self.password];
}
@end
