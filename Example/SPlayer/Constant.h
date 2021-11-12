//
//  Constant.h
//  SPlayer
//
//  Created by 小黄 on 2021/11/12.
//  Copyright © 2021 levine_hhb@163.com. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 255)


#endif /* Constant_h */
