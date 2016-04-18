//
//  VWArrow.m
//  ViewTest
//
//  Created by Vivian Wehner on 3/8/16.
//  Copyright © 2016 Vivian Wehner. All rights reserved.
//

#import "VWArrow.h"

@interface VWLayerArrowDelegate ()
@end

// Not used, trying this out maybe
@implementation VWLayerArrowDelegate

- (instancetype)initFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint{
    self = [super init];
    if (self != nil) {
        self.fromPoint = fromPoint;
        self.toPoint = toPoint;
    }
    return self;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextRef context = ctx;
    UIColor *lineColor = [[UIColor redColor] colorWithAlphaComponent:1];
    CGContextSetLineDash(context, 0.0, NULL, 0);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextSetLineWidth(context, 2);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.fromPoint.x, self.fromPoint.y);
    CGContextAddLineToPoint(context, self.toPoint.x, self.toPoint.y);
    CGContextStrokePath(context);
}

@end

@interface VWArrow()
{
    CAShapeLayer *_line;
    UITapGestureRecognizer *_tapGestureRecognizer;
    BOOL _hasInitialized;
}
@end

@implementation VWArrow

- (instancetype)initFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint
{
    self = [super init];
    if (self) {
        self.fromPoint = fromPoint;
        self.toPoint = toPoint;
        self.frame = [self rectForNodePoints];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (!_hasInitialized && !CGRectEqualToRect(frame, CGRectZero))
        [self initializeControl];
    else if (_hasInitialized && !CGRectEqualToRect(frame, CGRectZero))
    {
        _line.path = [self generateLinePathFrom:self.fromPoint toPoint:self.toPoint];
       // _line.position = CGPointMake(CGRectGetMidX(self.bounds) - radius, CGRectGetMidY(self.bounds) - radius);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (!_hasInitialized && !CGRectEqualToRect(frame, CGRectZero))
            [self initializeControl];
    }
    
    return self;
}

-(void)initializeControl
{
    //int radius = self.bounds.size.width / 2;
    
    _line = [CAShapeLayer layer];
//    _circle.path = [self generateCirclePathWithRadius:radius];
//    _circle.position = CGPointMake(CGRectGetMidX(self.bounds) - radius, CGRectGetMidY(self.bounds) - radius);
//    _circle.fillColor = [UIColor redColor].CGColor;
//    _circle.strokeColor = [UIColor colorWithRed:0.75 green:0.0 blue:0.0 alpha:1.0].CGColor;
//    _circle.lineWidth = self.bounds.size.width * 0.05;
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    UIColor *lineColor = [[UIColor redColor] colorWithAlphaComponent:1];
    //    CGContextSetLineDash(context, 0.0, NULL, 0);
    //    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    //    CGContextSetLineWidth(context, 2);
    //
    //    CGContextBeginPath(context);
    //    CGContextMoveToPoint(context, self.fromPoint.x, self.fromPoint.y);
    //    CGContextAddLineToPoint(context, self.toPoint.x, self.toPoint.y);
    //    CGContextStrokePath(context);
    
    _line.path = [self generateLinePathFrom:self.fromPoint toPoint:self.toPoint];
    _line.position = self.fromPoint;//CGPointMake(CGRectGetMidX(self.bounds) - radius, CGRectGetMidY(self.bounds) - radius);
    _line.fillColor = [UIColor redColor].CGColor;
    _line.strokeColor = [UIColor redColor].CGColor;
    _line.lineWidth = 2;
    [self.layer addSublayer:_line];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOnOff)];
    [self addGestureRecognizer:_tapGestureRecognizer];
    
    self.userInteractionEnabled = YES;
    _hasInitialized = YES;
}

-(CGPathRef)generateCirclePathWithRadius:(CGFloat)radius
{
    return [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * radius, 2.0 * radius) cornerRadius:radius].CGPath;
}

-(CGPathRef)generateLinePathFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint
{
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    [path moveToPoint:fromPoint];
    [path addLineToPoint:toPoint];
    
    [path closePath];
    return path.CGPath;
}

-(void)toggleOnOff
{
//    self.on = !self.on;
    NSLog(@"HI HI ");
}


- (CGRect)rectForNodePoints
{
    CGPoint p1 = self.fromPoint;
    CGPoint p2 = self.toPoint;
    
    
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


//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIColor *lineColor = [[UIColor redColor] colorWithAlphaComponent:1];
//    CGContextSetLineDash(context, 0.0, NULL, 0);
//    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
//    CGContextSetLineWidth(context, 2);
//
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, self.fromPoint.x, self.fromPoint.y);
//    CGContextAddLineToPoint(context, self.toPoint.x, self.toPoint.y);
//    CGContextStrokePath(context);
//    
//    //CGContextRelease(context);
//
//}


// Too slow
//- (UIView *)imageWithImage
//{
//    UIImage *image = [UIImage imageNamed:@"red_line"];
//    CGSize newSize = CGSizeMake(fabs(self.fromPoint.x - self.toPoint.x), fabs(self.fromPoint.y - self.toPoint.y));
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//    [image drawInRect:CGRectMake(0, 0, fabs(newSize.width), fabs(newSize.height))];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: newImage];
//
//    return imageView;
//}
//
//- (UIView *)imageView
//{
//    UIImage *leftCap = [UIImage imageNamed:@"red_line"];
//    //UIImage *arrow = [UIImage imageNamed:@"red_line"];
//    //UIImage *rightCap = [UIImage imageNamed:@"rightCap"];
//
//    // stretch left and right cap
//    // calculate the edge insets beforehand !
//    CGFloat topInset = self.fromPoint.y;
//    CGFloat bottomInset = self.toPoint.y;
//    CGFloat leftInset = self.fromPoint.x;
//    CGFloat rightInset = self.toPoint.x;
//
//    UIImage *leftCapStretched = [leftCap resizableImageWithCapInsets:UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)];
//    //UIImage *rightCapStretched = [rightCap resizableImageWithCapInsets:UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)];
//
//    CGFloat widthOfAllImages = leftCapStretched.size.width;// + arrow.size.width + rightCapStretched.size.width;
//
//    // build the actual glued image
//
//    //UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthOfAllImages, leftCap.size.width), NO, 0);
//    [leftCap drawAtPoint:self.fromPoint];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:leftCap];
//    [imageView setFrame:CGRectMake(self.fromPoint.x, self.fromPoint.y, imageView.frame.size.width, imageView.frame.size.height)];
////    [arrow drawAtPoint:CGPointMake(leftCap.size.width, 0)];
////    [rightCapStretched drawAtPoint:CGPointMake(leftCap.size.width + arrow.size.width, 0)];
//    //UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
//   // UIGraphicsEndImageContext();
//
//    return imageView;
//}

@end
