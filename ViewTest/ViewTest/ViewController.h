//
//  ViewController.h
//  ViewTest
//
//  Created by Vivian Wehner on 3/8/16.
//  Copyright © 2016 Vivian Wehner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *graphView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

