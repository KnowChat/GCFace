//
//  GCGIFView.m
//  GrabChat
//
//  Created by Francis on 2018/4/19.
//  Copyright © 2018年 KnowChat. All rights reserved.
//

#import "GCGIFView.h"
@implementation GIFInfo
@end


@interface GCGIFView()

@end
@implementation GCGIFView
+(NSMutableDictionary<NSString*,GIFInfo*>*)back{
    static NSMutableDictionary<NSString*,GIFInfo*>* save;
    if (!save){
        save = [[NSMutableDictionary alloc] init];
    }
    return save;
}
@synthesize file;
-(NSString *)file{
    return self->file;
}
-(void)setFile:(NSString *)file{
    self->file = file;
    NSMutableDictionary<NSString*,GIFInfo*>* backup = [GCGIFView back];
    
    GIFInfo* images = backup[file];
    if (images == nil){
        images = [self fetch:file];
        backup[file] = images;
    }
    self.animationImages = images.images;
    self.animationDuration = images.during;
    [self startAnimating];
}

-(GIFInfo*)fetch:(NSString*)url{
    
    
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)([[NSURL alloc] initFileURLWithPath:url]), nil);
    
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:count];
    NSTimeInterval time = 0;
    
    
    for (size_t i = 0; i < count; i++){
        CGImageRef img = CGImageSourceCreateImageAtIndex(source, i, nil);
        CFDictionaryRef prop = CGImageSourceCopyPropertiesAtIndex(source, i, nil);
        NSDictionary* nsprop = (__bridge NSDictionary *)(prop);
        
        UIImage* uiimg = [[UIImage alloc] initWithCGImage:img scale:UIScreen.mainScreen.scale orientation:UIImageOrientationUp];
        time += ((NSString*)nsprop[@"{GIF}"][@"DelayTime"]).doubleValue;
        [result addObject:uiimg];
        CGImageRelease(img);
        CFRelease(prop);
    }

    CFRelease(source);
    
    GIFInfo* info = [[GIFInfo alloc] init];
    info.images = result;
    info.during = time;
    return info;
}
@end
