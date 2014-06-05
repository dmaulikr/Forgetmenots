//
//  FmnSettings.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 28.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FmnSettings : NSObject

#define SETTINGS_RANDOM_PERIOD @"SETTINGS_RANDOM_PERIOD"
#define LOADED_DEFAULT_FLOWERS @"LOADED_DEFAULT_FLOWERS"
#define CLEANED_UP_OLD_NOTIFICATIONS @"CLEANED_UP_OLD_NOTIFICATIONS"

+(void)saveSettingsString:(NSString *)string withKey:(NSString *)key;

+(NSString *)getSettingsStringWithKey:(NSString *)key;

@end
