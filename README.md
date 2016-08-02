# NJDNPAnimation

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](https://img.shields.io/badge/language-objective--c-orange.svg?style=flat
)]()
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

This is a drag and play style animation sample for NJDNPAnimation class, like [Swarm](https://swarmapp.com/) app. It's based on [TKSwarmAlert](https://github.com/entotsu/TKSwarmAlert) swift library.

# Screenshot :
![Demo GIF Animation](https://raw.githubusercontent.com/Nitin-Joshi/NJDNPAnimation/master/Screenshot/NJDNPAnimation_Screenshot.gif "Demo GIF Animation")

# Installation

NJDNPAnimation class is really easy to integrate in your project. To integrate this animation into your app, just add 'NJDNPAnimation' folder from the sample to your project hierarchy.

````Objective-C
#import "NJDNPAnimation/NJDNPAnimation.h"
```
import NJDNPAnimation wherever you want to apply the animation. 

# Usages

You don't need any special arrangement to use this library. 

## StartDragAndPlay

Just pass 1 or more views on which you want to apply drag and collision effect to the NJDNPAnimation class using following function and you are good to go. 

````Objective-C
-(void) StartDragAndPlay:(NSArray *)uiViews NeedShakeOnClick:(BOOL) needItemShake;
````

## Delegate

you can use following delegate call to know when animation finishes

````Objective-C
- (void) DragAndPlayFinished;
```

# Future Releases

Will add more feature in future, like background for the animated views and more control through delegate. You can suggest anny feature you would like or better fork, add features.
