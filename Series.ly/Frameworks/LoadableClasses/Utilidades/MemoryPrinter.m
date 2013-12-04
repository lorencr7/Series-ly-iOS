//
//  MemoryPrinter.m
//  hooola
//
//  Created by Lorenzo Villarroel Pérez on 30/10/13.
//  Copyright (c) 2013 jobssy. All rights reserved.
//

#import "MemoryPrinter.h"
#import <mach/mach.h>

@implementation MemoryPrinter

+(void) report_memory {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS ) {
        double size = info.resident_size;
        size /= (1024*1024);
        NSLog(@"Memory in use (in MBytes): %.6f", size);
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
    }
}

@end
