//
//  MyViewController.m
//  
//
//  Created by Cao Sang DOAN on 09/12/15.
//
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

NSArray *pickerArray;
int currentRow;

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *v = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [v setBackgroundColor:[UIColor whiteColor]];
        _myPicker = [[UIPickerView alloc] init];
        [_myPicker selectRow:0 inComponent:0 animated:true];
        [_myPicker sizeToFit];
        [_myPicker setDelegate:self];
        [_myPicker setDataSource:self];
        
        pickerArray = [[NSArray alloc] initWithObjects:@"Happy", @"Love", @"Sad", @"Hungry", @"Angry", nil];
        
        [v addSubview:_myPicker];
        
        [self reDraw:[UIScreen mainScreen].bounds.size];
        
        [self setView:v];
        
        UIBarButtonItem *buttonBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneStatus:)];
        self.navigationItem.rightBarButtonItem = buttonBarItem;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    [_myTableController release];
    
    [_myPicker release];
}

-(void) reDraw:(CGSize) size{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    currentRow = row;
}

-(void) doneStatus:(UIBarButtonItem *)sender{
    [_myTableController setStatus:[pickerArray objectAtIndex:currentRow]];
    [_myTableController refresh];
    
    [self.navigationController popToViewController:_myTableController animated:true];
}


@end






