//
//  DVSDemoUser.h
//  Devise
//
//  Created by Patryk Kaczmarek on 15.12.2014.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import <Devise/Devise.h>

@interface DVSDemoUser : DVSUser

/// User's username.
@property (strong, nonatomic) NSString *username;

/// User's first name.
@property (strong, nonatomic) NSString *firstName;

/// User's last name.
@property (strong, nonatomic) NSString *lastName;

/// User's phone number.
@property (strong, nonatomic) NSNumber *phone;

@end