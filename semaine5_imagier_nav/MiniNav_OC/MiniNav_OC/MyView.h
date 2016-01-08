//
//  MyView.h
//  
//
//  Created by Cao Sang DOAN on 11/10/15.
//
//

#import <UIKit/UIKit.h>

@interface MyView : UIView <UIWebViewDelegate, UIActionSheetDelegate, UIToolbarDelegate, UIAlertViewDelegate>

- (void) viewWillTransitionToSize:(CGSize) size;

@end
