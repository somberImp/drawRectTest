//
//  VWArrow.h
//  ViewTest
//
//  Created by Vivian Wehner on 3/8/16.
//  Copyright © 2016 Vivian Wehner. All rights reserved.
//

#import <UIKit/UIKit.h>
@import QuartzCore;

@interface VWLayerArrowDelegate : UIViewController
- (instancetype)initFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;

@property CGPoint fromPoint;
@property CGPoint toPoint;
@end

@interface VWArrow : UIView

@property CGPoint fromPoint;
@property CGPoint toPoint;

- (instancetype)initFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;
//- (UIView *)imageView;
//- (UIView *)imageWithImage;

@end
