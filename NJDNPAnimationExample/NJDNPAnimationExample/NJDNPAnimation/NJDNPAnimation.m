//
//  NJDNPAnimation.h
//  NJDNPAnimationExample
//
//  Created by Nitin Joshi on 01/08/16.
//  Copyright © 2016 Nitin Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJDNPAnimation.h"

@interface NJDNPAnimation ()
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIPushBehavior *pushBehavior;
@property (strong, nonatomic) UICollisionBehavior* collision;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) NSArray *viewArray;

@property CGPoint oldPosition;
@property (nonatomic) CGFloat gravityMagnitude;

@end

@implementation NJDNPAnimation

-(void) StartDragAndPlay:(NSArray *)uiViews MakeItemShakeOnTap:(BOOL) needItemShake {
    
    [self SetDefaults];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:((UIView*)uiViews[0]).superview];

    _bgView = [[UIView alloc] initWithFrame:((UIView*)uiViews[0]).superview.frame];
    _bgView.backgroundColor = [UIColor clearColor];
    [((UIView*)uiViews[0]).superview addSubview:_bgView];

    for (UIView *viewBox in uiViews) {
        [viewBox.superview bringSubviewToFront:viewBox];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleBoxesPan:)];
        [viewBox addGestureRecognizer:pan];
        
        if(needItemShake) {
            UITapGestureRecognizer *tapBoxGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBoxesTap:)];
            [viewBox addGestureRecognizer:tapBoxGesture];
        }
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap)];
    [_bgView addGestureRecognizer:tapGesture];
    
    _viewArray = [uiViews copy];

}

-(void) SetDefaults {
    if(!_gravityMagnitude) _gravityMagnitude = 3.0f;
}

-(void) handleBoxesTap:(UIPanGestureRecognizer *)gesture {
    
    _oldPosition = gesture.view.center;
    
    _attachment = [[UIAttachmentBehavior alloc] initWithItem:gesture.view attachedToAnchor:gesture.view.center];
    _attachment.damping = 0.1;
    _attachment.frequency = 10.0;
    [self.animator addBehavior:_attachment];
    
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[gesture.view]];
    item.friction = 0.2;
    item.elasticity = 10;
    [self.animator addBehavior:item];
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[gesture.view] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(40, 0);
    [self.animator addBehavior:push];
    
    [self performSelector:@selector(killShake:) withObject:gesture afterDelay:0.4f];
}

-(void) killShake:(UIPanGestureRecognizer *)gesture {
    UISnapBehavior *snapBehavior1 = [[UISnapBehavior alloc] initWithItem:gesture.view snapToPoint:_oldPosition];
    [self.animator addBehavior:snapBehavior1];
    
    [_animator removeAllBehaviors];
}

- (void) setGravityMagnitude:(CGFloat) gravity {
    _gravityMagnitude = gravity;
}

- (void) handleBackgroundTap {
    
    [_animator removeAllBehaviors];
    _pushBehavior = nil;
    
    _collision = [[UICollisionBehavior alloc] initWithItems:_viewArray];
    [_collision setCollisionMode:UICollisionBehaviorModeItems];
    [_animator addBehavior:_collision];
    
    for (UIView *viewBox in _viewArray) {
        
        _pushBehavior = [[UIPushBehavior alloc] initWithItems:@[viewBox] mode:UIPushBehaviorModeInstantaneous];
        _pushBehavior.pushDirection = CGVectorMake(0, (-10 - (viewBox.center.y * 0.02)));
        [self.animator addBehavior:_pushBehavior];

        for (UIGestureRecognizer *ss in viewBox.gestureRecognizers) {
            [viewBox removeGestureRecognizer:ss];
        }
    }
    
    for (UIGestureRecognizer *ss in _bgView.gestureRecognizers) {
        [_bgView removeGestureRecognizer:ss];
    }

    UIGravityBehavior *_gravity = [[UIGravityBehavior alloc] initWithItems:_viewArray];
    _gravity.magnitude = _gravityMagnitude;
    [_animator addBehavior:_gravity];
    
    [self performSelector:@selector(DragAndPlayFinished) withObject:nil afterDelay:0.8f];
    
}

- (void) handleBoxesPan:(UIPanGestureRecognizer *) gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self BoxPanGestureStateBegan:gesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self BoxPanGestureStateChanged:gesture];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            [self BoxPanGestureStateEnded:gesture];
            break;
        default:
            break;
    }
}

- (void) BoxPanGestureStateBegan:(UIPanGestureRecognizer *)gesture {
    
    _oldPosition = gesture.view.center;//[gesture locationInView:self.animator.referenceView];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:_viewArray];
    [_collision setCollisionMode:UICollisionBehaviorModeItems];
    [_animator addBehavior:_collision];
    
    for (UIView *viewBox in _viewArray) {
        UISnapBehavior *snapBehavior1 = [[UISnapBehavior alloc] initWithItem:viewBox snapToPoint:viewBox.center];
        [self.animator addBehavior:snapBehavior1];
    }
    
    CGPoint gripPoint = [gesture locationInView:gesture.view];
    UIOffset offsetFromCenter = UIOffsetMake(gripPoint.x - gesture.view.bounds.size.width  / 2.0, gripPoint.y - gesture.view.bounds.size.height / 2.0);
    CGPoint anchorPoint = [gesture locationInView:[gesture.view superview]];
    _attachment = [[UIAttachmentBehavior alloc] initWithItem:gesture.view offsetFromCenter:offsetFromCenter attachedToAnchor:anchorPoint];
    [self.animator addBehavior:_attachment];
}

- (void) BoxPanGestureStateChanged:(UIPanGestureRecognizer *)gesture {
    
    CGPoint touchPoint = [gesture locationInView:_bgView];
    _attachment.anchorPoint = touchPoint;
    
}

- (void) BoxPanGestureStateEnded:(UIPanGestureRecognizer *)gesture {
    
    [_animator removeAllBehaviors];
    _pushBehavior = nil;
    
    _collision = [[UICollisionBehavior alloc] initWithItems:_viewArray];
    [_collision setCollisionMode:UICollisionBehaviorModeItems];
    [_animator addBehavior:_collision];
    
    
    CGPoint touchPoint = [gesture locationInView:[gesture.view superview]];
    CGFloat movedDistance = [self distance:_oldPosition To:touchPoint];
    
    if (movedDistance < 30) {
        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:gesture.view snapToPoint:_oldPosition];
        [self.animator addBehavior:snapBehavior];
    }
    else {
        
        _pushBehavior = [[UIPushBehavior alloc] initWithItems:@[gesture.view] mode:UIPushBehaviorModeInstantaneous];
        CGPoint velocity = [gesture velocityInView:[gesture.view superview]];
        _pushBehavior.pushDirection = CGVectorMake((velocity.x / 100), (velocity.y / 100));
        [self.animator addBehavior:_pushBehavior];
        
        
        for (UIView *viewBox in _viewArray) {
            for (UIGestureRecognizer *ss in viewBox.gestureRecognizers) {
                [viewBox removeGestureRecognizer:ss];
            }
        }
        
        UIGravityBehavior *_gravity = [[UIGravityBehavior alloc] initWithItems:_viewArray];
        _gravity.magnitude = _gravityMagnitude;
        [_animator addBehavior:_gravity];
        
        [self performSelector:@selector(DragAndPlayFinished) withObject:nil afterDelay:0.8f];
    }
}

-(CGFloat) distance:(CGPoint)from To:(CGPoint)to {
    float xDist = (to.x - from.x);
    float yDist = (to.y - from.y);
    return sqrt((xDist * xDist) + (yDist * yDist));
}

-(void) DragAndPlayFinished {
    
    if ([self.delegate respondsToSelector:@selector(DragAndPlayFinished)]) {
        [self.delegate DragAndPlayFinished];
    }

    if(_bgView) {
        [_bgView removeFromSuperview];
        _bgView = NULL;
    }
}

@end

