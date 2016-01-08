//
//  MyView.m
//  
//
//  Created by Cao Sang DOAN on 11/10/15.
//
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

UIToolbar *toolbar;

UIWebView *webView;

UIAlertView *alertEnterUrl;
UIAlertView *alertHomepage;

UIActionSheet *actionHomeChange;

UIBarButtonItem *buttonRefresh;
UIBarButtonItem *buttonFlexibleSpace;
UIBarButtonItem *buttonBack;
UIBarButtonItem *buttonGoToUrl;
UIBarButtonItem *buttonNext;
UIBarButtonItem *buttonChangeHome;

UIActivityIndicatorView *indicator;

NSString *currentHomepage;

- (id)initWithFrame:(CGRect)frame{
    [super initWithFrame:frame];

    [self setBackgroundColor: UIColor.whiteColor];
    
    toolbar = [[UIToolbar alloc] init];
    
    toolbar.barStyle = UIBarStyleDefault;

    buttonRefresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonChange:)];
    
    buttonFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    buttonBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(navigateButton:)];
    
    
    buttonGoToUrl = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goToUrl:)];
    
    
    buttonNext = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(navigateButton:)];
    
    
    buttonChangeHome = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(changeHome:)];
    
    [toolbar setItems:[NSArray arrayWithObjects: buttonRefresh, buttonFlexibleSpace,buttonBack, buttonFlexibleSpace, buttonGoToUrl, buttonFlexibleSpace, buttonNext,buttonFlexibleSpace, buttonChangeHome, nil] animated:true];
    
    /*
     toolbar doit être utiliser framesizeheight/x avec x est un nombre, si on fixe l'hauteur de toolbar, cela empche toolbar enregistrer les touches les événements.
     
     */
    
 //   [toolbar setFrame:CGRectMake(20, 20, frame.size.width - 20*2, frame.size.height/20)];
    
    webView = [[UIWebView alloc] init];
 
    /*
    UIDevice *device = [UIDevice currentDevice];
    
    if ([device userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if([device orientation] == UIDeviceOrientationLandscapeLeft || [device orientation] == UIDeviceOrientationLandscapeRight){
            [toolbar setFrame:CGRectMake(20, 20, frame.size.width - 20*2, frame.size.height/15)];
        }else{
            [toolbar setFrame:CGRectMake(20, 20, frame.size.width - 20*2, frame.size.height/20)];
        }
    }else{
        [toolbar setFrame:CGRectMake(20, 20, frame.size.width - 20*2, frame.size.height/20)];
    }
    
    [webView setFrame:CGRectMake(20, 20 + toolbar.bounds.size.height, frame.size.width - 20*2, frame.size.height - 20 - toolbar.bounds.size.height - 20)];
       */
    [self viewWillTransitionToSize:CGSizeMake(frame.size.width, frame.size.height)];

    NSURL *url = [NSURL URLWithString:@"http://www.upmc.fr"];
    NSURLRequest *r = [NSURLRequest requestWithURL:url];
    [webView loadRequest:r];
    [webView setScalesPageToFit:TRUE];
    
    alertEnterUrl = [[UIAlertView alloc] initWithTitle:@"URL" message:@"Entrez l'URL à charger\nhttp://" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK", nil];
    alertEnterUrl.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertEnterUrl setDelegate:self];
    
    actionHomeChange = [[UIActionSheet alloc] initWithTitle:@"Changez homepage?" delegate:self cancelButtonTitle:@"Non" destructiveButtonTitle:@"Oui" otherButtonTitles: nil];
    [actionHomeChange setDelegate:self];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    [indicator setFrame:CGRectMake(frame.size.width/2, frame.size.height/2, indicator.bounds.size.width, indicator.bounds.size.height)];
    
    [self addSubview:webView];
    [self addSubview:toolbar];
    [self addSubview:indicator];
    
    [indicator release];
    [webView release];
    [toolbar release];
    [buttonRefresh release];
    [buttonBack release];
    [buttonChangeHome release];
    [buttonFlexibleSpace release];
    [buttonGoToUrl release];
    [buttonNext release];
    
    currentHomepage = @"http://www.upmc.fr";

    return self;
}

-(void) dealloc{
    [super dealloc];
    
    
    [webView release];
    [toolbar release];
    [buttonRefresh release];
    [buttonBack release];
    [buttonChangeHome release];
    [buttonFlexibleSpace release];
    [buttonGoToUrl release];
    [buttonNext release];

    [indicator release];
    [currentHomepage release];
}

- (void) viewWillTransitionToSize:(CGSize) size{
    UIDevice *device = [UIDevice currentDevice];
    
    if ([device userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [toolbar setFrame:CGRectMake(20, 20, size.width - 20*2, size.height/15)];
    }else{
        [toolbar setFrame:CGRectMake(20, 20, size.width - 20*2, size.height/20)];
    }
    
    [indicator setFrame:CGRectMake(size.width/2, size.height/2, indicator.bounds.size.width, indicator.bounds.size.height)];

    [webView setFrame:CGRectMake(20, 20 + toolbar.bounds.size.height, size.width - 20*2, size.height - 20 - toolbar.bounds.size.height - 20)];
}

-(void) refreshButtonChange:(UIBarButtonItem*) sender{
 //   NSURL *url = [NSURL URLWithString:@"http://www.upmc.fr"];
    NSURL *url = [NSURL URLWithString:currentHomepage];

    NSURLRequest *r = [NSURLRequest requestWithURL:url];
    [webView loadRequest:r];
    [webView setScalesPageToFit:TRUE];
    [self setNeedsDisplay];

}

-(void) navigateButton:(UIBarButtonItem*) sender{
    if (sender == buttonBack){
        [webView goBack];
    }else{
        [webView goForward];
    }
    
    [self setNeedsDisplay];
}

-(void) goToUrl:(UIBarButtonItem*) sender{
    [alertEnterUrl show];
}

-(void) changeHome:(UIBarButtonItem*) sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [actionHomeChange showFromBarButtonItem:buttonChangeHome animated:TRUE];
    }else{
        [actionHomeChange showFromToolbar:toolbar];
    }
}

-(void) webViewDidStartLoad:(UIWebView *)webView{
    [indicator startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [indicator stopAnimating];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alertErreur = [[UIAlertView alloc] initWithTitle:@"Erreur" message:[NSString stringWithFormat:@"%@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertErreur autorelease];
    [alertErreur show];
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSURL *url;
    if (alertView == alertEnterUrl){
        if (buttonIndex == 1){
            NSString *tmp = [NSString stringWithFormat:@"http://%@", [[alertView textFieldAtIndex:0] text]];
            url = [NSURL URLWithString:tmp];
            NSURLRequest *r = [NSURLRequest requestWithURL:url];
            [webView loadRequest:r];
            [webView setScalesPageToFit:TRUE];
        }
    }else{
        if (buttonIndex == 1){
            NSString *tmp = [NSString stringWithFormat:@"http://%@", [[alertView textFieldAtIndex:0] text]];
            currentHomepage = [tmp copy];
            url = [NSURL URLWithString:currentHomepage];
            NSURLRequest *r = [NSURLRequest requestWithURL:url];
            [webView loadRequest:r];
            [webView setScalesPageToFit:TRUE];
        }
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        alertHomepage = [[UIAlertView alloc] initWithTitle:@"URL" message:@"Entrez l'URL à changer\nhttp://" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK", nil];
        alertHomepage.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertHomepage setDelegate:self];
        
        [alertHomepage show];

    }
}













@end

