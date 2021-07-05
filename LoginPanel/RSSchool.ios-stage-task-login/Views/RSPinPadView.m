//
//  RSPinPadView.m
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 05.07.2021.
//

#import "RSPinPadView.h"

@implementation RSPinPadView

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
	self.layer.cornerRadius = 10;
	self.layer.borderWidth = 2;
	self.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setStatus:(RSPinPadStatus)status {
	if (_status == status) {
		return;
	}
	_status = status;
	UIColor *borderColor = nil;
	switch (_status) {
		case RSPinPadDefault:
			borderColor = [UIColor clearColor];
			break;
			
		case RSPinPadError:
			borderColor = [UIColor colorNamed:@"venetianRed"];
			break;
			
		case RSPinPadSuccess:
			borderColor = [UIColor colorNamed:@"turquoiseGreen"];
			break;
	}
	
	self.layer.borderColor = borderColor.CGColor;
}

@end
