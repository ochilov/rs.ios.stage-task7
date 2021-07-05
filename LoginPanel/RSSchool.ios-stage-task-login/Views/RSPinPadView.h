//
//  RSPinPadView.h
//  RSSchool.ios-stage-task-login
//
//  Created by JohnO on 05.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RSPinPadStatus) {
	RSPinPadDefault,
	RSPinPadError,
	RSPinPadSuccess
};

@interface RSPinPadView : UIView
@property (nonatomic) RSPinPadStatus status;
@end

NS_ASSUME_NONNULL_END
