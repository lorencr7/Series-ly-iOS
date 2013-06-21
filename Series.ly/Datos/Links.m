//
//  Links.m
//  Series ly iOS
//
//  Created by Lorenzo Villarroel Pérez on 24/03/13.
//  Copyright (c) 2013 lorenzo villarroel perez. All rights reserved.
//

#import "Links.h"
#import "Link.h"

@implementation Links

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSArray * offialServerDictionary = [dictionary objectForKey:@"oficialServer"];
        NSArray * streamingDictionary = [dictionary objectForKey:@"streaming"];
        //NSArray * directDownloadDictionary = [dictionary objectForKey:@"direct_download"];
        NSString * error2 = [dictionary objectForKey:@"error"];
        
        self.officialServer = [NSMutableArray array];
        self.streaming = [NSMutableArray array];
        self.directDownload = [NSMutableArray array];
        
        for (NSDictionary * linkDictionary in offialServerDictionary) {
            [self.officialServer addObject:[[Link alloc] initWithDictionary:linkDictionary]];
        }
        
        for (NSDictionary * linkDictionary in streamingDictionary) {
            NSString * hostServer = linkDictionary[@"host"];
            if (hostServer && [hostServer class] != [NSNull class]) {
                NSString * host = [hostServer lowercaseString];
                if ([host isEqualToString:@"vk"] || [host isEqualToString:@"putlocker"] || [host isEqualToString:@"vimeo"] || [host isEqualToString:@"youtube"] || [host isEqualToString:@"allmyvideos"]) {
                    [self.streaming addObject:[[Link alloc] initWithDictionary:linkDictionary]];
                }
            }
        }
        
        /*for (NSDictionary * linkDictionary in directDownloadDictionary) {
            [self.directDownload addObject:[[Link alloc] initWithDictionary:linkDictionary]];
        }*/

        self.error = [error2 intValue];
        if (self.error != 0) {
            NSLog(@"error %d grabbing links",self.error);
        }

    }
    return self;
}

@end