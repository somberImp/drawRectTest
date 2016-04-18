//
//  VWArrowViewController.h
//  ViewTest
//
//  Created by Vivian Wehner on 3/9/16.
//  Copyright © 2016 Vivian Wehner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VWArrowViewController : UIViewController <UIGestureRecognizerDelegate>
@property CGPoint fromPoint;
@property CGPoint toPoint;
- (instancetype)initFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;

@end
