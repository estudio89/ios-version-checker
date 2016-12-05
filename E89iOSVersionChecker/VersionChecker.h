//
//  VersionChecker.h
//  E89iOSVersionChecker
//
//  Created by Rodrigo Suhr on 12/5/16.
//  Copyright © 2016 Estúdio 89. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VersionChangeDelegate <NSObject>

- (void)onAppUpgrade:(NSString *)oldVersionCode withNewVersion:(NSString *)newVersionCode;
- (void)onAppInstall:(NSString *)newVersionCode;

@end

@interface VersionChecker : NSObject

+ (VersionChecker *)getInstance;
+ (NSString *)PENDING_INFO_OLD_VERSION;
+ (NSString *)PENDING_INFO_NEW_VERSION;
- (instancetype)initWithDelegate:(id <VersionChangeDelegate>)delegate;
- (NSDictionary *)getPendingUpdateInfo;
- (void)clearPendingUpdates;

@end
