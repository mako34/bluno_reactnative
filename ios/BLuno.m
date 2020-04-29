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
    return @[@"onSessionStatus", @"onSessionConnect",@"onDeviceConnected"];
}

RCT_EXPORT_MODULE();

#pragma mark- METHODS TO EXPOSE to JS
//Espose methods to JS

//Init
RCT_EXPORT_METHOD(initEvent:(NSString *)params)
{
  RCTLogInfo(@"blunoManager inited:%@", params);
  //init Bluno
  self.blunoManager = [DFBlunoManager sharedInstance];
  self.blunoManager.delegate = self;
  self.aryDevices = [[NSMutableArray alloc] init];

}

//connect to device, should be from table pop up!
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
//     [self sendEventWithName:@"onDeviceConnected" body:[NSString stringWithFormat:@"%@", self.aryDevices]];
  
      [self sendEventWithName:@"onSessionStatus" body:@"CONNECTED"];

}

RCT_EXPORT_METHOD(SetFreqEvent:(NSString *)params)
{
  RCTLogInfo(@"TurnLEDonEvent:%@", params);
 if (self.blunoDev.bReadyToWrite)
      {
  //        NSString* strTemp = self.txtSendMsg.text;
          NSString* strTemp = @"33";
  //        NSString* strTemp = [NSString stringWithFormat:@"freq:%@",  self.txtSendMsg.text];


          NSData* data = [strTemp dataUsingEncoding:NSUTF8StringEncoding];
          [self.blunoManager writeDataToDevice:data Device:self.blunoDev];
      }
    
}
 
RCT_EXPORT_METHOD(TurnLEDonEvent:(NSString *)params)
{
  RCTLogInfo(@"TurnLEDonEvent:%@", params);
  if (self.blunoDev.bReadyToWrite)
  {
      NSString* strTemp = @"LED_OFF";
      NSData* data = [strTemp dataUsingEncoding:NSUTF8StringEncoding];
      [self.blunoManager writeDataToDevice:data Device:self.blunoDev];
  }
    
}

RCT_EXPORT_METHOD(TurnLEDoffEvent:(NSString *)params)
{
  RCTLogInfo(@"TurnLEDoffEvent:%@", params);

    if (self.blunoDev.bReadyToWrite)
    {
        NSString* strTemp = @"LED_ON";
        NSData* data = [strTemp dataUsingEncoding:NSUTF8StringEncoding];
        [self.blunoManager writeDataToDevice:data Device:self.blunoDev];
    }
}


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
  
  [self sendEventWithName:@"onSessionStatus" body:@"readyToCommunicate"];

//    self.lbReady.text = @"Ready!";
//  HERE CALLBACK ready
}
-(void)didDisconnectDevice:(DFBlunoDevice*)dev
{
    NSLog(@"didDisconnectDevice");
  [self sendEventWithName:@"onSessionStatus" body:@"didDisconnectDevice"];


//    self.lbReady.text = @"Not Ready!";
//  HERE CALLBACK ready
}
-(void)didWriteData:(DFBlunoDevice*)dev
{
    NSLog(@"didWriteData");
  [self sendEventWithName:@"onSessionStatus" body:@"didWriteData"];


}
-(void)didReceiveData:(NSData*)data Device:(DFBlunoDevice*)dev
{
    NSLog(@"didReceiveData");
  [self sendEventWithName:@"onSessionStatus" body:@"didReceiveData"];


//    self.lbReceivedMsg.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//  HERE CALLBACK received data
}







@end

