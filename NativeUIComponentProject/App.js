/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  View,
  NativeModules,
  TouchableOpacity,
  findNodeHandle,
  Text,
} from 'react-native';
import TestViewModule from './Components/TestView';
var Dimensions = require('Dimensions');
var {width , height} = Dimensions.get('window');

//导入原生组件
var nativeTestViewManager = NativeModules.TestViewManager;

type Props = {};
export default class App extends Component<Props> {

  onPressNoBackValue = ()=>{
      nativeTestViewManager.notCallBackValueMethod(this.getTestViewHandle());
  }
  onPressHaveBackValue = ()=>{
      nativeTestViewManager.haveCallBackValueMethod(this.getTestViewHandle()).then((success)=>{
          console.log('--------------' + success);
      },(error)=> {
          console.log('--------------' + error);
      })
  }
  //获取原生组件的reactTag
  getTestViewHandle = () => {
        return findNodeHandle(this.refs.testView);
  }
  render() {
    var data = [];
    for (var i = 0; i < 10 ; i++){
        data.push(i + '你好');
      }
    return (
      <View style={styles.container}>
          <TestViewModule
              ref = "testView"
              style={styles.private}
              dataArray= {data}
              isEdit={true}
              onClickEvent={(event)=>{
                console.log(event.nativeEvent.content + event.nativeEvent['index']);
                  //调用原生方法
                  nativeTestViewManager.clickCellEventData(event.nativeEvent);
              }}
          />
          <View style={styles.bottomViewStyle}>
              <TouchableOpacity
                  activeOpacity={0.5}
                  onPress={this.onPressNoBackValue}
              >
                <Text style={styles.buttonStyle}>
                  调用没有返回值方法
                </Text>
              </TouchableOpacity>
              <TouchableOpacity
                  activeOpacity={0.5}
                  onPress={this.onPressHaveBackValue}
              >
                  <Text style={styles.buttonStyle}>
                      调用有返回值方法
                  </Text>
              </TouchableOpacity>
          </View>
      </View>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    flex : 1,
    alignItems: 'center',
    backgroundColor: 'red',
  },
    private: {
        width : width,
        height : height - 100,
        backgroundColor: 'white'
    },
    bottomViewStyle:{
        alignItems: 'center',
        height : 100,
        backgroundColor : 'orange',
        justifyContent: 'space-around',
        position:'absolute',
        left:0,
        right:0,
        bottom:0,
    },
    buttonStyle :{
        color : 'white',
        padding: 10,
        borderRadius : 5,
        borderColor : 'green',
        borderWidth: 1.0
    }
});
