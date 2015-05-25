//
//  ViewController.m
//  DrawingDemo
//
//  Created by zhangyafeng on 15/5/24.
//  Copyright (c) 2015年 think. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet TouchView *touchView;
@end

@implementation ViewController
{
    UISegmentedControl * _seg;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.touchView.viewController = self;
//    [self setupNavgationBar];
    [self createSegment];
}



-(void)createSegment
{
    _seg = [[UISegmentedControl alloc] initWithItems:[@"White Red Green Orange Yellow" componentsSeparatedByString:@" "]];
    _seg.selectedSegmentIndex = 0;
    
    [_seg addTarget:self action:@selector(selectChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _seg;
}

-(UIColor*)currentColor
{
    [self selectChange:_seg];
    return  self.touchView.color;
}

-(void)selectChange:(UISegmentedControl*)seg
{
    switch ([seg selectedSegmentIndex])
    {
        case 0:
            self.touchView.color = [UIColor whiteColor];
            break;
        case 1:
            self.touchView.color = [UIColor redColor];
            break;
        case 2:
            self.touchView.color = [UIColor greenColor];
            break;
        case 3:
            self.touchView.color = [UIColor orangeColor];
            break;
        case 4:
            self.touchView.color = [UIColor yellowColor];
            break;
        default:
            self.touchView.color = [UIColor purpleColor];
            break;
    }

}

-(UIImage*)imageFromView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

//-(void)storageData
//{
//    NSString *chachePth = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *archivePath = [NSString stringWithFormat:@"%@/123.archiver",chachePth];
//    UIImage *image = [self imageFromView:self.touchView];
//    [NSKeyedArchiver archiveRootObject:image toFile:archivePath];
//    
//}
//
//-(void)decodeData
//{
//    NSString *chachePth = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *archivePath = [NSString stringWithFormat:@"%@/123.archiver",chachePth];
//    
//    UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
//    [self.touchView setBackgroundColor:[UIColor colorWithPatternImage:image]];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
