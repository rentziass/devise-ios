//
//  SSKUser.m
//  SaasKit
//
//  Created by Patryk Kaczmarek on 19.11.2014.
//  Copyright (c) 2014 Netguru.co. All rights reserved.
//

#import "SSKUser.h"
#import "SSKAPIManager.h"
#import "SSKUser+Validation.h"


@interface SSKUser ()

@property (strong, nonatomic) NSDictionary *localExtraLoginParams;
@property (strong, nonatomic) NSDictionary *localExtraRegistrationParams;
@property (strong, nonatomic) NSDictionary *localExtraRemindPasswordParams;

@end

@implementation SSKUser

#pragma mark - Public Methods

- (instancetype)init {
    self = [super init];
    if (self) {
        _loginMethod = SSKLoginUsingEmail;
    }
    return self;
}

+ (instancetype)user {
    return [[[self class] alloc] init];
}

- (NSDictionary *)extraLoginParams {
    return self.localExtraLoginParams;
}

- (NSDictionary *)extraRegistrationParams {
    return self.localExtraRegistrationParams;
}

- (NSDictionary *)extraRemindPasswordParams {
    return self.localExtraRemindPasswordParams;
}

#pragma mark - Login methods:

- (void)loginWithSuccess:(SSKVoidBlock)success failure:(SSKErrorBlock)failure {
    
    NSError *error;
    if (![self loginValidationWithError:&error]) {
        failure(error);
        return;
    }
    
    [SSKAPIManager loginUser:self withSuccess:success failure:failure];
}

- (void)loginWithExtraParams:(SSKExtraParamsBlock)params success:(SSKVoidBlock)success failure:(SSKErrorBlock)failure {
    
    self.localExtraLoginParams = params();
    [self loginWithSuccess:success failure:failure];
}

#pragma mark - Remind password methods:

- (void)remindPasswordWithSuccess:(SSKVoidBlock)success failure:(SSKErrorBlock)failure {
    
    NSError *error;
    if (![self remindPasswordValidationWithError:&error]) {
        failure(error);
        return;
    }
    [SSKAPIManager remindPasswordForUser:self withSuccess:success failure:failure];
}

- (void)remindPasswordWithExtraParams:(SSKExtraParamsBlock)params success:(SSKVoidBlock)success failure:(SSKErrorBlock)failure {
    
    self.localExtraRemindPasswordParams = params;
    [self remindPasswordWithSuccess:success failure:failure];
}

+ (void)remindPasswordWithEmail:(NSString *)email success:(SSKVoidBlock)success failure:(SSKErrorBlock)failure {
    
    SSKUser *user = [SSKUser user];
    user.email = email;
    [user remindPasswordWithSuccess:success failure:failure];
}

#pragma mark - Register methods:

- (void)registerWithSuccess:(SSKVoidBlock)success failure:(SSKErrorBlock)failure {
    [SSKAPIManager registerUser:self withSuccess:success failure:failure];
}

- (void)registerWithExtraParams:(SSKExtraParamsBlock)params success:(SSKVoidBlock)success failure:(SSKErrorBlock)failure {
    
    self.localExtraRegistrationParams = params();
    [self registerWithSuccess:success failure:failure];
}

#pragma mark - Private Methods

@end