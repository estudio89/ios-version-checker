//
//  VersionChecker.m
//  E89iOSVersionChecker
//
//  Created by Rodrigo Suhr on 12/5/16.
//  Copyright © 2016 Estúdio 89. All rights reserved.
//

#import "VersionChecker.h"

@interface VersionChecker ()

@property (weak, nonatomic) id <VersionChangeDelegate> delegate;

@end

@implementation VersionChecker

static VersionChecker *instance;
static NSString *APP_VERSION_KEY = @"br.com.estudio89.engage.app_version";
static NSString *PENDING_UPDATE_KEY = @"pending_update";
static NSString *PENDING_INFO_OLD_VERSION = @"pending_old_version";
static NSString *PENDING_INFO_NEW_VERSION = @"pending_new_version";

+ (VersionChecker *)getInstance {
    return instance;
}

+ (NSString *)PENDING_INFO_OLD_VERSION {
    return PENDING_INFO_OLD_VERSION;
}

+ (NSString *)PENDING_INFO_NEW_VERSION {
    return PENDING_INFO_NEW_VERSION;
}

- (instancetype)initWithDelegate:(id<VersionChangeDelegate>)delegate {
    self = [super init];
    
    if (self) {
        _delegate = delegate;
        instance = self;
        [self runCheck];
    }
    
    return self;
}

- (void)runCheck {
    NSString *current = [self getCurrentVersion];
    NSString *stored = [self getStoredVersion];
    [self updateVersion];
    
    if (current == stored) {
        return;
    }
    
    if (current != stored) {
        if ([stored isEqualToString:@"-1"]) {
            [_delegate onAppInstall:current];
        } else {
            [_delegate onAppUpgrade:stored withNewVersion:current];
        }
    }
}

- (NSString *)getStoredVersion {
    NSString *version = [[NSUserDefaults standardUserDefaults] stringForKey:APP_VERSION_KEY];
    return version != nil ? version : @"-1";
}

- (void)updateVersion {
    [[NSUserDefaults standardUserDefaults] setValue:[self getCurrentVersion] forKey:APP_VERSION_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)getPendingUpdateInfo {
    NSString *info = [[NSUserDefaults standardUserDefaults] stringForKey:PENDING_UPDATE_KEY];
    if (info == nil) {
        return nil;
    }
    
    NSString *oldVersion = [[info componentsSeparatedByString:@";"] objectAtIndex:0];
    NSString *newVersion = [[info componentsSeparatedByString:@";"] objectAtIndex:1];
    
    return @{PENDING_INFO_OLD_VERSION:oldVersion, PENDING_INFO_NEW_VERSION:newVersion};
}

- (BOOL)hasPendingUpdates {
    return [self getPendingUpdateInfo] != nil;
}

- (void)addPendingUpdate:(NSString *)oldVersion withNewVersion:(NSString *)newVersion {
    NSString *pending = [NSString stringWithFormat:@"%@;%@", oldVersion, newVersion];
    [[NSUserDefaults standardUserDefaults] setValue:pending forKey:PENDING_UPDATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearPendingUpdates {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PENDING_UPDATE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getCurrentVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}



@end
