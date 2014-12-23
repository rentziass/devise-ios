//
//  WelcomeViewController.m
//  Devise
//
//  Created by Grzegorz Lesiak on 20/11/14.
//  Copyright (c) 2014 Netguru.co. All rights reserved.
//

#import "DVSDemoWelcomeViewController.h"

#import "DVSMacros.h"
#import "DVSLoginViewController.h"
#import "DVSSignUpViewController.h"
#import "UIAlertView+DeviseDemo.h"

static NSString * const DVSRegisterSegue = @"DisplayRegisterView";
static NSString * const DVSLoginSegue = @"DisplayLoginView";
static NSString * const DVSHomeSegue = @"DisplayHomeView";

static NSString * const DVSDefaultWelcomeCell = @"defaultCell";

@interface DVSDemoWelcomeViewController () <DVSLogInViewControllerDelegate, DVSSignUpViewControllerDelegate>

@end

@implementation DVSDemoWelcomeViewController

#pragma mark - Object lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataSource];
}

#pragma mark - Setup

- (void)setupDataSource {
    [self addMenuEntryWithTitle:NSLocalizedString(@"Sign up", nil)
                       subtitle:NSLocalizedString(@"Create new account", nil)
                       selector:@selector(didSelectRegister)];
    [self addMenuEntryWithTitle:NSLocalizedString(@"Log in", nil)
                       subtitle:NSLocalizedString(@"Already registered?", nil)
                       selector:@selector(didSelectLogIn)];
}

#pragma mark - Menu actions

- (void)didSelectLogIn {
    
#if ENABLE_DEVISE_CONTROLLERS
    DVSLogInViewController *logInController = [[DVSLogInViewController alloc] initWithViewsOptions:DVSLogInViewsEmailAndPassword | DVSLogInViewsLogInButton | DVSLogInViewsDismissButton];
    logInController.delegate = self;
    [self presentViewController:logInController animated:YES completion:nil];
#else
    [self performSegueWithIdentifier:DVSLoginSegue sender:self];
#endif
    
}

- (void)didSelectRegister {
#if ENABLE_DEVISE_CONTROLLERS
    DVSSignUpViewController *signUpController = [[DVSSignUpViewController alloc] initWithViewsOptions:DVSSignUpViewsEmailAndPassword | DVSSignUpViewsDismissButton | DVSSignUpViewsSignUpButton];
    signUpController.delegate = self;
    [self presentViewController:signUpController animated:YES completion:nil];
#else
    [self performSegueWithIdentifier:DVSLoginSegue sender:self];
#endif
}

#pragma mark - DVSMenuTableViewController methods

- (NSString *)defaultCellId {
    return DVSDefaultWelcomeCell;
}

DVSWorkInProgress("Need to move DVSLoginViewControllerDelegate to separate class");

#pragma mark - DVSLoginViewControllerDelegate

- (void)logInViewController:(DVSLogInViewController *)controller didLogInUser:(DVSUser *)user {
    [self performSegueWithIdentifier:DVSHomeSegue sender:self];
}

- (void)logInViewController:(DVSLogInViewController *)controller didFailedWithError:(NSError *)error {
    UIAlertView *errorAlert = [UIAlertView dvs_alertViewForError:error
                                    statusDescriptionsDictionary:@{ @401: NSLocalizedString(@"Incorrect e-mail or password.", nil) }];
    [errorAlert show];
}

#pragma mark - DVSSignUpViewControllerDelegate

- (void)signUpViewController:(DVSSignUpViewController *)controller didSignUpUser:(DVSUser *)user {
    [self performSegueWithIdentifier:DVSHomeSegue sender:self];
}

- (void)signUpViewController:(DVSSignUpViewController *)controller didFailedWithError:(NSError *)error {
    UIAlertView *errorAlert = [UIAlertView dvs_alertViewForError:error
                                    statusDescriptionsDictionary:@{ @422: NSLocalizedString(@"E-mail is already taken.", nil) }];
    [errorAlert show];
}

@end