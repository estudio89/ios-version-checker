//
//  AbstractUpdatesExecutor.m
//  E89iOSVersionChecker
//
//  Created by Rodrigo Suhr on 12/5/16.
//  Copyright © 2016 Estúdio 89. All rights reserved.
//

#import "AbstractUpdatesExecutor.h"
#import "VersionChecker.h"

@implementation AbstractUpdatesExecutor

- (instancetype)initWithDelegate:(id <UpdateDelegate>)delegate withInfo:(NSDictionary *)updateInfo {
    self = [super init];
    
    if (self) {
        _updateInfo = updateInfo;
        _delegate = delegate;
        _appOldVersion = [updateInfo valueForKey:[VersionChecker PENDING_INFO_OLD_VERSION]];
        _appNewVersion = [updateInfo valueForKey:[VersionChecker PENDING_INFO_NEW_VERSION]];
    }
    
    return self;
}

- (void)runUpdate {
}

@end
