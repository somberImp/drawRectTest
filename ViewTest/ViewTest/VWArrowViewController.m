//
//  VWArrowViewController.m
//  ViewTest
//
//  Created by Vivian Wehner on 3/9/16.
//  Copyright © 2016 Vivian Wehner. All rights reserved.
//

#import "VWArrowViewController.h"
#import "VWArrow.h"

@interface VWArrowViewController ()

@end

@implementation VWArrowViewController

- (instancetype)initFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint{
    self = [super init];
    if (self != nil) {
        self.fromPoint = fromPoint;
        self.toPoint = toPoint;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //VWArrow *arrow = [[VWArrow alloc]initFrom:self.fromPoint toPoint:self.toPoint];
    
    CALayer* layer = [CALayer layer];
    
    [layer setFrame:CGRectMake(self.fromPoint.x, self.fromPoint.y, self.toPoint.x, self.toPoint.y)];
    [layer setBackgroundColor:[UIColor clearColor].CGColor];
    [layer setDelegate:self];
    
    //self.view = arrow;
    [self.view.layer addSublayer:layer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    [layer setNeedsDisplay];

    
}

- (void)handleTap
{
    NSLog(@"TAPPPES");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"draw");
    
    CGContextRef context = ctx;
    UIColor *lineColor = [[UIColor redColor] colorWithAlphaComponent:1];
    CGContextSetLineDash(context, 0.0, NULL, 0);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextSetLineWidth(context, 2);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.fromPoint.x, self.fromPoint.y);//self.fromPoint.x, self.fromPoint.y);
    CGContextAddLineToPoint(context, self.toPoint.x, self.toPoint.y); //self.toPoint.x, self.toPoint.y);
    CGContextStrokePath(context);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
