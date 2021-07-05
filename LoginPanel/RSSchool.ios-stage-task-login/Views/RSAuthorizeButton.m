//
//  RSAuthorizeButton.m
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 04.07.2021.
//

#import "RSAuthorizeButton.h"

@implementation RSAuthorizeButton

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
	UIColor *color = self.tintColor;
	[self setTitleColor:color forState:UIControlStateNormal];
	[self setTitleColor:[color colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
	[self setTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];

	self.layer.cornerRadius = 10;
	self.layer.borderWidth = 2;
	self.layer.borderColor = self.currentTitleColor.CGColor;
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	
	[self setBackgroundColor: highlighted ? [self.tintColor colorWithAlphaComponent:0.2] : nil];
}

- (void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	
	self.layer.borderColor = self.currentTitleColor.CGColor;
}

@end
