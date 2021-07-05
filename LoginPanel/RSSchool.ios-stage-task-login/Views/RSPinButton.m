//
//  RSPinButton.m
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 05.07.2021.
//

#import "RSPinButton.h"

@implementation RSPinButton

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
	self.layer.cornerRadius = self.frame.size.width/2;
	self.layer.borderWidth = 1.5;
	self.layer.borderColor = self.tintColor.CGColor;
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	
	[self setBackgroundColor: highlighted ? [self.tintColor colorWithAlphaComponent:0.2] : nil];
	
}

@end
