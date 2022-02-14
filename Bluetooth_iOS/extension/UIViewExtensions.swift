//
//  UIViewExtensions.swift
//  JION_ZHOU_iOS
//
//  Created by JION_ZHOU on 2020/10/29.
//  Copyright © 2020 JION_ZHOU. All rights reserved.
//

import UIKit

enum Direction {
    case top
    case left
    case bottom
    case right
}

extension UIView {
    
    //添加圆角
    func addCorner(with leftRadius:CGFloat = 0,rightRadius:CGFloat = 0,bottomLeftRadius:CGFloat = 0,bottomRightRadius:CGFloat = 0) {
        let width:CGFloat = self.width
        let height:CGFloat = self.height
        let maskPath = UIBezierPath()
        maskPath.lineWidth = 1.0
        maskPath.lineCapStyle = .round
        maskPath.lineJoinStyle = .round
        
        maskPath.move(to: CGPoint(x: bottomRightRadius, y: height))
        maskPath.addLine(to: CGPoint(x: width-bottomRightRadius, y: height))
    
        maskPath.addQuadCurve(to: CGPoint(x: width, y: height-bottomRightRadius), controlPoint: CGPoint(x: width, y: height))
        maskPath.addLine(to: CGPoint(x: width, y: rightRadius))
        
        
        maskPath.addQuadCurve(to: CGPoint(x: width-rightRadius, y: 0), controlPoint: CGPoint(x: width, y: 0))
        maskPath.addLine(to: CGPoint(x: leftRadius, y: 0))
        
        maskPath.addQuadCurve(to: CGPoint(x: 0, y: leftRadius), controlPoint: CGPoint(x: 0, y: 0))
        maskPath.addLine(to: CGPoint(x: 0, y: height-bottomLeftRadius))
        maskPath.addQuadCurve(to: CGPoint(x: bottomLeftRadius, y: height), controlPoint: CGPoint(x: 0, y: height))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, w: width, h: height)
        shapeLayer.path = maskPath.cgPath
        self.layer.mask = shapeLayer
    }
    
    ///获取当前view所在控制器
    func getControllerFromview(view:UIView)->UIViewController?{
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
        
    }
    /// 尺寸
    var size: CGSize {
        get {
            return self.frame.size
        }
        set(newValue) {
            self.frame.size = CGSize(width: newValue.width, height: newValue.height)
        }
    }
    
    /// 宽度
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newValue) {
            self.frame.size.width = newValue
        }
    }
    
    /// 高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newValue) {
            self.frame.size.height = newValue
        }
    }
    
    /// 横坐标
    var x: CGFloat {
        get {
            return self.frame.minX
        }
        set(newValue) {
            self.frame = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }
    
    /// 纵坐标
    var y: CGFloat {
        get {
            return self.frame.minY
        }
        set(newValue) {
            self.frame = CGRect(x: x, y: newValue, width: width, height: height)
        }
    }
    
    /// 右端横坐标
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set(newValue) {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    /// 底端纵坐标
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set(newValue) {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    /// 中心横坐标
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set(newValue) {
            center.x = newValue
        }
    }
    
    /// 中心纵坐标
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            center.y = newValue
        }
    }
    
    /// 原点
    var origin: CGPoint {
        get {
            return self.origin
        }
        set(newValue) {
            frame.origin = newValue
        }
    }
    
    /// 右上角坐标
    var topRight: CGPoint {
        get {
            return CGPoint(x: frame.origin.x + frame.size.width, y: frame.origin.y)
        }
        set(newValue) {
            frame.origin = CGPoint(x: newValue.x - width, y: newValue.y)
        }
    }
    
    /// 右下角坐标
    var bottomRight: CGPoint {
        get {
            return CGPoint(x: frame.origin.x + frame.size.width, y: frame.origin.y + frame.size.height)
        }
        set(newValue) {
            frame.origin = CGPoint(x: newValue.x - width, y: newValue.y - height)
        }
    }
    
    /// 左下角坐标
    var bottomLeft: CGPoint {
        get {
            return CGPoint(x: frame.origin.x, y: frame.origin.y + frame.size.height)
        }
        set(newValue) {
            frame.origin = CGPoint(x: newValue.x, y: newValue.y - height)
        }
    }
    
    /// 获取UIView对象某个方向缩进指定距离后的方形区域
    ///
    /// - Parameters:
    ///   - direction: 要缩进的方向
    ///   - distance: 缩进的距离
    /// - Returns: 得到的区域
    func cutRect(direction: Direction, distance: CGFloat) ->  CGRect {
        switch direction {
        case .top:
            return CGRect(x: 0, y: distance, width: self.width, height: self.height - distance)
        case .left:
            return CGRect(x: distance, y: 0, width: self.width - distance, height: self.height)
        case .right:
            return CGRect(x: 0, y: 0, width: self.width - distance, height: self.height)
        case .bottom:
            return CGRect(x: 0, y: 0, width: self.width, height: self.height - distance)
        }
    }
    
    
    /// 添加一块色区
    /// - Parameters:
    ///   - rect: 区域
    ///   - color: 颜色
    func addLayer(rect:CGRect,color:UIColor){
        let layer = CALayer()
        layer.frame = rect
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
    }
}
