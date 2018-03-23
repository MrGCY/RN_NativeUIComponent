/**
 * 作者：Mr.GCY on 2018/3/23 上午9:09
 * 邮箱：mail@gaochenyang.cc
 */
'use strict';
import React, {Component} from "react";
import {
    View,
    requireNativeComponent
} from "react-native";


// PropTypes 放在了react 中引入，出错
// Undefined is not an object(evaluating ‘_react2.PropTypes.func’)
//正确引入方式
import PropTypes from 'prop-types';


// 这个文件中,凡是用到RCTTestView的地方,应该与OC中
// RCTViewManager子类中RCT_EXPORT_MODULE()括号中的参数一致,
// 如果没有参数,应为RCTViewManager子类的类名去掉manager
var RCTTestView = requireNativeComponent('TestView',TestViewModule);

export default class TestViewModule extends Component {
    static propTypes = {
        /**
         *
         * 定义组件需要传到原生端的属性
         * 使用PropTypes来进行校验
         */
        //tableView数据
        dataArray : PropTypes.array,
        //是否可以编辑
        isEdit : PropTypes.bool,
        onClickEvent : PropTypes.func
    }
    render() {
        return (
            //{...this.props} 这个东西是必须要有的，要不然设置不了它的属性
            <RCTTestView  {...this.props}/>
        );
    }
}
