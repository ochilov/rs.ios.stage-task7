//
//  RSTextField.h
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 04.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RSTextFieldStatus) {
	RSTextFieldReady,
	RSTextFieldError,
	RSTextFieldSuccess
};

@interface RSTextField : UITextField
@property (nonatomic) RSTextFieldStatus status;
@end

NS_ASSUME_NONNULL_END
