//
//  boxviews.h
//  NJDNPAnimationExample
//
//  Created by Nitin Joshi on 01/08/16.
//  Copyright © 2016 Nitin Joshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJDNPAnimation/NJDNPAnimation.h"

@protocol boxViewsDelegate <NSObject>
- (void) callbackWhenAnimationCompletes;
@end

@interface boxviews : UIView <NJDNPAnimationDelegate>

@property (nonatomic, assign) id <boxViewsDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *Box1;
@property (weak, nonatomic) IBOutlet UIView *Box2;

@property NJDNPAnimation *nJDNPAnimation;

- (id) initWithFrame:(CGRect)frame;

@end