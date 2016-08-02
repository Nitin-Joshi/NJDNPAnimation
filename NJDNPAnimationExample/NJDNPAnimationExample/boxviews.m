//
//  boxviews.m
//  NJDNPAnimationExample
//
//  Created by Nitin Joshi on 01/08/16.
//  Copyright © 2016 Nitin Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "boxviews.h"

@implementation boxviews

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        [self BringBoxToViewFromTop];
    }
    return self;
}

- (void) BringBoxToViewFromTop {
    
    float box1Pos = _Box1.center.y;
    _Box1.center = CGPointMake(_Box1.center.x, -_Box1.frame.size.height); // move to starting position
    [_Box1.layer setCornerRadius:7];
    _Box1.layer.borderWidth = 3;
    _Box1.hidden = NO;
    
    [UIView animateWithDuration:0.155f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                         //bring top award view halfway
                         _Box1.center = CGPointMake(_Box1.center.x , box1Pos);
                     }
                     completion:nil];
    
    //bottom location view animtion
    float box2Pos = _Box2.center.y;
    _Box2.center = CGPointMake(_Box2.center.x, -_Box2.frame.size.height); // move to starting position
    [_Box2.layer setCornerRadius:7];
    _Box2.layer.borderWidth = 3;
    _Box2.hidden = NO;
    
    [UIView animateWithDuration:0.155f
                          delay:0.2
                        options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                         //bring bottom location view halfway
                         _Box2.center = CGPointMake(_Box2.center.x , box2Pos);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             BOOL itemWillShakeOnTap = YES;
                             
                             _nJDNPAnimation = NULL;
                             _nJDNPAnimation = [[NJDNPAnimation alloc] init];
                             [_nJDNPAnimation StartDragAndPlay:@[_Box1, _Box2] MakeItemShakeOnTap:itemWillShakeOnTap];
                             [_nJDNPAnimation setGravityMagnitude: 5.0f];
                             [_nJDNPAnimation setDelegate: self];
                         }
                     }];
}

-(void) DragAndPlayFinished {
    if ([self.delegate respondsToSelector:@selector(callbackWhenAnimationCompletes)]) {
        [self.delegate callbackWhenAnimationCompletes];
    }
}

@end