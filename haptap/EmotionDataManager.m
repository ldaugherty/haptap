//
//  EmotionDataManager.m
//  haptap
//
//  Created by Lucy Daugherty on 6/12/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "EmotionDataManager.h"

@interface EmotionDataManager ()

@property (nonatomic, strong) NSMutableDictionary *emotionData;

@end

@implementation EmotionDataManager

+ (EmotionDataManager *)dataManager {
    static EmotionDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EmotionDataManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self readInitialDataFromUserDefaults];
    }
    return self;
}

- (void)readInitialDataFromUserDefaults {
    self.emotionData = [[NSUserDefaults standardUserDefaults] objectForKey:@"emotionData"];
    if (!self.emotionData) {
        self.emotionData = [NSMutableDictionary dictionary];
    }
}

- (void)synchronizeWithUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:self.emotionData forKey:@"emotionData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setCurrentEmotion:(Emotion *)emotion {
    NSString *timeString = [self currentTimeString];
    
    if (self.emotionData[timeString]) {
        NSLog(@"They already entered an emotion for this hour");
    }
    if (emotion.title) {
        self.emotionData[timeString] = emotion.title;
    } else {
        [self.emotionData removeObjectForKey:timeString];
    }
    [self synchronizeWithUserDefaults];
}

- (Emotion *)getEmotionForCurrentHour {
    Emotion *emotion = [Emotion new];
    NSString *emotionTitle = self.emotionData[[self currentTimeString]];
    if (emotionTitle) {
        emotion.title = emotionTitle;
        return emotion;
    }
    return nil;
}

- (NSString *)currentTimeString {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH"];
    NSDate *now = [[NSDate alloc] init];
    
    return [format stringFromDate:now];
}

@end
