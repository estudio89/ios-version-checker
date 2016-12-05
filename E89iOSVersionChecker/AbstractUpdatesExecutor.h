//
//  AbstractUpdatesExecutor.h
//  E89iOSVersionChecker
//
//  Created by Rodrigo Suhr on 12/5/16.
//  Copyright © 2016 Estúdio 89. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpdateDelegate <NSObject>

- (void)onUpdateFinished;
- (void)onUpdateFailed;

@end

@interface AbstractUpdatesExecutor : NSObject

@property (weak, nonatomic) id <UpdateDelegate> delegate;
@property (strong, nonatomic) NSDictionary *updateInfo;
@property (strong, nonatomic) NSString *appOldVersion;
@property (strong, nonatomic) NSString *appNewVersion;

- (instancetype)initWithDelegate:(id <UpdateDelegate>)delegate withInfo:(NSDictionary *)updateInfo;
- (void)runUpdate;

@end
