//
//  GCGIFView.h
//  GrabChat
//
//  Created by Francis on 2018/4/19.
//  Copyright © 2018年 KnowChat. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GIFInfo:NSObject
@property(nonatomic,copy)NSArray<UIImage*>*images;
@property(nonatomic,assign)NSTimeInterval during;
@end
@interface GCGIFView : UIImageView
@property(nonatomic,copy)NSString* file;
@end
