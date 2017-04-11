//
//  Dyzb_define.h
//  Dyzb_UT
//
//  Created by liutao on 17/4/11.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#ifndef Dyzb_define_h
#define Dyzb_define_h


/*
 控制台输出日志
 */
#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...)
#endif

// 根据屏幕大小修正固定值 (Flexible Numerical)
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kSUBSCREEN_W(width) (((width)/375.0) * SCREEN_WIDTH)
#define kSUBSCREEN_H(height) (((height)/667.0) * SCREEN_HEIGHT)

#define kW(width) (kSUBSCREEN_W(width))
#define kH(height) (kSUBSCREEN_H(height))

/**
 *  生成随机色
 */
#define RANDOM_COLOR RGB(arc4random_uniform(256.0),arc4random_uniform(256.0),arc4random_uniform(256.0))

/////////////////////////////////////////////////
// 懒加载
#define DY_LAZY(object, assignment) (object = object ?: assignment)
#endif /* Dyzb_define_h */
