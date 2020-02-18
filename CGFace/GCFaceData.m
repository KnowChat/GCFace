//
//  GCFaceData.m
//  GrabChat
//
//  Created by Francis on 2018/4/19.
//  Copyright © 2018年 KnowChat. All rights reserved.
//

#import "GCFaceData.h"
@implementation GCFaceData
+(NSArray<GCFaceDataItem*>*)read{
    static NSMutableArray<GCFaceDataItem*>* result;
    static NSOperationQueue* queue;
    if (result != nil){
        return result;
    }else{
        if (queue == nil){
            queue = [[NSOperationQueue alloc] init];
            [queue addOperationWithBlock:^{
                NSString* path = [NSBundle.mainBundle pathForResource:@"face" ofType:@"mapping"];
                NSArray* array = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
                result = [[NSMutableArray alloc] initWithCapacity:array.count];
                for (NSString* item in array) {
                    NSArray<NSString*>* tuple = [item componentsSeparatedByString:@","];
                    if (tuple.count > 1){
                        GCFaceDataItem* item = [[GCFaceDataItem alloc] init];
                        item.key = tuple[0];
                        item.value = tuple[1];
                        item.fValue = tuple[2];
                        item.eValue = tuple[3];
                        NSString * name = [NSString stringWithFormat:@"%@fix@2x",item.key];
//                        item.image = [UIImage imageNamed:name];
                        NSString *path = [[NSBundle mainBundle] pathForResource:name
                                                                         ofType:@"png"];
                        item.image = [UIImage imageWithContentsOfFile:path];
                        [result addObject:item];
                    }
                }
            }];
        }
        [queue waitUntilAllOperationsAreFinished];
        return result;
    }
    
}
+(void)initialize{
    [super initialize];
}
+(NSDictionary*)AllForParse{
    NSArray<GCFaceDataItem*>* all = [GCFaceData read];
    static NSMutableDictionary* mapFace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapFace = [[NSMutableDictionary alloc] initWithCapacity:all.count];
        for (GCFaceDataItem* item in all) {
            mapFace[item.value] = item.key;
            mapFace[item.fValue] = item.key;
            mapFace[item.eValue] = item.key;
        }
    });
    return mapFace;
}

#pragma mark - 后期自定义图文混排表情
+(NSArray<GCFaceDataItem*>*)otherFaceReadWithMapName:(NSString *)mapName{
    static NSMutableArray<GCFaceDataItem*>* result;
    static NSOperationQueue* queue;
    if (result != nil){
        return result;
    }else{
        if (queue == nil){
            queue = [[NSOperationQueue alloc] init];
            [queue addOperationWithBlock:^{
                NSString* path = [NSBundle.mainBundle pathForResource:mapName ofType:@"mapping"];
                NSArray* array = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
                result = [[NSMutableArray alloc] initWithCapacity:array.count];
                for (NSString* item in array) {
                    NSArray<NSString*>* tuple = [item componentsSeparatedByString:@","];
                    if (tuple.count > 1){
                        GCFaceDataItem* item = [[GCFaceDataItem alloc] init];
                        item.key = tuple[0];
                        item.value = tuple[1];
                        NSString * name = [NSString stringWithFormat:@"%@fix@2x",item.key];
                        NSString *path = [[NSBundle mainBundle] pathForResource:name
                                                                         ofType:@"png"];
                        item.image = [UIImage imageWithContentsOfFile:path];
                        [result addObject:item];
                    }
                }
            }];
        }
        [queue waitUntilAllOperationsAreFinished];
        return result;
    }
}

+(NSDictionary*)otherForParseWithMapName:(NSString *)mapName{
    NSArray<GCFaceDataItem*>* all = [GCFaceData otherFaceReadWithMapName:mapName];
    static NSMutableDictionary* mapFace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapFace = [[NSMutableDictionary alloc] initWithCapacity:all.count];
        for (GCFaceDataItem* item in all) {
            mapFace[item.value] = item.key;
        }
    });
    return mapFace;
}

@end

@implementation GCFaceDataItem

@end
