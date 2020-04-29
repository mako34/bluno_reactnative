//
//  BLuno.m
//  BlunoBridge
//
//  Created by Manuel Betancurt on 29/4/20.
//

#import "BLuno.h"
#import <React/RCTLog.h>

@implementation BLuno

// To export a module named CalendarManager
RCT_EXPORT_MODULE();

//Espose methods to JS
RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

//a callback
RCT_EXPORT_METHOD(findEvents:(RCTResponseSenderBlock)callback)
{
  
  callback(@[@"halo from native iOS"]);
}

@end

