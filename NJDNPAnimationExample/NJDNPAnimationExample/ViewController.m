//
//  ViewController.m
//  NJDNPAnimationExample
//
//  Created by Nitin Joshi on 01/08/16.
//  Copyright © 2016 Nitin Joshi. All rights reserved.
//

#import "ViewController.h"
#import "boxviews.h"

@interface ViewController () <boxViewsDelegate>
@property (weak, nonatomic) boxviews *boxView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)OpenAnimatedView:(id)sender {
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"boxviews" owner:self options:nil];
    _boxView = [subviewArray objectAtIndex:0];
    [_boxView setBounds:self.view.bounds];
    [_boxView setFrame:self.view.frame];
    [_boxView initWithFrame:self.view.frame];
    [self.view addSubview:_boxView];
    [_boxView setDelegate:self];
}

- (void) callbackWhenAnimationCompletes{
    [self removeAnimatedView];
}

-(void) removeAnimatedView {
    if(_boxView) {
        [_boxView removeFromSuperview];
        _boxView = NULL;
    }
    
}

@end
