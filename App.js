/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  TextInput,
  View,
  Text,
  StatusBar,
  TouchableOpacity,
  NativeModules,
  NativeEventEmitter,
} from 'react-native';

import {
  Colors,
} from 'react-native/Libraries/NewAppScreen';

const { BLuno } = NativeModules;
const eventEmitter = new NativeEventEmitter(BLuno);


const onSessionConnect = (event) => {
  console.log("********* onSessionConnect");

  console.log("Tu device:",event);
}

const onDeviceConnected = (event) => {
  console.log("********* onDeviceConnected");

  // console.log("Tu device:",event);
}

const onSessionStatus = (event) => {
  console.log("********* onSessionStatus");

  console.log("Tu device:",event);
}


const subscription = eventEmitter.addListener('onSessionConnect', onSessionConnect);

eventEmitter.addListener('onDeviceConnected', onDeviceConnected);
eventEmitter.addListener('onSessionStatus', onSessionStatus);

onSessionStatus

// const bluno = NativeModules.BLuno
// const blunoEmitter = new NativeEventEmitter(NativeModules.BLuno)
// const subscription = DeviceEventEmitter.addListener('myAwesomeEvent', e => console.log(e));

// const subscription = blunoEmitter.addListener('bluno-progress', (data) => console.log(data.progress))


class App extends React.Component {

  //constructor for state, soon

  componentWillUnmount(){

    //unsubscribe
    subscription.remove()

  }



  render(){
    return (

    
      <View>




<StatusBar barStyle="dark-content" />
      <SafeAreaView>
      <TouchableOpacity style={styles.subRaw}
        onPress={() => {
          NativeModules.BLuno.initEvent('tus parametors')
        }}
      > 
            <Text>init</Text>
          </TouchableOpacity>
        <View >
          <Text>.</Text>
          <View style={styles.subRaw}>
          <Text>Not ready</Text>
          
          <TouchableOpacity
            onPress={() => {
              NativeModules.BLuno.searchDeviceEvent('tus params search')
            }}
          > 
            <Text>Search</Text>
          </TouchableOpacity>
          </View>

          <TouchableOpacity style={styles.subRaw}
        onPress={() => {
          NativeModules.BLuno.connectDeviceEvent('tus params search')
          }}
      > 
            <Text>Connect</Text>
          </TouchableOpacity>

          <TextInput
            style={{ height: 40, borderColor: 'gray', borderWidth: 1, backgroundColor: 'gray' }}
            onChangeText={text => onChangeText(text)}
          />
          <TouchableOpacity style={{padding:30}}
            onPress={() => {
              // NativeModules.BLuno.SetFreqEvent('tus params search')

              NativeModules.BLuno.getDeviceName((err ,name) => {
                console.log(err, name);
             });

            }}>
            <Text>   Send message </Text>
          </TouchableOpacity>

          <Text style={{padding:30}}>
            Received message</Text>

          <View style={styles.subRaw}>
            <TouchableOpacity
            onPress={() => {
              NativeModules.BLuno.TurnLEDonEvent('tus params search')
              }}
            > 
              <Text>Turn LEDS ON</Text>
            </TouchableOpacity>
            <TouchableOpacity
            onPress={() => {
              NativeModules.BLuno.TurnLEDoffEvent('tus params search')
              }}
            > 
            <Text>Turn LEDS OFF</Text>
          </TouchableOpacity>
          </View> 

        </View>
      
      </SafeAreaView>



      </View>
    
  

    )
          }
};

const styles = StyleSheet.create({
  subRaw:{
    backgroundColor:'#4286f4', 
    flexDirection:'row',
    justifyContent: 'space-around',
    padding:30,

  },
  scrollView: {
    backgroundColor: Colors.lighter,
  },
  engine: {
    position: 'absolute',
    right: 0,
  },
  body: {
    backgroundColor: Colors.white,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: Colors.black,
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: Colors.dark,
  },
  highlight: {
    fontWeight: '700',
  },
  footer: {
    color: Colors.dark,
    fontSize: 12,
    fontWeight: '600',
    padding: 4,
    paddingRight: 12,
    textAlign: 'right',
  },
});

export default App;
