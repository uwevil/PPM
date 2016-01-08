//
//  MyViewController.h
//  
//
//  Created by Cao Sang DOAN on 09/12/15.
//
//

#import <UIKit/UIKit.h>
#import "MyTableViewController.h"

@interface MyViewController : UIViewController <UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property(readwrite, nonatomic, retain) UITableViewController *myTableController;

@property(readwrite, nonatomic, retain) UIPickerView *myPicker;


@end
