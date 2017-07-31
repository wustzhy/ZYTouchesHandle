//
//  CView.m
//  LXDEventChain
//
//  Created by 滕雪 on 15/12/26.
//  Copyright © 2015年 滕雪. All rights reserved.
//

#import "CView.h"

#import "ZYTableView.h"

@interface CView()<UITableViewDataSource, UITableViewDelegate , UIGestureRecognizerDelegate>

@property (nonatomic,   weak)     ZYTableView * tableView;


@end

@implementation CView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCView:)];
    tap.delegate = self; //UIGestureRecognizerDelegate
    [self addGestureRecognizer:tap];
    
    ZYTableView * tableView = [[ZYTableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2)];
    tableView.backgroundColor = [UIColor yellowColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    
    self.tableView = tableView;
    
    UIView * sview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tableView.frame), self.bounds.size.width/2, 100)];
    sview.backgroundColor = [UIColor blueColor];
    [self addSubview:sview];
}

//- (instancetype)init      //xib不走
//{
//    self = [super init];
//    if (self) {
// 
//    }
//    return self;
//}



- (UIView *)hitTest: (CGPoint)point withEvent: (UIEvent *)event
{
    NSLog(@"%@ - %@",NSStringFromClass([self class]), self.gestureRecognizers);
    return [super hitTest: point withEvent: event];
}

// CView继承于 UIScrollView or UIView 👇

// 给cview的手势方法         //-UIScrollView走   //-UIView不走
- (void)tapCView:(UITapGestureRecognizer *)tap{
   NSLog(@"%@ - %@",NSStringFromClass([self class]), self.gestureRecognizers); 
}

// cview的touches方法      //-UIView走         //-UIScrollView不走
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@ - %@",NSStringFromClass([self class]), self.gestureRecognizers);
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
    }
    return  YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0,  self.bounds.size.width, self.bounds.size.height/4)];
    cell.backgroundColor = [UIColor clearColor];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell - %zd",indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.bounds.size.height/4;
}

@end
