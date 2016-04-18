//
//  ViewController.m
//  ViewTest
//
//  Created by Vivian Wehner on 3/8/16.
//  Copyright © 2016 Vivian Wehner. All rights reserved.
//

#import "ViewController.h"
#import "VWArrow.h"
#import "VWArrowViewController.h"

@import GameplayKit;
@import QuartzCore;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    [self setupScrollView];
    
    [self setupArrows];
}

- (void)setupArrows
{
    // Do any additional setup after loading the view, typically from a nib.
    int numberConnections = 300;
    
    for (int i = 0; i < numberConnections; i++) {
        CGFloat xFrom =[[GKRandomSource sharedRandom] nextIntWithUpperBound:8192];
        CGFloat yFrom =[[GKRandomSource sharedRandom] nextIntWithUpperBound:8192];
        CGFloat xTo =[[GKRandomSource sharedRandom] nextIntWithUpperBound:8192];
        CGFloat yTo =[[GKRandomSource sharedRandom] nextIntWithUpperBound:8192];
        CGPoint fromPoint = CGPointMake(xFrom, yFrom);
        CGPoint toPoint = CGPointMake(xTo, yTo);
        
        // What we currently do
//        VWArrow *arrow = [[VWArrow alloc]initFrom:fromPoint toPoint:toPoint];
//        [self.graphView addSubview:arrow];
        
//        VWArrowViewController *controller = [[VWArrowViewController alloc]initFrom:fromPoint toPoint:toPoint];
//        [self.graphView addSubview:controller.view];
        
       VWArrow *indicatorView = [[VWArrow alloc] initFrom:fromPoint toPoint:toPoint];
        indicatorView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        indicatorView.frame = [self rectForNodePointsFrom:fromPoint toPoint:toPoint];
        [self.graphView addSubview:indicatorView];
    }
}

- (CGRect)rectForNodePointsFrom:(CGPoint )fromPoint toPoint:(CGPoint )toPoint
{
    CGPoint p1 = fromPoint;
    CGPoint p2 = toPoint;
    
    
    CGRect r = CGRectMake(MIN(p1.x, p2.x),
                          MIN(p1.y, p2.y),
                          fabs(p1.x - p2.x),
                          fabs(p1.y - p2.y));
    
    CGFloat extraConnectionSpace = 1;//MAX(self.graphView.gridSpacing.floatValue, 5);
    
    // Only expand the rect near straight lines to allow for the selection image to appear.
    CGFloat centerX = r.origin.x + (r.size.width / 2);
    CGFloat centerY = r.origin.y + (r.size.height / 2);
    CGFloat padX = (centerX + extraConnectionSpace) - (r.origin.x + r.size.width);
    CGFloat padY = (centerY + extraConnectionSpace) - (r.origin.y + r.size.height);
    
    if (padX > 0) {
        r.origin.x -= padX;
        r.size.width += (padX * 2);
    }
    if (padY > 0) {
        r.origin.y -= padY;
        r.size.height += (padY * 2);
    }
    
    return r;
}

- (void)setupScrollView
{
    // Set up the container view to hold the graph view size
    CGSize containerSize = self.graphView.frame.size;
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = containerSize;
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll View Support

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.graphView;
}


@end
