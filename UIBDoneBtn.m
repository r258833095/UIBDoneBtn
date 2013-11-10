//
//  UIBDoneBtn.m
//  eQuery
//
//  Created by 斌 on 13-8-16.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "UIBDoneBtn.h"

@implementation UIBDoneBtn

#define isPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

- (id)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor=[[UIColor alloc]initWithWhite:0 alpha:0.75];
        
        //完成按钮
        UIButton *doneInKeyboardButton;
        if (doneInKeyboardButton == nil)
        {
            doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            doneInKeyboardButton.frame = CGRectMake(270, 5, 44, 30);
            
            doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
            [doneInKeyboardButton setImage:[self getImageWithImageName:@"btn_done_up.png"] forState:UIControlStateNormal];
            [doneInKeyboardButton setImage:[self getImageWithImageName:@"btn_done_down.png"] forState:UIControlStateHighlighted];
            [doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self addSubview:doneInKeyboardButton]; 
        
        //键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        self.hidden=YES;
    }
    return self;
}

- (void)handleKeyboardWillHide:(NSNotification *)notification{
    self.hidden=YES;
}

- (void)handleKeyboardDidShow:(NSNotification *)notification{
    if (isPhone) {
        NSDictionary* info = [notification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        self.frame=CGRectMake(0, screenHeight-39-kbSize.height, 320, 50);
        self.hidden=NO;
    }else{
        self.hidden=YES;
    }
}
-(void)finishAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}

-(UIImage*)getImageWithImageName:(NSString*)imageNamed{
    
    NSString *path = [NSString stringWithFormat:
                      @"UIBDoneBtnBundle.bundle/Contents/Resources/%@",imageNamed];
    
    NSString *FullPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
    
    UIImage *image = [UIImage imageWithCGImage:[UIImage imageWithContentsOfFile:FullPath].CGImage];
    
    return image;
}


@end
