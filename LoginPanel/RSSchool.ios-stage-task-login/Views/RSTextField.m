//
//  RSTextField.m
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 04.07.2021.
//

#import "RSTextField.h"

@implementation RSTextField
- (instancetype)init {
	self = [super init];
	if (self) {
		[self initStyle];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		[self initStyle];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self initStyle];
	}
	return self;
}

- (void)initStyle {
	self.layer.cornerRadius = 5;
	self.layer.borderWidth = 1.5;
	[self setStatus:RSTextFieldReady];
}

- (void)setStatus:(RSTextFieldStatus)status {
	if (_status == status) {
		return;
	}
	_status = status;
	UIColor *borderColor = nil;
	switch (_status) {
		case RSTextFieldReady:
			borderColor = [UIColor colorNamed:@"blackCoral"];
			break;
			
		case RSTextFieldError:
			borderColor = [UIColor colorNamed:@"venetianRed"];
			break;
			
		case RSTextFieldSuccess:
			borderColor = [UIColor colorNamed:@"turquoiseGreen"];
			break;
	}
	
	self.layer.borderColor = borderColor.CGColor;
}

- (void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	
	self.alpha = enabled ? 1.0 : 0.5;
}

@end
