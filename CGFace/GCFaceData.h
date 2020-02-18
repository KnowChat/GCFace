//
//  GCFaceData.h
//  GrabChat
//
//  Created by Francis on 2018/4/19.
//  Copyright © 2018年 KnowChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCFaceDataItem : NSObject
@property(nonatomic,nonnull)NSString* key;
@property(nonnull,nonatomic)NSString* value;
@property(nonnull,nonatomic)NSString* fValue;
@property(nonnull,nonatomic)NSString* eValue;
@property(nonnull,nonatomic)UIImage* image;
@end
@interface GCFaceData : NSObject
+(NSArray<GCFaceDataItem*>*_Nonnull)read;
+(NSDictionary*_Nonnull)AllForParse;
+(NSArray<GCFaceDataItem*>*_Nonnull)otherFaceReadWithMapName:(NSString *_Nonnull)mapName;
+(NSDictionary*_Nonnull)otherForParseWithMapName:(NSString *_Nonnull)mapName;
@end
