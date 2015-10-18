//
//  StyleKit.swift
//  SpinningShots
//
//  Created by Marc Zobec on 2015-10-18.
//  Copyright (c) 2015 . All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class StyleKit : NSObject {

    //// Drawing Methods

    public class func drawCannon(frame frame: CGRect = CGRectMake(0, 0, 80, 100), cannonColor: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000), cannonStrokeColor: UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)) {

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.83199 * frame.width, frame.minY + 0.20600 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98750 * frame.width, frame.minY + 0.59800 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.92766 * frame.width, frame.minY + 0.32877 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98750 * frame.width, frame.minY + 0.48464 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.99000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98750 * frame.width, frame.minY + 0.81450 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.76924 * frame.width, frame.minY + 0.99000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01250 * frame.width, frame.minY + 0.59800 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.23076 * frame.width, frame.minY + 0.99000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01250 * frame.width, frame.minY + 0.81450 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.16801 * frame.width, frame.minY + 0.20600 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01250 * frame.width, frame.minY + 0.48464 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.07234 * frame.width, frame.minY + 0.32877 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.13450 * frame.width, frame.minY + 0.20600 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.01250 * frame.width, frame.minY + 0.10800 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.06712 * frame.width, frame.minY + 0.20600 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.01250 * frame.width, frame.minY + 0.16201 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.13450 * frame.width, frame.minY + 0.01000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.01250 * frame.width, frame.minY + 0.05388 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.06701 * frame.width, frame.minY + 0.01000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.86550 * frame.width, frame.minY + 0.01000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.98750 * frame.width, frame.minY + 0.10800 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.93288 * frame.width, frame.minY + 0.01000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.98750 * frame.width, frame.minY + 0.05399 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.86550 * frame.width, frame.minY + 0.20600 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.98750 * frame.width, frame.minY + 0.16212 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.93299 * frame.width, frame.minY + 0.20600 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.83199 * frame.width, frame.minY + 0.20600 * frame.height))
        bezierPath.closePath()
        bezierPath.usesEvenOddFillRule = true;

        cannonColor.setFill()
        bezierPath.fill()
        cannonStrokeColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
    }

    public class func drawBullet(frame frame: CGRect = CGRectMake(0, 0, 25, 100), bulletColor: UIColor = UIColor(red: 0.500, green: 0.500, blue: 0.500, alpha: 1.000)) {

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.91667 * frame.width, frame.minY + 0.84746 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.91667 * frame.width, frame.minY + 0.71187 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.71187 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.35488 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.66666 * frame.width, frame.minY + 0.00000 * frame.height), controlPoint1: CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.29607 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77709 * frame.width, frame.minY + 0.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.33332 * frame.width, frame.minY + 0.00000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.35488 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.22288 * frame.width, frame.minY + 0.00000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.29607 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.71187 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.08333 * frame.width, frame.minY + 0.71187 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.08333 * frame.width, frame.minY + 0.84746 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.84746 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 1.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 1.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.84746 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.91667 * frame.width, frame.minY + 0.84746 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.91667 * frame.width, frame.minY + 0.84746 * frame.height))
        bezierPath.closePath()
        bezierPath.usesEvenOddFillRule = true;

        bulletColor.setFill()
        bezierPath.fill()
    }

    public class func drawPlayButton(buttonFillColor buttonFillColor: UIColor = UIColor(red: 0.788, green: 0.839, blue: 0.875, alpha: 1.000), buttonStrokeColor: UIColor = UIColor(red: 0.322, green: 0.380, blue: 0.420, alpha: 1.000), buttonFrameDiameter: CGFloat = 100) {

        //// Variable Declarations
        let buttonStrokeWidth: CGFloat = buttonFrameDiameter * 0.02
        let buttonOffset: CGFloat = buttonStrokeWidth / 2.0
        let realButtonStrokeWidth: CGFloat = buttonStrokeWidth * 0.6
        let buttonDiameter: CGFloat = buttonFrameDiameter - buttonStrokeWidth

        //// Frames
        let frame = CGRectMake(0, 0, buttonFrameDiameter, buttonFrameDiameter)


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(buttonOffset, buttonOffset, buttonDiameter, buttonDiameter))
        buttonFillColor.setFill()
        ovalPath.fill()
        buttonStrokeColor.setStroke()
        ovalPath.lineWidth = realButtonStrokeWidth
        ovalPath.stroke()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.33000 * frame.width, frame.minY + 0.82000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.33000 * frame.width, frame.minY + 0.18000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.81000 * frame.width, frame.minY + 0.50000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.33000 * frame.width, frame.minY + 0.82000 * frame.height))
        bezierPath.closePath()
        bezierPath.usesEvenOddFillRule = true;

        buttonStrokeColor.setFill()
        bezierPath.fill()
    }

    public class func drawHomeButton(buttonFillColor buttonFillColor: UIColor = UIColor(red: 0.788, green: 0.839, blue: 0.875, alpha: 1.000), buttonStrokeColor: UIColor = UIColor(red: 0.322, green: 0.380, blue: 0.420, alpha: 1.000), buttonFrameDiameter: CGFloat = 100) {

        //// Variable Declarations
        let buttonStrokeWidth: CGFloat = buttonFrameDiameter * 0.02
        let buttonOffset: CGFloat = buttonStrokeWidth / 2.0
        let realButtonStrokeWidth: CGFloat = buttonStrokeWidth * 0.6
        let buttonDiameter: CGFloat = buttonFrameDiameter - buttonStrokeWidth

        //// Frames
        let frame = CGRectMake(0, 0, buttonFrameDiameter, buttonFrameDiameter)


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(buttonOffset, buttonOffset, buttonDiameter, buttonDiameter))
        buttonFillColor.setFill()
        ovalPath.fill()
        buttonStrokeColor.setStroke()
        ovalPath.lineWidth = realButtonStrokeWidth
        ovalPath.stroke()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.72469 * frame.width, frame.minY + 0.34389 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.73433 * frame.width, frame.minY + 0.34787 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72731 * frame.width, frame.minY + 0.34648 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.73079 * frame.width, frame.minY + 0.34787 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.74794 * frame.width, frame.minY + 0.33425 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.74182 * frame.width, frame.minY + 0.34787 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.74794 * frame.width, frame.minY + 0.34177 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.74794 * frame.width, frame.minY + 0.21173 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.73433 * frame.width, frame.minY + 0.19811 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.74794 * frame.width, frame.minY + 0.20421 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.74184 * frame.width, frame.minY + 0.19811 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.61183 * frame.width, frame.minY + 0.19811 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.59925 * frame.width, frame.minY + 0.20653 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.60633 * frame.width, frame.minY + 0.19811 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.60135 * frame.width, frame.minY + 0.20143 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.60219 * frame.width, frame.minY + 0.22134 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.59713 * frame.width, frame.minY + 0.21159 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.59830 * frame.width, frame.minY + 0.21744 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72469 * frame.width, frame.minY + 0.34389 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.72469 * frame.width, frame.minY + 0.34389 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.25390 * frame.width, frame.minY + 0.49236 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.25390 * frame.width, frame.minY + 0.80219 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.44446 * frame.width, frame.minY + 0.80219 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.44446 * frame.width, frame.minY + 0.61159 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.55335 * frame.width, frame.minY + 0.61159 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.55335 * frame.width, frame.minY + 0.80219 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.74391 * frame.width, frame.minY + 0.80219 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.74391 * frame.width, frame.minY + 0.49236 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.49891 * frame.width, frame.minY + 0.24731 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.25390 * frame.width, frame.minY + 0.49236 * frame.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.82626 * frame.width, frame.minY + 0.48748 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.82599 * frame.width, frame.minY + 0.48704 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.51292 * frame.width, frame.minY + 0.17392 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.49368 * frame.width, frame.minY + 0.17392 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.50772 * frame.width, frame.minY + 0.16869 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.49888 * frame.width, frame.minY + 0.16869 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.18061 * frame.width, frame.minY + 0.48704 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.18032 * frame.width, frame.minY + 0.50586 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.17569 * frame.width, frame.minY + 0.49197 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.17498 * frame.width, frame.minY + 0.50008 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.19967 * frame.width, frame.minY + 0.50637 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.18649 * frame.width, frame.minY + 0.51204 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.19480 * frame.width, frame.minY + 0.51114 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.19986 * frame.width, frame.minY + 0.50629 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.50331 * frame.width, frame.minY + 0.20281 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80674 * frame.width, frame.minY + 0.50632 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.80690 * frame.width, frame.minY + 0.50640 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.82580 * frame.width, frame.minY + 0.50640 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.81208 * frame.width, frame.minY + 0.51144 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.82065 * frame.width, frame.minY + 0.51144 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.82599 * frame.width, frame.minY + 0.50632 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.82626 * frame.width, frame.minY + 0.48748 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.83094 * frame.width, frame.minY + 0.50136 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.83162 * frame.width, frame.minY + 0.49314 * frame.height))
        bezierPath.closePath()
        bezierPath.usesEvenOddFillRule = true;

        buttonStrokeColor.setFill()
        bezierPath.fill()
    }

    public class func drawShareButton(buttonFillColor buttonFillColor: UIColor = UIColor(red: 0.788, green: 0.839, blue: 0.875, alpha: 1.000), buttonStrokeColor: UIColor = UIColor(red: 0.322, green: 0.380, blue: 0.420, alpha: 1.000), buttonFrameDiameter: CGFloat = 100) {

        //// Variable Declarations
        let buttonStrokeWidth: CGFloat = buttonFrameDiameter * 0.02
        let buttonOffset: CGFloat = buttonStrokeWidth / 2.0
        let realButtonStrokeWidth: CGFloat = buttonStrokeWidth * 0.6
        let buttonDiameter: CGFloat = buttonFrameDiameter - buttonStrokeWidth

        //// Frames
        let frame = CGRectMake(0, 0, buttonFrameDiameter, buttonFrameDiameter)


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(buttonOffset, buttonOffset, buttonDiameter, buttonDiameter))
        buttonFillColor.setFill()
        ovalPath.fill()
        buttonStrokeColor.setStroke()
        ovalPath.lineWidth = realButtonStrokeWidth
        ovalPath.stroke()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.56086 * frame.width, frame.minY + 0.63356 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.35199 * frame.width, frame.minY + 0.52732 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.35669 * frame.width, frame.minY + 0.49566 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.35472 * frame.width, frame.minY + 0.51717 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35669 * frame.width, frame.minY + 0.50669 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.35110 * frame.width, frame.minY + 0.46135 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.35669 * frame.width, frame.minY + 0.48365 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.35435 * frame.width, frame.minY + 0.47235 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.55905 * frame.width, frame.minY + 0.35559 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.65696 * frame.width, frame.minY + 0.40461 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58145 * frame.width, frame.minY + 0.38523 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.61681 * frame.width, frame.minY + 0.40461 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.78000 * frame.width, frame.minY + 0.28229 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72498 * frame.width, frame.minY + 0.40461 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.78000 * frame.width, frame.minY + 0.34988 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.65696 * frame.width, frame.minY + 0.16000 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.78000 * frame.width, frame.minY + 0.21476 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72498 * frame.width, frame.minY + 0.16000 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.53401 * frame.width, frame.minY + 0.28229 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.58910 * frame.width, frame.minY + 0.16000 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.53401 * frame.width, frame.minY + 0.21476 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.53875 * frame.width, frame.minY + 0.31403 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.53401 * frame.width, frame.minY + 0.29335 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.53598 * frame.width, frame.minY + 0.30386 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.32990 * frame.width, frame.minY + 0.42028 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.23368 * frame.width, frame.minY + 0.37331 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.30735 * frame.width, frame.minY + 0.39189 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.27282 * frame.width, frame.minY + 0.37331 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.11073 * frame.width, frame.minY + 0.49566 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.16572 * frame.width, frame.minY + 0.37331 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.11073 * frame.width, frame.minY + 0.42810 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.23368 * frame.width, frame.minY + 0.61798 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.11073 * frame.width, frame.minY + 0.56322 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.16572 * frame.width, frame.minY + 0.61798 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.33171 * frame.width, frame.minY + 0.56888 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.27389 * frame.width, frame.minY + 0.61798 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.30922 * frame.width, frame.minY + 0.59855 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.53957 * frame.width, frame.minY + 0.67463 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.53395 * frame.width, frame.minY + 0.70904 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.53632 * frame.width, frame.minY + 0.68560 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.53395 * frame.width, frame.minY + 0.69700 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.65690 * frame.width, frame.minY + 0.83136 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.53395 * frame.width, frame.minY + 0.77660 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58903 * frame.width, frame.minY + 0.83136 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.77994 * frame.width, frame.minY + 0.70904 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.72492 * frame.width, frame.minY + 0.83136 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.77994 * frame.width, frame.minY + 0.77660 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.65693 * frame.width, frame.minY + 0.58669 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.77997 * frame.width, frame.minY + 0.64142 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.72495 * frame.width, frame.minY + 0.58669 * frame.height))
        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.56086 * frame.width, frame.minY + 0.63356 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.61785 * frame.width, frame.minY + 0.58669 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.58338 * frame.width, frame.minY + 0.60521 * frame.height))
        bezierPath.closePath()
        bezierPath.usesEvenOddFillRule = true;

        buttonStrokeColor.setFill()
        bezierPath.fill()
    }

    public class func drawGameCenterButton(buttonFillColor buttonFillColor: UIColor = UIColor(red: 0.788, green: 0.839, blue: 0.875, alpha: 1.000), buttonStrokeColor: UIColor = UIColor(red: 0.322, green: 0.380, blue: 0.420, alpha: 1.000), buttonFrameDiameter: CGFloat = 100) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()


        //// Variable Declarations
        let buttonStrokeWidth: CGFloat = buttonFrameDiameter * 0.02
        let buttonOffset: CGFloat = buttonStrokeWidth / 2.0
        let realButtonStrokeWidth: CGFloat = buttonStrokeWidth * 0.6
        let buttonDiameter: CGFloat = buttonFrameDiameter - buttonStrokeWidth

        //// Frames
        let frame = CGRectMake(0, 0, buttonFrameDiameter, buttonFrameDiameter)

        //// Subframes
        let group3: CGRect = CGRectMake(frame.minX + floor(frame.width * 0.22115 + 0.38) + 0.12, frame.minY + floor(frame.height * 0.14787 - 0.29) + 0.79, floor(frame.width * 0.77885 - 0.38) - floor(frame.width * 0.22115 + 0.38) + 0.77, floor(frame.height * 0.85213 + 0.29) - floor(frame.height * 0.14787 - 0.29) - 0.57)


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(buttonOffset, buttonOffset, buttonDiameter, buttonDiameter))
        buttonFillColor.setFill()
        ovalPath.fill()
        buttonStrokeColor.setStroke()
        ovalPath.lineWidth = realButtonStrokeWidth
        ovalPath.stroke()


        //// Group 3
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip
        let clipPath = UIBezierPath()
        clipPath.moveToPoint(CGPointMake(group3.minX + 0.81246 * group3.width, group3.minY + 0.62339 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.67373 * group3.width, group3.minY + 0.68335 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.67716 * group3.width, group3.minY + 0.63488 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.70468 * group3.width, group3.minY + 0.66216 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.59366 * group3.width, group3.minY + 0.70814 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.63813 * group3.width, group3.minY + 0.71419 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.59366 * group3.width, group3.minY + 0.70814 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.80254 * group3.width, group3.minY + 1.00000 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.85392 * group3.width, group3.minY + 0.89192 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 1.00000 * group3.width, group3.minY + 0.90740 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.81246 * group3.width, group3.minY + 0.62339 * group3.height))
        clipPath.closePath()
        clipPath.moveToPoint(CGPointMake(group3.minX + 0.65503 * group3.width, group3.minY + 0.65111 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.75728 * group3.width, group3.minY + 0.60320 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.67816 * group3.width, group3.minY + 0.61972 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.71218 * group3.width, group3.minY + 0.60363 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.82588 * group3.width, group3.minY + 0.54740 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.80238 * group3.width, group3.minY + 0.60278 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.82514 * group3.width, group3.minY + 0.58412 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.88476 * group3.width, group3.minY + 0.46454 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.82651 * group3.width, group3.minY + 0.51086 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.84611 * group3.width, group3.minY + 0.48324 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.90985 * group3.width, group3.minY + 0.38850 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.92353 * group3.width, group3.minY + 0.44576 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.93193 * group3.width, group3.minY + 0.42050 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.90985 * group3.width, group3.minY + 0.29269 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.88788 * group3.width, group3.minY + 0.35659 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.88788 * group3.width, group3.minY + 0.32468 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.88476 * group3.width, group3.minY + 0.21677 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.93193 * group3.width, group3.minY + 0.26078 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.92358 * group3.width, group3.minY + 0.23556 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.82588 * group3.width, group3.minY + 0.13365 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.84611 * group3.width, group3.minY + 0.19794 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.82646 * group3.width, group3.minY + 0.17037 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.75728 * group3.width, group3.minY + 0.07802 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.82514 * group3.width, group3.minY + 0.09711 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.80238 * group3.width, group3.minY + 0.07845 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.65503 * group3.width, group3.minY + 0.03012 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.71218 * group3.width, group3.minY + 0.07751 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.67816 * group3.width, group3.minY + 0.06151 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.56150 * group3.width, group3.minY + 0.00974 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.63190 * group3.width, group3.minY + -0.00136 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.60079 * group3.width, group3.minY + -0.00818 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.44352 * group3.width, group3.minY + 0.00974 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.52221 * group3.width, group3.minY + 0.02759 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.48281 * group3.width, group3.minY + 0.02759 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.34994 * group3.width, group3.minY + 0.03012 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.40418 * group3.width, group3.minY + -0.00814 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.37307 * group3.width, group3.minY + -0.00136 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.24775 * group3.width, group3.minY + 0.07802 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.32686 * group3.width, group3.minY + 0.06155 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.29279 * group3.width, group3.minY + 0.07755 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.17925 * group3.width, group3.minY + 0.13365 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.20275 * group3.width, group3.minY + 0.07845 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.17988 * group3.width, group3.minY + 0.09711 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.12026 * group3.width, group3.minY + 0.21677 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.17851 * group3.width, group3.minY + 0.17037 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.15892 * group3.width, group3.minY + 0.19790 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.09517 * group3.width, group3.minY + 0.29269 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.08149 * group3.width, group3.minY + 0.23556 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.07299 * group3.width, group3.minY + 0.26073 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.09517 * group3.width, group3.minY + 0.38850 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.11725 * group3.width, group3.minY + 0.32468 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.11725 * group3.width, group3.minY + 0.35659 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.12026 * group3.width, group3.minY + 0.46454 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.07299 * group3.width, group3.minY + 0.42050 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.08144 * group3.width, group3.minY + 0.44580 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.17925 * group3.width, group3.minY + 0.54740 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.15892 * group3.width, group3.minY + 0.48324 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.17856 * group3.width, group3.minY + 0.51086 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.24775 * group3.width, group3.minY + 0.60320 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.17988 * group3.width, group3.minY + 0.58408 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.20275 * group3.width, group3.minY + 0.60278 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.34999 * group3.width, group3.minY + 0.65111 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.29285 * group3.width, group3.minY + 0.60363 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.32686 * group3.width, group3.minY + 0.61972 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.44352 * group3.width, group3.minY + 0.67140 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.37312 * group3.width, group3.minY + 0.68259 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.40423 * group3.width, group3.minY + 0.68941 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.56150 * group3.width, group3.minY + 0.67140 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.48281 * group3.width, group3.minY + 0.65373 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.52221 * group3.width, group3.minY + 0.65373 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.65503 * group3.width, group3.minY + 0.65111 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.60079 * group3.width, group3.minY + 0.68937 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.63195 * group3.width, group3.minY + 0.68259 * group3.height))
        clipPath.closePath()
        clipPath.moveToPoint(CGPointMake(group3.minX + 0.23897 * group3.width, group3.minY + 0.63173 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.18521 * group3.width, group3.minY + 0.61380 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.19155 * group3.width, group3.minY + 0.63173 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.18521 * group3.width, group3.minY + 0.61380 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.00000 * group3.width, group3.minY + 0.90943 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.14851 * group3.width, group3.minY + 0.89588 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.23063 * group3.width, group3.minY + 0.99624 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.40174 * group3.width, group3.minY + 0.70824 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.23063 * group3.width, group3.minY + 0.99624 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.40174 * group3.width, group3.minY + 0.70631 * group3.height))
        clipPath.addCurveToPoint(CGPointMake(group3.minX + 0.23897 * group3.width, group3.minY + 0.63173 * group3.height), controlPoint1: CGPointMake(group3.minX + 0.31307 * group3.width, group3.minY + 0.70644 * group3.height), controlPoint2: CGPointMake(group3.minX + 0.34835 * group3.width, group3.minY + 0.63366 * group3.height))
        clipPath.closePath()
        clipPath.moveToPoint(CGPointMake(group3.minX + 0.55141 * group3.width, group3.minY + 0.29591 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.49976 * group3.width, group3.minY + 0.21099 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.44806 * group3.width, group3.minY + 0.29591 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.33245 * group3.width, group3.minY + 0.30964 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.41600 * group3.width, group3.minY + 0.37582 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.39630 * group3.width, group3.minY + 0.46940 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.49976 * group3.width, group3.minY + 0.42527 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.60322 * group3.width, group3.minY + 0.46940 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.58352 * group3.width, group3.minY + 0.37582 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.66707 * group3.width, group3.minY + 0.30964 * group3.height))
        clipPath.addLineToPoint(CGPointMake(group3.minX + 0.55141 * group3.width, group3.minY + 0.29591 * group3.height))
        clipPath.closePath()
        clipPath.usesEvenOddFillRule = true;

        clipPath.addClip()


        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(group3.minX + floor(group3.width * -0.10741 + 0.49) + 0.01, group3.minY + floor(group3.height * -0.08537 - 0.49) + 0.99, floor(group3.width * 1.10741 - 0.26) - floor(group3.width * -0.10741 + 0.49) + 0.75, floor(group3.height * 1.08537 + 0.06) - floor(group3.height * -0.08537 - 0.49) - 0.55))
        buttonStrokeColor.setFill()
        rectanglePath.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }

}
