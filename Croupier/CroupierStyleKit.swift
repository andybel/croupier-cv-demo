//
//  CroupierStyleKit.swift
//  Croupier
//
//  Created by Andy Bell on 23/11/2015.
//  Copyright (c) 2015 Bellovic. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class CroupierStyleKit : NSObject {

    //// Drawing Methods

    public class func drawCard(frame frame: CGRect = CGRectMake(0, 0, 120, 200), textCol: UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000), cardIdTxt: String = "10", suiteId: CGFloat = 1) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let color = UIColor(red: 0.865, green: 0.865, blue: 0.865, alpha: 1.000)

        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.41)
        shadow.shadowOffset = CGSizeMake(1.1, 1.1)
        shadow.shadowBlurRadius = 2

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRectMake(frame.minX + floor(frame.width * 0.02500 + 0.5), frame.minY + floor(frame.height * 0.01500 + 0.5), floor(frame.width * 0.97500 + 0.5) - floor(frame.width * 0.02500 + 0.5), floor(frame.height * 0.98500 + 0.5) - floor(frame.height * 0.01500 + 0.5)), cornerRadius: 7)
        CGContextSaveGState(context)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
        UIColor.whiteColor().setFill()
        rectanglePath.fill()
        CGContextRestoreGState(context)

        color.setStroke()
        rectanglePath.lineWidth = 0.5
        rectanglePath.stroke()


        //// Text 3 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, frame.minX + 0.10833 * frame.width, frame.minY + 0.07750 * frame.height)

        let text3Rect = CGRectMake(-10, -12.5, 20, 25)
        let text3Style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        text3Style.alignment = .Center

        let text3FontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(UIFont.labelFontSize()), NSForegroundColorAttributeName: textCol, NSParagraphStyleAttributeName: text3Style]

        let text3TextHeight: CGFloat = NSString(string: cardIdTxt).boundingRectWithSize(CGSizeMake(text3Rect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text3Rect);
        NSString(string: cardIdTxt).drawInRect(CGRectMake(text3Rect.minX, text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, text3Rect.width, text3TextHeight), withAttributes: text3FontAttributes)
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)


        //// topLeft Drawing
        let topLeftRect = CGRectMake(frame.minX + floor(frame.width * 0.03333 + 0.5), frame.minY + floor(frame.height * 0.12000 + 0.5), floor(frame.width * 0.17500 + 0.5) - floor(frame.width * 0.03333 + 0.5), floor(frame.height * 0.20500 + 0.5) - floor(frame.height * 0.12000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(topLeftRect)
        CGContextTranslateCTM(context, topLeftRect.origin.x, topLeftRect.origin.y)

        CroupierStyleKit.drawCardSymbol(frame: CGRectMake(0, 0, topLeftRect.size.width, topLeftRect.size.height), suiteId: suiteId)
        CGContextRestoreGState(context)


        //// mainSymbol Drawing
        let mainSymbolRect = CGRectMake(frame.minX + floor(frame.width * 0.24167 + 0.5), frame.minY + floor(frame.height * 0.34000 + 0.5), floor(frame.width * 0.76667 + 0.5) - floor(frame.width * 0.24167 + 0.5), floor(frame.height * 0.65500 + 0.5) - floor(frame.height * 0.34000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(mainSymbolRect)
        CGContextTranslateCTM(context, mainSymbolRect.origin.x, mainSymbolRect.origin.y)

        CroupierStyleKit.drawCardSymbol(frame: CGRectMake(0, 0, mainSymbolRect.size.width, mainSymbolRect.size.height), suiteId: suiteId)
        CGContextRestoreGState(context)


        //// bottomRightSymbol Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, frame.minX + 0.88750 * frame.width, frame.minY + 0.84250 * frame.height)
        CGContextRotateCTM(context, 180 * CGFloat(M_PI) / 180)

        let bottomRightSymbolRect = CGRectMake(-8.5, -8.5, 17, 17)
        CGContextSaveGState(context)
        UIRectClip(bottomRightSymbolRect)
        CGContextTranslateCTM(context, bottomRightSymbolRect.origin.x, bottomRightSymbolRect.origin.y)

        CroupierStyleKit.drawCardSymbol(frame: CGRectMake(0, 0, bottomRightSymbolRect.size.width, bottomRightSymbolRect.size.height), suiteId: suiteId)
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)


        //// Text Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, frame.minX + 0.89167 * frame.width, frame.minY + 0.92250 * frame.height)
        CGContextRotateCTM(context, 180 * CGFloat(M_PI) / 180)

        let textRect = CGRectMake(-10, -12.5, 20, 25)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center

        let textFontAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(UIFont.labelFontSize()), NSForegroundColorAttributeName: textCol, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = NSString(string: cardIdTxt).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        NSString(string: cardIdTxt).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)
    }

    public class func drawDiamonds() {

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(62.5, 0))
        bezierPath.addLineToPoint(CGPointMake(112, 62.5))
        bezierPath.addLineToPoint(CGPointMake(62.5, 125))
        bezierPath.addLineToPoint(CGPointMake(13, 62.5))
        bezierPath.addLineToPoint(CGPointMake(62.5, 0))
        bezierPath.closePath()
        UIColor.redColor().setFill()
        bezierPath.fill()
    }

    public class func drawSpades() {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(60.73, 3.29))
        bezierPath.addCurveToPoint(CGPointMake(37.21, 28.78), controlPoint1: CGPointMake(56.12, 9.56), controlPoint2: CGPointMake(50.95, 15.18))
        bezierPath.addCurveToPoint(CGPointMake(14.55, 55.88), controlPoint1: CGPointMake(22.42, 43.38), controlPoint2: CGPointMake(18.21, 48.45))
        bezierPath.addCurveToPoint(CGPointMake(10.33, 73.24), controlPoint1: CGPointMake(11.59, 61.9), controlPoint2: CGPointMake(10.33, 67.07))
        bezierPath.addCurveToPoint(CGPointMake(13.24, 86.99), controlPoint1: CGPointMake(10.33, 79.51), controlPoint2: CGPointMake(10.99, 82.62))
        bezierPath.addCurveToPoint(CGPointMake(32.85, 101.39), controlPoint1: CGPointMake(17.1, 94.41), controlPoint2: CGPointMake(24.83, 100.08))
        bezierPath.addCurveToPoint(CGPointMake(53.11, 96.67), controlPoint1: CGPointMake(39.82, 102.49), controlPoint2: CGPointMake(48.35, 100.54))
        bezierPath.addCurveToPoint(CGPointMake(56.37, 100.23), controlPoint1: CGPointMake(55.67, 94.66), controlPoint2: CGPointMake(56.17, 95.22))
        bezierPath.addCurveToPoint(CGPointMake(48.6, 121.41), controlPoint1: CGPointMake(56.72, 106.96), controlPoint2: CGPointMake(54.06, 114.13))
        bezierPath.addCurveToPoint(CGPointMake(45.94, 125.17), controlPoint1: CGPointMake(47.14, 123.37), controlPoint2: CGPointMake(45.94, 125.02))
        bezierPath.addCurveToPoint(CGPointMake(64.24, 125.38), controlPoint1: CGPointMake(45.94, 125.27), controlPoint2: CGPointMake(54.16, 125.38))
        bezierPath.addCurveToPoint(CGPointMake(82.55, 125.12), controlPoint1: CGPointMake(74.32, 125.38), controlPoint2: CGPointMake(82.55, 125.27))
        bezierPath.addCurveToPoint(CGPointMake(79.54, 120.81), controlPoint1: CGPointMake(82.55, 124.97), controlPoint2: CGPointMake(81.19, 123.02))
        bezierPath.addCurveToPoint(CGPointMake(71.01, 99.03), controlPoint1: CGPointMake(74.07, 113.43), controlPoint2: CGPointMake(71.01, 105.65))
        bezierPath.addCurveToPoint(CGPointMake(74.02, 96.57), controlPoint1: CGPointMake(71.01, 94.76), controlPoint2: CGPointMake(71.36, 94.46))
        bezierPath.addCurveToPoint(CGPointMake(91.32, 102.14), controlPoint1: CGPointMake(79.34, 100.84), controlPoint2: CGPointMake(84.8, 102.54))
        bezierPath.addCurveToPoint(CGPointMake(108.87, 94.21), controlPoint1: CGPointMake(99.2, 101.59), controlPoint2: CGPointMake(103.86, 99.53))
        bezierPath.addCurveToPoint(CGPointMake(109.33, 49.25), controlPoint1: CGPointMake(119.91, 82.47), controlPoint2: CGPointMake(120.11, 65.61))
        bezierPath.addCurveToPoint(CGPointMake(97.19, 35.8), controlPoint1: CGPointMake(107.17, 45.94), controlPoint2: CGPointMake(104.16, 42.63))
        bezierPath.addCurveToPoint(CGPointMake(68.3, 5.9), controlPoint1: CGPointMake(79.54, 18.64), controlPoint2: CGPointMake(72.77, 11.62))
        bezierPath.addCurveToPoint(CGPointMake(63.54, 0.02), controlPoint1: CGPointMake(65.9, 2.73), controlPoint2: CGPointMake(63.74, 0.12))
        bezierPath.addCurveToPoint(CGPointMake(60.73, 3.29), controlPoint1: CGPointMake(63.34, -0.03), controlPoint2: CGPointMake(62.09, 1.43))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        fillColor.setFill()
        bezierPath.fill()
    }

    public class func drawHearts() {

        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(88.32, 0.56))
        bezierPath.addCurveToPoint(CGPointMake(72.69, 9.4), controlPoint1: CGPointMake(82.58, 1.92), controlPoint2: CGPointMake(76.61, 5.24))
        bezierPath.addCurveToPoint(CGPointMake(64.17, 25.94), controlPoint1: CGPointMake(68.43, 13.84), controlPoint2: CGPointMake(65.93, 18.76))
        bezierPath.addCurveToPoint(CGPointMake(62.58, 30.51), controlPoint1: CGPointMake(63.43, 28.9), controlPoint2: CGPointMake(62.75, 30.98))
        bezierPath.addCurveToPoint(CGPointMake(61.33, 25.76), controlPoint1: CGPointMake(62.41, 30.03), controlPoint2: CGPointMake(61.89, 27.9))
        bezierPath.addCurveToPoint(CGPointMake(42.57, 2.58), controlPoint1: CGPointMake(58.54, 14.38), controlPoint2: CGPointMake(51.67, 5.9))
        bezierPath.addCurveToPoint(CGPointMake(24.39, 1.69), controlPoint1: CGPointMake(37.74, 0.86), controlPoint2: CGPointMake(29.5, 0.44))
        bezierPath.addCurveToPoint(CGPointMake(1.03, 45.33), controlPoint1: CGPointMake(7.79, 5.78), controlPoint2: CGPointMake(-3.57, 27.07))
        bezierPath.addCurveToPoint(CGPointMake(13.48, 71.36), controlPoint1: CGPointMake(3.13, 53.39), controlPoint2: CGPointMake(8.3, 64.25))
        bezierPath.addCurveToPoint(CGPointMake(36.61, 96.62), controlPoint1: CGPointMake(14.78, 73.2), controlPoint2: CGPointMake(25.18, 84.58))
        bezierPath.addCurveToPoint(CGPointMake(59.62, 121.7), controlPoint1: CGPointMake(48.03, 108.72), controlPoint2: CGPointMake(58.37, 119.99))
        bezierPath.addCurveToPoint(CGPointMake(62.46, 124.61), controlPoint1: CGPointMake(60.87, 123.37), controlPoint2: CGPointMake(62.18, 124.73))
        bezierPath.addCurveToPoint(CGPointMake(67.86, 118.86), controlPoint1: CGPointMake(62.8, 124.55), controlPoint2: CGPointMake(65.25, 121.94))
        bezierPath.addCurveToPoint(CGPointMake(89.8, 95.44), controlPoint1: CGPointMake(70.53, 115.78), controlPoint2: CGPointMake(80.36, 105.22))
        bezierPath.addCurveToPoint(CGPointMake(119.29, 58.14), controlPoint1: CGPointMake(108.84, 75.63), controlPoint2: CGPointMake(114.01, 69.05))
        bezierPath.addCurveToPoint(CGPointMake(123.27, 24.69), controlPoint1: CGPointMake(125.43, 45.27), controlPoint2: CGPointMake(126.62, 35.31))
        bezierPath.addCurveToPoint(CGPointMake(107.13, 3.94), controlPoint1: CGPointMake(120.15, 14.97), controlPoint2: CGPointMake(114.69, 7.97))
        bezierPath.addCurveToPoint(CGPointMake(88.32, 0.56), controlPoint1: CGPointMake(100.43, 0.32), controlPoint2: CGPointMake(94.23, -0.8))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        UIColor.redColor().setFill()
        bezierPath.fill()
    }

    public class func drawClubs() {
        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(52.5, 0.71))
        bezierPath.addCurveToPoint(CGPointMake(29.03, 22.14), controlPoint1: CGPointMake(39.08, 3.1), controlPoint2: CGPointMake(30.89, 10.59))
        bezierPath.addCurveToPoint(CGPointMake(34.82, 43.3), controlPoint1: CGPointMake(27.91, 29.09), controlPoint2: CGPointMake(30.32, 37.77))
        bezierPath.addCurveToPoint(CGPointMake(34.7, 45.09), controlPoint1: CGPointMake(36.95, 45.9), controlPoint2: CGPointMake(36.95, 46.28))
        bezierPath.addCurveToPoint(CGPointMake(26.39, 44.11), controlPoint1: CGPointMake(33.24, 44.33), controlPoint2: CGPointMake(31.5, 44.11))
        bezierPath.addCurveToPoint(CGPointMake(15.55, 46.17), controlPoint1: CGPointMake(20.05, 44.11), controlPoint2: CGPointMake(19.88, 44.17))
        bezierPath.addCurveToPoint(CGPointMake(7.64, 51.6), controlPoint1: CGPointMake(12.58, 47.58), controlPoint2: CGPointMake(10.05, 49.32))
        bezierPath.addCurveToPoint(CGPointMake(0, 72.59), controlPoint1: CGPointMake(1.97, 57.02), controlPoint2: CGPointMake(0, 62.45))
        bezierPath.addCurveToPoint(CGPointMake(7.86, 93.91), controlPoint1: CGPointMake(0, 82.63), controlPoint2: CGPointMake(1.91, 87.78))
        bezierPath.addCurveToPoint(CGPointMake(30.6, 102.97), controlPoint1: CGPointMake(13.7, 99.99), controlPoint2: CGPointMake(21.28, 102.97))
        bezierPath.addCurveToPoint(CGPointMake(51.27, 96.08), controlPoint1: CGPointMake(38.58, 102.97), controlPoint2: CGPointMake(43.58, 101.29))
        bezierPath.addCurveToPoint(CGPointMake(54.36, 94.57), controlPoint1: CGPointMake(52.79, 95.05), controlPoint2: CGPointMake(54.19, 94.35))
        bezierPath.addCurveToPoint(CGPointMake(54.47, 106.17), controlPoint1: CGPointMake(55.09, 95.22), controlPoint2: CGPointMake(55.14, 103.25))
        bezierPath.addCurveToPoint(CGPointMake(46.61, 121.42), controlPoint1: CGPointMake(53.57, 110.24), controlPoint2: CGPointMake(50.03, 117.08))
        bezierPath.addCurveToPoint(CGPointMake(43.8, 125.38), controlPoint1: CGPointMake(45.09, 123.37), controlPoint2: CGPointMake(43.86, 125.11))
        bezierPath.addCurveToPoint(CGPointMake(83, 124.95), controlPoint1: CGPointMake(43.8, 125.7), controlPoint2: CGPointMake(82.55, 125.27))
        bezierPath.addCurveToPoint(CGPointMake(80.02, 120.82), controlPoint1: CGPointMake(83.11, 124.89), controlPoint2: CGPointMake(81.76, 122.99))
        bezierPath.addCurveToPoint(CGPointMake(71.09, 94.46), controlPoint1: CGPointMake(73.11, 111.98), controlPoint2: CGPointMake(69.35, 100.75))
        bezierPath.addCurveToPoint(CGPointMake(74.52, 95.87), controlPoint1: CGPointMake(71.43, 93.32), controlPoint2: CGPointMake(71.6, 93.37))
        bezierPath.addCurveToPoint(CGPointMake(95.07, 102.97), controlPoint1: CGPointMake(80.25, 100.8), controlPoint2: CGPointMake(86.59, 102.97))
        bezierPath.addCurveToPoint(CGPointMake(124.44, 81.17), controlPoint1: CGPointMake(110.79, 102.92), controlPoint2: CGPointMake(121.41, 95.05))
        bezierPath.addCurveToPoint(CGPointMake(125.06, 71.24), controlPoint1: CGPointMake(125.11, 78.29), controlPoint2: CGPointMake(125.28, 75.52))
        bezierPath.addCurveToPoint(CGPointMake(116.52, 51), controlPoint1: CGPointMake(124.55, 61.58), controlPoint2: CGPointMake(122.25, 56.05))
        bezierPath.addCurveToPoint(CGPointMake(86.2, 45.79), controlPoint1: CGPointMake(108.49, 43.9), controlPoint2: CGPointMake(96.19, 41.78))
        bezierPath.addCurveToPoint(CGPointMake(87.15, 43.79), controlPoint1: CGPointMake(85.41, 46.12), controlPoint2: CGPointMake(85.69, 45.52))
        bezierPath.addCurveToPoint(CGPointMake(91.08, 37.55), controlPoint1: CGPointMake(88.33, 42.43), controlPoint2: CGPointMake(90.07, 39.66))
        bezierPath.addCurveToPoint(CGPointMake(90.69, 15.25), controlPoint1: CGPointMake(94.12, 31.26), controlPoint2: CGPointMake(93.95, 22.03))
        bezierPath.addCurveToPoint(CGPointMake(52.5, 0.71), controlPoint1: CGPointMake(85.36, 4.13), controlPoint2: CGPointMake(68.73, -2.22))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;

        fillColor.setFill()
        bezierPath.fill()
    }

    public class func drawCardSymbol(frame frame: CGRect = CGRectMake(0, 0, 125, 125), suiteId: CGFloat = 1) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()


        //// Variable Declarations
        let displayClubs = suiteId == 1
        let displayHearts = suiteId == 2
        let displayDiamonds = suiteId == 3
        let displaySpades = suiteId == 4

        if (displayDiamonds) {
            //// diamondStmb Drawing
            let diamondStmbRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
            CGContextSaveGState(context)
            UIRectClip(diamondStmbRect)
            CGContextTranslateCTM(context, diamondStmbRect.origin.x, diamondStmbRect.origin.y)
            CGContextScaleCTM(context, diamondStmbRect.size.width / 125, diamondStmbRect.size.height / 125)

            CroupierStyleKit.drawDiamonds()
            CGContextRestoreGState(context)
        }


        if (displaySpades) {
            //// spadeSymb Drawing
            let spadeSymbRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
            CGContextSaveGState(context)
            UIRectClip(spadeSymbRect)
            CGContextTranslateCTM(context, spadeSymbRect.origin.x, spadeSymbRect.origin.y)
            CGContextScaleCTM(context, spadeSymbRect.size.width / 125, spadeSymbRect.size.height / 125)

            CroupierStyleKit.drawSpades()
            CGContextRestoreGState(context)
        }


        if (displayHearts) {
            //// heartsSymb Drawing
            let heartsSymbRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
            CGContextSaveGState(context)
            UIRectClip(heartsSymbRect)
            CGContextTranslateCTM(context, heartsSymbRect.origin.x, heartsSymbRect.origin.y)
            CGContextScaleCTM(context, heartsSymbRect.size.width / 125, heartsSymbRect.size.height / 125)

            CroupierStyleKit.drawHearts()
            CGContextRestoreGState(context)
        }


        if (displayClubs) {
            //// clubsSymb Drawing
            let clubsSymbRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
            CGContextSaveGState(context)
            UIRectClip(clubsSymbRect)
            CGContextTranslateCTM(context, clubsSymbRect.origin.x, clubsSymbRect.origin.y)
            CGContextScaleCTM(context, clubsSymbRect.size.width / 125, clubsSymbRect.size.height / 125)

            CroupierStyleKit.drawClubs()
            CGContextRestoreGState(context)
        }
    }

}
