//
//  BLuno.m
//  BlunoBridge
//
//  Created by Manuel Betancurt on 29/4/20.
//

#import "BLuno.h"
#import <React/RCTLog.h>

@implementation BLuno


- (NSArray<NSString *> *)supportedEvents {
    return @[@"onSessionConnect",@"onDeviceConnected"];
}

// To export a module named CalendarManager
RCT_EXPORT_MODULE();

//Espose methods to JS

//Init
RCT_EXPORT_METHOD(initEvent:(NSString *)params)
{
  RCTLogInfo(@"blunoManager inited:%@", params);
  //call a timed function
  
  
  self.blunoManager = [DFBlunoManager sharedInstance];
  self.blunoManager.delegate = self;
  self.aryDevices = [[NSMutableArray alloc] init];

//  [BLuno performSelector:@selector(onTick) withObject:nil afterDelay:3.0];
  
  
//  [self sendEventWithName:@"onSessionConnect" body:@{@"sessionId": @"abc"}];


}

RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

RCT_EXPORT_METHOD(searchDeviceEvent:(NSString *)params)
{
  RCTLogInfo(@"searchDeviceEvent:%@", params);

    [self.aryDevices removeAllObjects];
  //  [self.tbDevices reloadData];
   
    [self.blunoManager scan];
  RCTLogInfo(@"lunoManager scanning");
}

RCT_EXPORT_METHOD(connectDeviceEvent:(NSString *)params)
{
  RCTLogInfo(@"connectDeviceEvent:%@", params);

//    DFBlunoDevice* device = [self.aryDevices objectAtIndex:indexPath.row];
  
  DFBlunoDevice* device = [self.aryDevices objectAtIndex:0];
  if (self.blunoDev == nil)
     {
         self.blunoDev = device;
         [self.blunoManager connectToDevice:self.blunoDev];
     }
     else if ([device isEqual:self.blunoDev])
     {
         if (!self.blunoDev.bReadyToWrite)
         {
             [self.blunoManager connectToDevice:self.blunoDev];
         }
     }
     else
     {
         if (self.blunoDev.bReadyToWrite)
         {
             [self.blunoManager disconnectToDevice:self.blunoDev];
             self.blunoDev = nil;
         }
         
         [self.blunoManager connectToDevice:device];
     }
     [self sendEventWithName:@"onDeviceConnected" body:[NSString stringWithFormat:@"%@", self.aryDevices]];

}

////a callback
//RCT_EXPORT_METHOD(foundDeviceEvent:(RCTResponseSenderBlock)callback)
//{
//  //WHEN SCANNER FOUND DEVICES, WILL SHOW HERE
//  NSLog(@"foundDeviceEvent");
//
//
//  //how to hold till complete? or call another function when complete?
//  callback(@[@"blunoManager scan results"]);
//}




#pragma mark- DFBlunoDelegate

-(void)bleDidUpdateState:(BOOL)bleSupported
{
    if(bleSupported)
    {
        [self.blunoManager scan];
    }
}
-(void)didDiscoverDevice:(DFBlunoDevice*)dev
{
    NSLog(@"didDiscoverDevice:%@", dev);

    BOOL bRepeat = NO;
    for (DFBlunoDevice* bleDevice in self.aryDevices)
    {
        if ([bleDevice isEqual:dev])
        {
            bRepeat = YES;
            break;
        }
    }
    if (!bRepeat)
    {
        [self.aryDevices addObject:dev];
    }
//    [self.tbDevices reloadData];
//  HERE CALLBACK fill table list
//  [self foundDeviceEvent:[NSArray arrayWithArray:self.aryDevices]];
   
  [self sendEventWithName:@"onSessionConnect" body:[NSString stringWithFormat:@"%@", self.aryDevices]];
  
}
-(void)readyToCommunicate:(DFBlunoDevice*)dev
{
    NSLog(@"readyToCommunicate");

    self.blunoDev = dev;
//    self.lbReady.text = @"Ready!";
//  HERE CALLBACK ready
}
-(void)didDisconnectDevice:(DFBlunoDevice*)dev
{
    NSLog(@"didDisconnectDevice");

//    self.lbReady.text = @"Not Ready!";
//  HERE CALLBACK ready
}
-(void)didWriteData:(DFBlunoDevice*)dev
{
    NSLog(@"didWriteData");

}
-(void)didReceiveData:(NSData*)data Device:(DFBlunoDevice*)dev
{
    NSLog(@"didReceiveData");

//    self.lbReceivedMsg.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//  HERE CALLBACK received data
}

@end

