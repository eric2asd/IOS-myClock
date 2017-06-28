//
//  MyClockView.swift
//  myClock
//
//  Created by 陳信毅 on 2017/6/26.
//  Copyright © 2017年 陳信毅. All rights reserved.
//

import UIKit

class MyClockView: UIView {
    private var viewW :CGFloat = 0
    private var viewH :CGFloat = 0
    private var viewCx : CGFloat = 125
    private var viewCy : CGFloat = 125
    private var isInit = false
    private var context:CGContext?
    private var a = 270.0
    private var b = 270.0
    private var c = 270.0
    private var i = 0
    private var s = 1.0
    private var m = 0.0
    private var h = 0.0


    private func initState(_ rect: CGRect){
        isInit = true
        viewW = rect.size.width
        viewH = rect.size.height
        context = UIGraphicsGetCurrentContext()

        
        resetTime()
        
        s = 0.01
        Timer.scheduledTimer(withTimeInterval: s, repeats: true, block: {(timer) in
            self.refreshView()
        } )
        
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: {(timer) in
            self.resetTime()
        })
        
        
    }
    private func refreshView(){
        i += 1
        m += s
        h += s
        if i % 1000 == 0{
            minFinger()
            m = 0
        }
        if i % 10000 == 0 {
            hourFinger()
            h = 0
            i = 0
        }


        secondFinger()
        setNeedsDisplay()
    }

    private func secondFinger(){
        if a > 360 {
            a = a - 360
        }
        a = a + 6 * s
    }
    
    private func minFinger(){
        if b > 360 {
            b = b - 360
        }
        b = b + 0.1 * m
        
    }
    
    private func hourFinger(){
        if c > 360 {
            c = c - 360
        }
        c = c + 6 / 43200 * h
        
    }
    private func resetTime(){
        let now = Date()
        let cal = Calendar.current
        var dataComps = cal.dateComponents([.hour, .minute,.second], from: now)
        m = 0
        h = 0
        i = 0
        a = 270 + 6 * Double(dataComps.second!)
        b = 270 + 6 * Double(dataComps.minute!)  + 0.1 * Double(dataComps.second!)
        c = 270 + 30 * Double(dataComps.hour! % 12) + 0.5 * Double(dataComps.minute!) + 1 / 120 * Double(dataComps.second!)
    }
    
    
    
    override func draw(_ rect: CGRect) {
        if !isInit{initState(rect)}
        
        context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
        context?.move(to: CGPoint(x: viewCx, y: viewCy))
        context?.addLine(to: CGPoint(x: viewCx + CGFloat(cos(a * Double.pi/180)*60), y: viewCy+CGFloat(sin(a * Double.pi/180)*60)))
        context?.drawPath(using: CGPathDrawingMode.stroke)
        
        context?.setLineWidth(1.5)
        context?.setStrokeColor(red: 0, green: 1, blue: 0, alpha: 1)
        context?.move(to: CGPoint(x: viewCx, y: viewCy))
        context?.addLine(to: CGPoint(x: viewCx + CGFloat(cos(b * Double.pi/180)*50), y: viewCy+CGFloat(sin(b * Double.pi/180)*50)))
        context?.drawPath(using: CGPathDrawingMode.stroke)
        
        context?.setLineWidth(2)
        context?.setStrokeColor(red: 0, green: 0, blue: 1, alpha: 1)
        context?.move(to: CGPoint(x: viewCx, y: viewCy))
        context?.addLine(to: CGPoint(x: viewCx + CGFloat(cos(c * Double.pi/180)*40), y: viewCy+CGFloat(sin(c * Double.pi/180)*40)))
        context?.drawPath(using: CGPathDrawingMode.stroke)

    }
    
    
}
