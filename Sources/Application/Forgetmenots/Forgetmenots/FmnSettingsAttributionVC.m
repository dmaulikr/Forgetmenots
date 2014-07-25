//
//  FmnSettingsAttributionVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 04.07.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnSettingsAttributionVC.h"

@interface FmnSettingsAttributionVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation FmnSettingsAttributionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.webview setBackgroundColor:[UIColor clearColor]];
    [self.webview setOpaque:NO];
    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @"file:///Users/ilya/Projects/gh-pages/Forgetmenots/attribution.html"] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 5000];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"attribution" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL:nil];
    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://forgetmenots.co/attribution.html"] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 5000];
//    [self.webview loadRequest: request];
}

- (void)viewDidLayoutSubviews {
    self.webview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
