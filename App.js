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
} from 'react-native';

import {
  Colors,
} from 'react-native/Libraries/NewAppScreen';

const App: () => React$Node = () => {
  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        <View >
          <Text>.</Text>
          <View style={styles.subRaw}>
          <Text>Not ready</Text>
          <TouchableOpacity> 
            <Text>Search</Text>
          </TouchableOpacity>
          </View>


          <TextInput
            style={{ height: 40, borderColor: 'gray', borderWidth: 1, backgroundColor: 'gray' }}
            onChangeText={text => onChangeText(text)}
          />
          <TouchableOpacity style={{padding:30}}
            onPress={() => {
              // alert('ss9');

              //call something on ios
              // NativeModules.RNHello.addEvent('cumple de fernando', 'mansion playa')

              //initiate callback on ios
              NativeModules.RNHello.findEvents(resp => {
                alert(resp);
              })

            }}>
            <Text>   Send message </Text>
          </TouchableOpacity>

          <Text style={{padding:30}}>
            Received message</Text>

          <View style={styles.subRaw}>
            <TouchableOpacity> 
              <Text>Turn LEDS ON</Text>
            </TouchableOpacity>
            <TouchableOpacity> 
            <Text>Turn LEDS OFF</Text>
          </TouchableOpacity>
          </View> 

        </View>
      
      </SafeAreaView>
    </>
  );
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
