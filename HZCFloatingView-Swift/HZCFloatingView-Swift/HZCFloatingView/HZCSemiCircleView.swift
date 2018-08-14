//
//  HZCSemiCircleView.swift
//  HZCFloatingView-Swift
//
//  Created by Apple on 2018/8/10.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

import UIKit

class HZCSemiCircleView: UIView {

    private lazy var semilLayer:CAShapeLayer = {
        let semilLayer = CAShapeLayer()
        
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width, y: self.frame.height), radius: self.frame.width, startAngle: .pi/2, endAngle: .pi, clockwise: false)
        
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.close()
        semilLayer.path = path.cgPath
        semilLayer.fillColor = UIColor(red: 206.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        
        return semilLayer
    }()
    
    private lazy var imageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "CornerIcon@2x.png")
        imageView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        return imageView
    }()
    
    private lazy var textLabel:UILabel = {
       let textLabel = UILabel(frame: CGRect(x: self.imageView.frame.origin.x, y: self.imageView.frame.maxY, width: self.imageView.frame.width, height: 20))
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.text = "取消浮窗"
        textLabel.textColor = UIColor(red: 234.0/255.0, green: 160.0/255.0, blue: 160.0/255.0, alpha: 1)
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(semilLayer)
        self.addSubview(imageView)
        self.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
