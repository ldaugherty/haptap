//
//  Emotion.h
//  haptap
//
//  Created by Lucy Daugherty on 6/12/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Emotion : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (Emotion *)emotionWithTitle:(NSString *)title;
+ (Emotion *)emotionWithTitle:(NSString *)title image:(UIImage *)image;

@end
