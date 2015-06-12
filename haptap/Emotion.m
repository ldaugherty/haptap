//
//  Emotion.m
//  haptap
//
//  Created by Lucy Daugherty on 6/12/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "Emotion.h"

@implementation Emotion

+ (Emotion *)emotionWithTitle:(NSString *)title {
    return [Emotion emotionWithTitle:title image:nil];
}

+ (Emotion *)emotionWithTitle:(NSString *)title image:(UIImage *)image {
    Emotion *emotion = [Emotion new];
    emotion.title = title;
    emotion.image = image;
    return emotion;
}

@end
