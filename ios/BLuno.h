//
//  BLuno.h
//  BlunoBridge
//
//  Created by Manuel Betancurt on 29/4/20.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "DFBlunoManager.h"


@interface BLuno : RCTEventEmitter <RCTBridgeModule, DFBlunoDelegate>
@property(strong, nonatomic) DFBlunoManager* blunoManager;
@property(strong, nonatomic) DFBlunoDevice* blunoDev;
@property(strong, nonatomic) NSMutableArray* aryDevices;

@end

 
 
