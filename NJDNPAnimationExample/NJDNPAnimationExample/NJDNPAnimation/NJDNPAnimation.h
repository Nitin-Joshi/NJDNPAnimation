//
//  NJDNPAnimation.h
//  NJDNPAnimationExample
//
//  Created by Nitin Joshi on 01/08/16.
//  Copyright © 2016 Nitin Joshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NJDNPAnimationDelegate <NSObject>

- (void) DragAndPlayFinished;

@end

@interface NJDNPAnimation : NSObject

@property (nonatomic, assign) id <NJDNPAnimationDelegate> delegate;

-(void) StartDragAndPlay:(NSArray *) uiViews MakeItemShakeOnTap:(BOOL) needItemShake;

-(void) setGravityMagnitude :(CGFloat)gravity;
@end