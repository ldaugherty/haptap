//
//  EmotionDataManager.h
//  haptap
//
//  Created by Lucy Daugherty on 6/12/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Emotion.h"

@interface EmotionDataManager : NSObject

+ (EmotionDataManager *)dataManager;

- (Emotion *)getEmotionForCurrentHour;
- (void)setCurrentEmotion:(Emotion *)emotion;

@end
