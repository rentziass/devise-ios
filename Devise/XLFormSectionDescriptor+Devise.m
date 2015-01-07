//
//  XLFormSectionDescriptor+Devise.m
//  Devise
//
//  Created by Wojciech Trzasko on 29.12.2014.
//  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
//

#import "XLFormSectionDescriptor+Devise.h"

#import "XLFormRowDescriptor+Devise.h"

NSString * const DVSFormEmailTag = @"email";
NSString * const DVSFormPasswordTag = @"password";
NSString * const DVSFormProceedButtonTag = @"proceedButton";
NSString * const DVSFormDismissButtonTag = @"dismissButton";
NSString * const DVSFormPresentButtonTag = @"presentButton";

@implementation XLFormSectionDescriptor (Devise)

- (void)dvs_addEmailAndPasswordTextFields {
    [self dvs_addEmailTextField];
    [self dvs_addPasswordTextField];
}

- (void)dvs_addEmailTextField {
    [self addFormRow:[XLFormRowDescriptor dvs_emailRowWithTag:DVSFormEmailTag]];
}

- (void)dvs_addPasswordTextField {
    [self addFormRow:[XLFormRowDescriptor dvs_passwordRowWithTag:DVSFormPasswordTag]];
}

- (void)dvs_addDismissButtonWithAction:(void (^)(XLFormRowDescriptor *))action {
    [self dvs_addDismissButtonWithTitle:NSLocalizedString(@"Cancel", nil)
                                 action:action];
}

- (void)dvs_addDismissButtonWithTitle:(NSString *)title action:(void (^)(XLFormRowDescriptor *))action {
    [self addFormRow:[XLFormRowDescriptor dvs_buttonRowWithTag:DVSFormDismissButtonTag
                                                         title:title
                                                         color:[UIColor redColor]
                                                        action:action]];
}

- (void)dvs_addProceedButtonWithTitle:(NSString *)title action:(void (^)(XLFormRowDescriptor *))action {
    [self addFormRow:[XLFormRowDescriptor dvs_buttonRowWithTag:DVSFormProceedButtonTag
                                                         title:title
                                                         color:[UIColor blueColor]
                                                        action:action]];
}

- (void)dvs_addPresentButtonWithTitle:(NSString *)title action:(void (^)(XLFormRowDescriptor *))action {
    [self addFormRow:[XLFormRowDescriptor dvs_buttonRowWithTag:DVSFormPresentButtonTag
                                                         title:title
                                                         color:[UIColor redColor]
                                                        action:action]];
}

@end