//
//  UkeAlertControllerConstant.h
//  TestModalViewController
//
//  Created by liqian on 2019/6/13.
//  Copyright © 2019 liqian. All rights reserved.
//

#ifndef UkeAlertControllerConstant_h
#define UkeAlertControllerConstant_h

// Color.

 #ifndef UIColorRGBA
 #define UIColorRGBA(r, g, b, a) \
 [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
 
 #define UIColorRGB(r, g, b)     UIColorRGBA(r, g, b, 1.f)
 
 #define UIRandomColor \
 UIColorRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
 #endif
 
 #ifndef UIColorHexA
 #define UIColorHexA(_hex_, a) \
 UIColorRGBA((((_hex_) & 0xFF0000) >> 16), (((_hex_) & 0xFF00) >> 8), ((_hex_) & 0xFF), a)
 
 #define UIColorHex(_hex_)   UIColorHexA(_hex_, 1.0)
 #endif


#endif /* UkeAlertControllerConstant_h */
