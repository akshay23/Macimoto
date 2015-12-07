//
//  ANConfigurationDefinition.h
//  Pods
//
//  Created by Faisal Anwar on 9/18/14.
//
//

#import "ANRemoteConfigManager.h"

@protocol ANConfigurationDefinition <NSObject>

- (void) loadConfigurationsIntoManager: (ANRemoteConfigManager *) configManager;

@end

