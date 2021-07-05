//
//  LoginViewController.m
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 04.07.2021.
//

#import "LoginViewController.h"
#import "RSTextField.h"
#import "RSPinPadView.h"

@interface LoginViewController () <UITextFieldDelegate> {
	NSInteger _secureAttempts;
	NSInteger _secureAttemptsMax;
	NSInteger _pinLength;
	
	CGFloat topContraintConstant;
	CGFloat bottomContraintConstant;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet RSTextField *loginField;
@property (weak, nonatomic) IBOutlet RSTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;
@property (weak, nonatomic) IBOutlet RSPinPadView *secureView;
@property (weak, nonatomic) IBOutlet UILabel *secureTitle;
@property (weak, nonatomic) IBOutlet UIButton *securePin1;
@property (weak, nonatomic) IBOutlet UIButton *securePin2;
@property (weak, nonatomic) IBOutlet UIButton *securePin3;

// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraintDefault;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraintWithKB;

@end


// MARK: - Keyboard category
@interface LoginViewController (KeyboardHandling)
- (void)subscribeOnKeyboardEvents;
- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;
- (void)hideKeyboard;
@end


// MARK: - implementation
@implementation LoginViewController
// MARK:- View Controller
- (void)viewDidLoad {
	[super viewDidLoad];
	_secureAttemptsMax = 3;
	_pinLength = 3;
	
	// contraints
	topContraintConstant = self.topContraint.constant;
	bottomContraintConstant = self.bottomContraintWithKB.constant;
	
	// add authorize action
	[self.authorizeButton addTarget:self
							 action:@selector(authorizeButtonTapped:)
				   forControlEvents:UIControlEventTouchUpInside];
	
	// add action for Login/Pass field changed
	UITextField *fields[] = {self.loginField, self.passwordField};
	for (int i = 0, cnt = (int)sizeof(fields)/sizeof(fields[0]); i < cnt; i++) {
		UITextField *field = fields[i];
		[field addTarget:self
				  action:@selector(fieldChanged:)
		forControlEvents:UIControlEventEditingChanged];
	}
	
	// add action for secure pins
	UIButton *pins[] = {self.securePin1, self.securePin2, self.securePin3};
	for (int i = 0, cnt = (int)sizeof(pins)/sizeof(pins[0]); i < cnt; i++) {
		UIButton *pin = pins[i];
		[pin addTarget:self
				action:@selector(securePinTapped:)
	  forControlEvents:UIControlEventTouchUpInside];
	}
	
	// subscrube on keyboard events
	[self subscribeOnKeyboardEvents];
	[self hideWhenTappedAround];

	// set delegates
	self.loginField.delegate = self;
	self.passwordField.delegate = self;
}


// MARK:- Control actions
- (void)authorizeButtonTapped:(UIButton *)sender {
	NSString *authorizeLogin = @"username";
	NSString *authorizePassword = @"password";
	
	BOOL loginSuccess = [self.loginField.text isEqualToString:authorizeLogin];
	BOOL passSuccess = [self.passwordField.text isEqualToString:authorizePassword];
	if (loginSuccess) {
		self.loginField.status = RSTextFieldSuccess;
	} else {
		self.loginField.status = RSTextFieldError;
	}
	if (passSuccess) {
		self.passwordField.status = RSTextFieldSuccess;
	} else {
		self.passwordField.status = RSTextFieldError;
	}
	if (!loginSuccess || !passSuccess) {
		return;
	}
	
	[self showPinPad];
}

- (void)fieldChanged:(RSTextField *)sender {
	[sender setStatus:RSTextFieldReady];
}

- (void)securePinTapped:(UIButton *)sender {
	if (sender.tag < 1 && 3 < sender.tag) {
		return;
	}
	
	// add code
	if ([self.secureTitle.text isEqualToString:@"-"]) {
		self.secureTitle.text = @"";
	} else if (self.secureTitle.text.length == _pinLength) {
		self.secureTitle.text = @"";
		self.secureView.status = RSPinPadDefault;
	}
	self.secureTitle.text = [self.secureTitle.text stringByAppendingFormat:@"%ld", sender.tag];
	
	// check code
	const NSInteger securePin = 132;
	if (self.secureTitle.text.length == _pinLength) {
		if (self.secureTitle.text.integerValue == securePin) {
			[self secureCodeSuccess];
		} else if (_secureAttempts++ < _secureAttemptsMax) {
			[self secureCodeFail];
		} else {
			[self startLogin];
		}
	}
}


// MARK:- Login controller
- (void)showPinPad {
	_secureAttempts = 1;
	self.secureTitle.text = @"-";
	self.secureView.status = RSPinPadDefault;
	self.secureView.hidden = NO;
	
	self.loginField.enabled = NO;
	self.passwordField.enabled = NO;
	self.authorizeButton.enabled = NO;
}

- (void)hidePinPad {
	self.secureTitle.text = @"-";
	self.secureView.hidden = YES;
	
	self.loginField.status = RSTextFieldReady;
	self.passwordField.status = RSTextFieldReady;
	
	self.loginField.enabled = YES;
	self.passwordField.enabled = YES;
	self.authorizeButton.enabled = YES;
}

- (void)secureCodeSuccess {
	self.secureView.status = RSPinPadSuccess;
	
	UIAlertController* alert = [UIAlertController
		alertControllerWithTitle:@"Welcome"
		message:@"You are successfuly authorized!"
		preferredStyle:UIAlertControllerStyleAlert];
	
	typeof(self) __weak weakSelf = self;
	UIAlertAction* actionOK = [UIAlertAction
		actionWithTitle:@"Refresh"
		style:UIAlertActionStyleDefault
		handler:^(UIAlertAction * _Nonnull action) {
			[weakSelf startLogin];
	}];
	[alert addAction:actionOK];
	
	[self presentViewController:alert animated:YES completion: nil];
}

- (void)secureCodeFail {
	self.secureView.status = RSPinPadError;
}

- (void)startLogin {
	self.loginField.text = @"";
	self.passwordField.text = @"";
	
	self.loginField.status = RSTextFieldReady;
	self.passwordField.status = RSTextFieldReady;
	
	[self hidePinPad];
}

// MARK: - Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self hideKeyboard];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField != self.loginField) {
		return YES;
	}
	if (string.length == 0) {
		return YES;
	}
	static NSCharacterSet *forbiddenCharacters = nil;
	static NSCharacterSet *lowercaseCharacters = nil;
	if (!forbiddenCharacters) {
		lowercaseCharacters = [NSCharacterSet characterSetWithRange:NSMakeRange('a', 'z'-'a'+1)];
		NSMutableCharacterSet *allowedCharacters = [[NSMutableCharacterSet alloc] init];
		[allowedCharacters addCharactersInRange:NSMakeRange('A', 'Z'-'A'+1)]; // Add uppercase
		[allowedCharacters addCharactersInRange:NSMakeRange('a', 'z'-'a'+1)]; // Add lowercase
		forbiddenCharacters = allowedCharacters.invertedSet;
	}
	// check to allowed symbols
	if ([string rangeOfCharacterFromSet:forbiddenCharacters].location != NSNotFound) {
		return NO;
	}
	
	// check to first character is lowercase
	if (range.location == 0 &&
		![lowercaseCharacters characterIsMember:[string characterAtIndex: 0]]
	) {
		return NO;
	}
	
	return YES;
}

@end



// MARK: - Keyboard category
@implementation LoginViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents {
	// Keyboard will show
	[NSNotificationCenter.defaultCenter addObserver:self
										   selector:@selector(keybaordWillShow:)
											   name:UIKeyboardWillShowNotification
											 object:nil];
	// Keyboard will hide
	[NSNotificationCenter.defaultCenter addObserver:self
										   selector:@selector(keybaordWillHide:)
											   name:UIKeyboardWillHideNotification
											 object:nil];
}

- (void)hideWhenTappedAround {
	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
																			  action:@selector(hideKeyboard)];
	[self.view addGestureRecognizer:gesture];
}

- (void)hideKeyboard {
	[self.view endEditing:true];
}

- (void)keybaordWillShow:(NSNotification *)notification {
	CGRect rect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	self.bottomContraintDefault.active = NO;
	self.bottomContraintWithKB.active = YES;
	[self updateTopContraintWith:55.0 andBottom:rect.size.height - self.view.safeAreaInsets.bottom + 55.0];
}

- (void)keybaordWillHide:(NSNotification *)notification {
	self.bottomContraintWithKB.active = NO;
	self.bottomContraintDefault.active = YES;
	[self updateTopContraintWith:topContraintConstant andBottom:bottomContraintConstant];
}

- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
	self.topContraint.constant = constant;
	self.bottomContraintWithKB.constant = bottomConstant;
	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
}

@end
