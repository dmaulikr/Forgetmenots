//
//  FmnSettings.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 28.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnSettings.h"

@implementation FmnSettings

+(void)saveSettingsString:(NSString *)string withKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getSettingsStringWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

@end
