//
//  LoginSplashViewController.m
//  edXVideoLocker
//
//  Created by Jotiram Bhagat on 16/02/15.
//  Copyright (c) 2015 edX. All rights reserved.
//

#import "OEXLoginSplashViewController.h"

#import "edX-Swift.h"

#import "OEXRouter.h"
#import "OEXLoginViewController.h"
#import "OEXSession.h"

@interface OEXLoginSplashViewController ()

@property (strong, nonatomic) IBOutlet UIButton* signInButton;
@property (strong, nonatomic) IBOutlet UIButton* signUpButton;
@property (strong, nonatomic) IBOutlet UIButton* skipButton;

@property (strong, nonatomic) RouterEnvironment* environment;

@end

@implementation OEXLoginSplashViewController

- (id)initWithEnvironment:(RouterEnvironment*)environment {
    self = [super initWithNibName:nil bundle:nil];
    if(self != nil) {
        self.environment = environment;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.signInButton setTitle:[Strings loginSplashSignIn] forState:UIControlStateNormal];
    [self.signUpButton applyButtonStyleWithStyle:[self.environment.styles filledPrimaryButtonStyle] withTitle:[Strings loginSplashSignUp]];
    [self.skipButton applyButtonStyleWithStyle:[self.environment.styles filledPrimaryButtonStyle] withTitle:@"Skip for now!"];
    [self.signInButton.titleLabel setFont:[self.environment.styles boldSansSerifOfSize:14.0f]];
    [self.signInButton setAccessibilityIdentifier:@"LoginSpashViewController:sign-in-button"];
    [self.signInButton setAccessibilityIdentifier:@"LoginSpashViewController:sign-up-button"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (IBAction)showLogin:(id)sender {
    [self.environment.router showLoginScreenFromController:self completion:nil];
}

- (IBAction)showRegistration:(id)sender {
    [self.environment.router showSignUpScreenFromController:self completion:nil];
}
- (IBAction)skipSignIn:(UIButton *)sender {
    [self.environment.router showEnrolledTabBarView];
}

- (BOOL) shouldAutorotate {
    return false;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
