//
//  MyView.m
//  NuancierRVBGeek_OC
//
//  Created by Cao Sang DOAN on 03/10/15.
//  Copyright © 2015 Cao Sang DOAN. All rights reserved.
//

#import "MyView.h"

@implementation MyView

UIDevice *device;

UILabel *previous;
UILabel *penultimate;

UIButton *previousButton;
UIButton *penultimateButton;

UILabel *actualLabel;
UIView *actualView;

UILabel *rLabel;
UILabel *vLabel;
UILabel *bLabel;

UISlider *rSlider;
UISlider *vSlider;
UISlider *bSlider;

UIButton *save;
UIButton *reset;

UILabel *web;
UISwitch *webSwitch;

NSMutableArray *colorSaved;
int place;

- (id)initWithFrame:(CGRect)frame
{
    [super initWithFrame:frame];
 
    colorSaved = [[NSMutableArray alloc] initWithObjects:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], nil];
    
    place = 0;
    
    previous = [[UILabel alloc] init];
    [previous setText:@"Précédent"];
    [previous setTextAlignment:NSTextAlignmentCenter];
    
    penultimate = [[UILabel alloc] init];
    [penultimate setText:@"Pénultième"];
    [penultimate setTextAlignment:NSTextAlignmentCenter];
    
    previousButton = [[UIButton alloc] init];
    [previousButton setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    [previousButton addTarget:self action:@selector(changeValuePreviousButton:) forControlEvents:UIControlEventTouchDown];
    
    penultimateButton = [[UIButton alloc] init];
    [penultimateButton setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    [penultimateButton addTarget:self action:@selector(changeValuePenultimateButton:) forControlEvents:UIControlEventTouchDown];
    
    actualLabel = [[UILabel alloc] init];
    [actualLabel setText:@"Actuel"];
    [actualLabel setTextAlignment:NSTextAlignmentCenter];
    
    actualView = [[UIView alloc] init];
    [actualView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    
    rLabel = [[UILabel alloc] init];
    [rLabel setText:@"R: 50%"];
    [rLabel sizeToFit];
    
    vLabel = [[UILabel alloc] init];
    [vLabel setText:@"V: 50%"];
    [vLabel sizeToFit];
    
    bLabel = [[UILabel alloc] init];
    [bLabel setText:@"B: 50%"];
    [bLabel sizeToFit];
    
    rSlider = [[UISlider alloc] init];
    rSlider.maximumValue = 1;
    rSlider.minimumValue = 0;
    rSlider.value = 0.5;
    [rSlider addTarget:self action:@selector(changeValueSlider:) forControlEvents:UIControlEventAllEvents];

    
    vSlider = [[UISlider alloc] init];
    vSlider.maximumValue = 1;
    vSlider.minimumValue = 0;
    vSlider.value = 0.5;
    [vSlider addTarget:self action:@selector(changeValueSlider:) forControlEvents:UIControlEventAllEvents];


    bSlider = [[UISlider alloc] init];
    bSlider.maximumValue = 1;
    bSlider.minimumValue = 0;
    bSlider.value = 0.5;
    [bSlider addTarget:self action:@selector(changeValueSlider:) forControlEvents:UIControlEventAllEvents];

    
    save = [UIButton buttonWithType:UIButtonTypeSystem];
    [save setTitle:@"Enregistrer" forState:UIControlStateNormal];
    [save sizeToFit];
    [save addTarget:self action:@selector(changeValueSaveButton:) forControlEvents:UIControlEventTouchDown];

    
    reset = [UIButton buttonWithType:UIButtonTypeSystem];
    [reset setTitle:@"Reset" forState:UIControlStateNormal];
    [reset sizeToFit];
    [reset addTarget:self action:@selector(changeValueResetButton:) forControlEvents:UIControlEventTouchDown];

    
    web = [[UILabel alloc] init];
    web.text = @"Web uniquement";
    [web setFont:[UIFont systemFontOfSize:12]];
    [web sizeToFit];
    
    webSwitch = [[UISwitch alloc] init];
    [webSwitch setOn:NO];
    [webSwitch addTarget:self action:@selector(changeValueWebSwitch:) forControlEvents:UIControlEventAllTouchEvents];

    
    device = [UIDevice currentDevice];
    
    [self addSubview:previousButton];
    [previousButton release];
    [self addSubview:penultimateButton];
    [penultimateButton release];
    [self addSubview:previous];
    [previous release];
    [self addSubview:penultimate];
    [penultimate release];
    [self addSubview:actualLabel];
    [actualLabel release];
    [self addSubview:actualView];
    [actualView release];
    [self addSubview:rLabel];
    [rLabel release];
    [self addSubview:vLabel];
    [vLabel release];
    [self addSubview:bLabel];
    [bLabel release];
    [self addSubview:rSlider];
    [rSlider release];
    [self addSubview:vSlider];
    [vSlider release];
    [self addSubview:bSlider];
    [bSlider release];
    [self addSubview:save];
    [save release];
    [self addSubview:reset];
    [reset release];
    [self addSubview:web];
    [web release];
    [self addSubview:webSwitch];
    [webSwitch release];
    
    
    
    return self;
}

- (void) dealloc
{
    [super dealloc];
    
    [device release];
    
    [previous release];
    [penultimate release];
   
    [previousButton release];
    [penultimateButton release];
    
    [actualLabel release];
    [actualView release];
    
    [rLabel release];
    [vLabel release];
    [bLabel release];
    
    [rSlider release];
    [vSlider release];
    [bSlider release];
    
    [save release];
    [reset release];
    
    [web release];
    [webSwitch release];
    
    [colorSaved release];
}

- (void) changeValuePreviousButton:(UIButton *) sender
{
    CGFloat r, v, b;
    UIColor *saved = colorSaved[(place + 1)%2];
    
    [saved getRed:&r green:&v blue:&b alpha:nil];
    
    rSlider.value = r;
    vSlider.value = v;
    bSlider.value = b;
    
    [self updateDisplay];
}

- (void) changeValuePenultimateButton:(UIButton *) sender
{
    CGFloat r, v, b;
    UIColor *saved = colorSaved[place];
    
    [saved getRed:&r green:&v blue:&b alpha:nil];
    
    rSlider.value = r;
    vSlider.value = v;
    bSlider.value = b;
    
    [self updateDisplay];
}

- (void) changeValueSlider:(UISlider *) sender
{
    [self updateDisplay];
}

- (void) changeValueSaveButton:(UISlider *) sender
{
    UIColor *saved;
    
    if (webSwitch.on)
    {
        saved = [UIColor colorWithRed:((int)(rSlider.value*10) * 10)/100. green:((int)(vSlider.value*10) * 10)/100. blue:((int)(bSlider.value*10) * 10)/100. alpha:1];
    }
    else
    {
        saved = [UIColor colorWithRed:rSlider.value green:vSlider.value blue:bSlider.value alpha:1];
    }
    
    [colorSaved removeObjectAtIndex:place];
    [colorSaved insertObject:saved atIndex:place];
    [previousButton setBackgroundColor:saved];
    
    place = (place + 1)%2;
    saved = colorSaved[place];
    
    [penultimateButton setBackgroundColor:saved];
    
}


- (void) viewWillTransitionToSize:(CGSize) size
{
    device = [UIDevice currentDevice];
    CGFloat frameWidth = size.width;
    CGFloat frameHeight = size.height;
    
    if ([device userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [save setFrame:CGRectMake(20, frameHeight - 10 - save.bounds.size.height, save.bounds.size.width, save.bounds.size.height)];
        
        [reset setFrame:CGRectMake((frameWidth - reset.bounds.size.width) / 2, frameHeight - 10 - reset.bounds.size.height, reset.bounds.size.width , reset.bounds.size.height)];
        
        [webSwitch setFrame:CGRectMake(frameWidth - webSwitch.bounds.size.width - 20, frameHeight - 20 - webSwitch.bounds.size.height, webSwitch.bounds.size.width, webSwitch.bounds.size.height)];
        
        CGFloat x, y, width, height;
        
        x = frameWidth - web.bounds.size.width - 20;
        y = frameHeight - web.bounds.size.height - 5;
        width = web.bounds.size.width;
        height = web.bounds.size.height;
        
        [web setFrame:CGRectMake(x, y, width, height)];
        
        
        y = frameHeight - 20 - reset.bounds.size.height - bSlider.bounds.size.height;
        width = frameWidth - 40;
        height = bSlider.bounds.size.height;
        
        [bSlider setFrame:CGRectMake(20, y, width, height)];
        
        y = frameHeight - 30 - reset.bounds.size.height - vSlider.bounds.size.height - bSlider.bounds.size.height;
        width = frameWidth - 40;
        height = vSlider.bounds.size.height;
        
        [vSlider setFrame:CGRectMake(20, y, width, height)];
        
        y = frameHeight - 40 - reset.bounds.size.height - vSlider.bounds.size.height - bSlider.bounds.size.height - rSlider.bounds.size.height;
        width = frameWidth - 40;
        height = rSlider.bounds.size.height;
        
        [rSlider setFrame:CGRectMake(20, y, width, height)];
        
        
        [bLabel setFont:[UIFont systemFontOfSize:13]];
        [bLabel sizeToFit];
        y = frameHeight - 35 - reset.bounds.size.height - bSlider.bounds.size.height;
        width = bLabel.bounds.size.width;
        height = bLabel.bounds.size.height;
        
        [bLabel setFrame:CGRectMake(20, y, width, height)];
        
        
        [vLabel setFont:[UIFont systemFontOfSize:13]];
        [vLabel sizeToFit];
        y = frameHeight - 45 - reset.bounds.size.height - bSlider.bounds.size.height - vSlider.bounds.size.height;
        width = vLabel.bounds.size.width;
        height = vLabel.bounds.size.height;
        
        [vLabel setFrame:CGRectMake(20, y, width, height)];
        
        [rLabel setFont:[UIFont systemFontOfSize:13]];
        [rLabel sizeToFit];
        y = frameHeight - 55 - reset.bounds.size.height - bSlider.bounds.size.height - vSlider.bounds.size.height - rSlider.bounds.size.height;
        width = rLabel.bounds.size.width;
        height = rLabel.bounds.size.height;
        
        [rLabel setFrame:CGRectMake(20, y, width, height)];
        
        
        if ([device orientation] == UIDeviceOrientationPortrait || [device orientation] == UIDeviceOrientationPortraitUpsideDown)
        {
            [previousButton setFrame:CGRectMake(20, 20, frameWidth/2.5, frameHeight/15)];
            [penultimateButton setFrame:CGRectMake(20, 20 + 10 + previousButton.bounds.size.height, previousButton.bounds.size.width, previousButton.bounds.size.height)];
            
            [previous sizeToFit];
            [previous setFont:[UIFont systemFontOfSize:15]];
            [previous setFrame:CGRectMake(frameWidth - 20 - previous.bounds.size.width, previousButton.bounds.size.height/2 + 20 - previous.bounds.size.height/2, previous.bounds.size.width, previous.bounds.size.height)];
            
            [penultimate sizeToFit];
            [penultimate setFont:[UIFont systemFontOfSize:15]];
            [penultimate setFrame:CGRectMake(frameWidth - 20 - penultimate.bounds.size.width, previousButton.bounds.size.height + penultimateButton.bounds.size.height/2 + 20 + 10 - penultimate.bounds.size.height/2, penultimate.bounds.size.width, penultimate.bounds.size.height)];
            
            [actualLabel sizeToFit];
            [actualLabel setFont:[UIFont systemFontOfSize:15]];
            [actualLabel setFrame:CGRectMake((frameWidth - actualLabel.bounds.size.width)/2, previousButton.bounds.size.height + penultimateButton.bounds.size.height + 20 + 20, actualLabel.bounds.size.width, actualLabel.bounds.size.height)];
            
            [actualView sizeToFit];
            [actualView setFrame:CGRectMake(20, previousButton.bounds.size.height + penultimateButton.bounds.size.height + 20 + 20 + actualLabel.bounds.size.height + 10, frameWidth - 40, frameHeight - 10 - reset.bounds.size.height - 3*rSlider.bounds.size.height- 30*3 - previousButton.bounds.size.height*2 - actualLabel.bounds.size.height - 20)];
        }
        else
        {
            [previousButton setFrame:CGRectMake(20, 20, frameWidth/5, frameWidth/13)];
            [penultimateButton setFrame:CGRectMake(20 + previousButton.bounds.size.width + 10, 20, previousButton.bounds.size.width, previousButton.bounds.size.height)];
            
            [previous sizeToFit];
            [previous setFont:[UIFont systemFontOfSize:15]];
            [previous setFrame:CGRectMake((previousButton.bounds.size.width)/2 + 20 - previous.bounds.size.width/2, previousButton.bounds.size.height + 20 + 10, previous.bounds.size.width, previous.bounds.size.height)];
            
            [penultimate sizeToFit];
            [penultimate setFont:[UIFont systemFontOfSize:15]];
            [penultimate setFrame:CGRectMake(previousButton.bounds.size.width + 10 + (penultimateButton.bounds.size.width)/2 + 20 - penultimate.bounds.size.width/2,penultimateButton.bounds.size.height + 20 + 10, penultimate.bounds.size.width, penultimate.bounds.size.height)];
            
            [actualView sizeToFit];
            [actualView setFrame:CGRectMake(20 + previousButton.bounds.size.width*2 + 10 + 10, 20, frameWidth - 40 - previousButton.bounds.size.width*2 - 10*2, previousButton.bounds.size.height)];
            
            [actualLabel sizeToFit];
            [actualLabel setFont:[UIFont systemFontOfSize:15]];
            [actualLabel setFrame:CGRectMake(20 + 10*2 + previousButton.bounds.size.width*2 + actualView.bounds.size.width/2 - actualLabel.bounds.size.width/2, previousButton.bounds.size.height + 20 + 10, actualLabel.bounds.size.width, actualLabel.bounds.size.height)];
        }
    }
    else
    {
        if (frameWidth < frameHeight && frameWidth < 500)
        {
            [save.titleLabel setFont:[UIFont systemFontOfSize:20]];
            [save sizeToFit];
            [save setFrame:CGRectMake(20, frameHeight - 10 - save.bounds.size.height, save.bounds.size.width, save.bounds.size.height)];
            
            [reset.titleLabel setFont:[UIFont systemFontOfSize:20]];
            [reset sizeToFit];
            [reset setFrame:CGRectMake((frameWidth - reset.bounds.size.width) / 2, frameHeight - 10 - reset.bounds.size.height, reset.bounds.size.width , reset.bounds.size.height)];
            
            [webSwitch setFrame:CGRectMake(frameWidth - webSwitch.bounds.size.width - 20, frameHeight - 20 - webSwitch.bounds.size.height, webSwitch.bounds.size.width, webSwitch.bounds.size.height)];
            
            CGFloat x, y, width, height;
            
            x = frameWidth - web.bounds.size.width - 20;
            y = frameHeight - web.bounds.size.height - 5;
            width = web.bounds.size.width;
            height = web.bounds.size.height;
            
            [web setFrame:CGRectMake(x, y, width, height)];
            
            
            y = frameHeight - 40 - reset.bounds.size.height - bSlider.bounds.size.height;
            width = frameWidth - 40;
            height = bSlider.bounds.size.height;
            
            [bSlider setFrame:CGRectMake(20, y, width, height)];
            
            y = frameHeight - 60 - reset.bounds.size.height - vSlider.bounds.size.height - bSlider.bounds.size.height;
            width = frameWidth - 40;
            height = vSlider.bounds.size.height;
            
            [vSlider setFrame:CGRectMake(20, y, width, height)];
            
            y = frameHeight - 80 - reset.bounds.size.height - vSlider.bounds.size.height - bSlider.bounds.size.height - rSlider.bounds.size.height;
            width = frameWidth - 40;
            height = rSlider.bounds.size.height;
            
            [rSlider setFrame:CGRectMake(20, y, width, height)];
            
            
            [bLabel setFont:[UIFont systemFontOfSize:20]];
            [bLabel sizeToFit];
            y = frameHeight - reset.bounds.size.height - bSlider.bounds.size.height - 30*2;
            width = bLabel.bounds.size.width;
            height = bLabel.bounds.size.height;
            
            [bLabel setFrame:CGRectMake(20, y, width, height)];
            
            
            [vLabel setFont:[UIFont systemFontOfSize:20]];
            [vLabel sizeToFit];
            y = frameHeight - reset.bounds.size.height - bSlider.bounds.size.height - vSlider.bounds.size.height - 40*2;
            width = vLabel.bounds.size.width;
            height = vLabel.bounds.size.height;
            
            [vLabel setFrame:CGRectMake(20, y, width, height)];
            
            [rLabel setFont:[UIFont systemFontOfSize:20]];
            [rLabel sizeToFit];
            y = frameHeight - reset.bounds.size.height - bSlider.bounds.size.height - vSlider.bounds.size.height - rSlider.bounds.size.height - 50*2;
            width = rLabel.bounds.size.width;
            height = rLabel.bounds.size.height;
            
            [rLabel setFrame:CGRectMake(20, y, width, height)];
            
            [previousButton setFrame:CGRectMake(20, 20, frameWidth/2.5, frameHeight/15)];
            [penultimateButton setFrame:CGRectMake(20, 20 + previousButton.bounds.size.height + 10, previousButton.bounds.size.width, previousButton.bounds.size.height)];
            
            [previous setFont:[UIFont systemFontOfSize:20]];
            [previous sizeToFit];
            [previous setFrame:CGRectMake(frameWidth - 20 - previous.bounds.size.width, 20 + previousButton.bounds.size.height / 2 - 10, previous.bounds.size.width, previous.bounds.size.height)];
            
            [penultimate setFont:[UIFont systemFontOfSize:20]];
            [penultimate sizeToFit];
            [penultimate setFrame:CGRectMake(frameWidth - 20 - penultimate.bounds.size.width, 20 + previousButton.bounds.size.height + 10 + penultimateButton.bounds.size.height/2 - 10, penultimate.bounds.size.width, penultimate.bounds.size.height)];
            
            [actualLabel setFont:[UIFont systemFontOfSize:20]];
            [actualLabel sizeToFit];
            [actualLabel setFrame:CGRectMake((frameWidth - actualLabel.bounds.size.width)/2, previousButton.bounds.size.height*2 + 20 + 30, actualLabel.bounds.size.width, actualLabel.bounds.size.height)];
            
            [actualView sizeToFit];
            [actualView setFrame:CGRectMake(20, previousButton.bounds.size.height*2 + 20 + 30 + actualLabel.bounds.size.height + 30, frameWidth - 40, frameHeight - reset.bounds.size.height - 3*rSlider.bounds.size.height- 60*3 - previousButton.bounds.size.height*2 - actualLabel.bounds.size.height - 20)];
        }
        else
        {
            [save.titleLabel setFont:[UIFont systemFontOfSize:20]];
            [save sizeToFit];
            [save setFrame:CGRectMake(20, frameHeight - save.bounds.size.height*2, save.bounds.size.width, save.bounds.size.height)];
            
            [reset.titleLabel setFont:[UIFont systemFontOfSize:20]];
            [reset sizeToFit];
            [reset setFrame:CGRectMake((frameWidth - reset.bounds.size.width) / 2, frameHeight - reset.bounds.size.height*2, reset.bounds.size.width , reset.bounds.size.height)];
            
            [webSwitch setFrame:CGRectMake(frameWidth - webSwitch.bounds.size.width - 20, frameHeight - 50 - webSwitch.bounds.size.height, webSwitch.bounds.size.width, webSwitch.bounds.size.height)];
            
            CGFloat x, y, width, height;
            
            [web setFont:[UIFont systemFontOfSize:15]];
            [web sizeToFit];
            
            x = frameWidth - web.bounds.size.width - 20;
            y = frameHeight - web.bounds.size.height - 20;
            width = web.bounds.size.width;
            height = web.bounds.size.height;
            
            [web setFrame:CGRectMake(x, y, width, height)];
            
            
            y = frameHeight - reset.bounds.size.height*3 - bSlider.bounds.size.height;
            width = frameWidth - 40;
            height = bSlider.bounds.size.height;
            
            [bSlider setFrame:CGRectMake(20, y, width, height)];
            
            y = frameHeight - 30*2 - reset.bounds.size.height*3 - vSlider.bounds.size.height - bSlider.bounds.size.height;
            width = frameWidth - 40;
            height = vSlider.bounds.size.height;
            
            [vSlider setFrame:CGRectMake(20, y, width, height)];
            
            y = frameHeight - 40*3 - reset.bounds.size.height*3 - vSlider.bounds.size.height - bSlider.bounds.size.height - rSlider.bounds.size.height;
            width = frameWidth - 40;
            height = rSlider.bounds.size.height;
            
            [rSlider setFrame:CGRectMake(20, y, width, height)];
            
            
            [bLabel setFont:[UIFont systemFontOfSize:20]];
            [bLabel sizeToFit];
            y = frameHeight - 35 - reset.bounds.size.height*3 - bSlider.bounds.size.height;
            width = bLabel.bounds.size.width;
            height = bLabel.bounds.size.height;
            
            [bLabel setFrame:CGRectMake(20, y, width, height)];
            
            
            [vLabel setFont:[UIFont systemFontOfSize:20]];
            [vLabel sizeToFit];
            y = frameHeight - 45*2 - reset.bounds.size.height*3 - bSlider.bounds.size.height - vSlider.bounds.size.height;
            width = vLabel.bounds.size.width;
            height = vLabel.bounds.size.height;
            
            [vLabel setFrame:CGRectMake(20, y, width, height)];
            
            [rLabel setFont:[UIFont systemFontOfSize:20]];
            [rLabel sizeToFit];
            y = frameHeight - 55*3 - reset.bounds.size.height*3 - bSlider.bounds.size.height - vSlider.bounds.size.height - rSlider.bounds.size.height;
            width = rLabel.bounds.size.width;
            height = rLabel.bounds.size.height;
            
            [rLabel setFrame:CGRectMake(20, y, width, height)];
            
            
            [previousButton setFrame:CGRectMake(20, 20, frameWidth/2.5, frameHeight/15)];
            [penultimateButton setFrame:CGRectMake(frameWidth - 20 - previousButton.bounds.size.width, 20, previousButton.bounds.size.width, previousButton.bounds.size.height)];
            
            [previous setFont:[UIFont systemFontOfSize:20]];
            [previous sizeToFit];
            [previous setFrame:CGRectMake((previousButton.bounds.size.width)/2 + 20 - previous.bounds.size.width/2, previousButton.bounds.size.height + 20 + 10, previous.bounds.size.width, previous.bounds.size.height)];
            
            [penultimate setFont:[UIFont systemFontOfSize:20]];
            [penultimate sizeToFit];
            [penultimate setFrame:CGRectMake(frameWidth - 20 - penultimateButton.bounds.size.width + penultimateButton.bounds.size.width/2 - penultimate.bounds.size.width/2,penultimateButton.bounds.size.height + 20 + 10, penultimate.bounds.size.width, penultimate.bounds.size.height)];
            
            
            [actualLabel setFont:[UIFont systemFontOfSize:20]];
            [actualLabel sizeToFit];
            [actualLabel setFrame:CGRectMake((frameWidth - actualLabel.bounds.size.width)/2, previousButton.bounds.size.height + penultimate.bounds.size.height + 20 + 20, actualLabel.bounds.size.width, actualLabel.bounds.size.height)];
            
            [actualView sizeToFit];
            [actualView setFrame:CGRectMake(20, previousButton.bounds.size.height + penultimate.bounds.size.height + 20 + 20 + actualLabel.bounds.size.height + 10, frameWidth - 40, frameHeight - 10 - reset.bounds.size.height*3 - 3*rSlider.bounds.size.height- 80*3 - previousButton.bounds.size.height - actualLabel.bounds.size.height - 20)];
        }
        
    }

}


- (void) changeValueResetButton:(UISlider *) sender
{
    rSlider.value = 0.5;
    vSlider.value = 0.5;
    bSlider.value = 0.5;
    
    [self updateDisplay];
}

- (void) changeValueWebSwitch:(UISlider *) sender
{
    [self updateDisplay];
}

- (void) updateDisplay
{
    CGFloat r, v, b;

    if (webSwitch.on)
    {
        r = (int)(rSlider.value*10) * 10;
        v = (int)(vSlider.value*10) * 10;
        b = (int)(bSlider.value*10) * 10;
        
        rSlider.value = r/100.;
        vSlider.value = v/100.;
        bSlider.value = b/100.;

        [actualView setBackgroundColor:[UIColor colorWithRed:r/100. green:v/100. blue:b/100. alpha:1]];
    }
    else
    {
        r = rSlider.value*100;
        v = vSlider.value*100;
        b = bSlider.value*100;
    
        [actualView setBackgroundColor:[UIColor colorWithRed:r/100. green:v/100. blue:b/100. alpha:1]];
    }
    
    rLabel.text = [NSString stringWithFormat:@"R: %d%% ", (int) r];
    [rLabel sizeToFit];
    
    vLabel.text = [NSString stringWithFormat:@"V: %d%% ", (int) v];
    [vLabel sizeToFit];

    bLabel.text = [NSString stringWithFormat:@"B: %d%% ", (int) b];
    [bLabel sizeToFit];

}


@end















