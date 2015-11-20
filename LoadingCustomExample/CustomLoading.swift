//
//  CustomLoading.swift
//
//  Classe para criar o loading e controlá-lo.
//
//  Created by Renato Mendes on 29/07/15.
//  Copyright © 2015 Renato Mendes. All rights reserved.
//

import UIKit

class CustomLoading {
    
    // MARK: Private vars
    
    private let backgroundColor : UIColor!
    private let fade : NSTimeInterval!
    private var red, green, blue : CGFloat!
    private var indicator : UIView!
    private var animation : CABasicAnimation!
    
    // MARK: Construct method
    
    //|------------------------------------------------------
    //| Método construtor para definir a cor do loading.
    init(red: Double, green: Double, blue: Double) {
        self.red   = CGFloat(red/255.0)
        self.green = CGFloat(green/255.0)
        self.blue  = CGFloat(blue/255.0)
        
        self.backgroundColor = UIColor(red: self.red, green: self.green, blue: self.blue, alpha: 0.8)
        self.fade = 0.1
        
        self.indicator = createIndicator()
        self.animation = createAnimation()
    }
    
    // MARK: Private methods
    
    //|------------------------------------------------------
    //| Cria uma view quadrada para a animação.
    func createIndicator() -> UIView {
        let view = UIView()
        let screen: CGRect = UIScreen.mainScreen().bounds
        let side = screen.width / 4
        let x = (screen.width / 2) - (side / 2)
        let y = (screen.height / 2) - (side / 2)
        
        view.frame = CGRect(x: x, y: y, width: side, height: side)
        view.backgroundColor = self.backgroundColor
        view.layer.cornerRadius = 10
        view.alpha = 0.0
        view.tag = 1
        
        let image = UIImage(named: "spinner.png")
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: side / 4, y: side / 4, width: side / 2, height: side / 2)
        view.addSubview(imageView)
        
        return view
    }
    
    //|------------------------------------------------------
    //| Cria uma animação de rotação para a imagem
    func createAnimation() -> CABasicAnimation {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = 2.0
        rotateAnimation.repeatCount = Float.infinity
        
        return rotateAnimation
    }
    
    
    // MARK: Access methods
    
    //|------------------------------------------------------
    //| Método de acesso para iniciar o loading com animação.
    func start() {
        if let window :UIWindow = UIApplication.sharedApplication().keyWindow {
            var found: Bool = false
            for subview in window.subviews {
                if subview.tag == 1 {
                    found = true
                }
            }
            if !found {
                for subview in self.indicator.subviews {
                    subview.layer.addAnimation(self.animation, forKey: nil)
                }
                window.addSubview(self.indicator)
                
                UIView.animateWithDuration(self.fade, animations: {
                    self.indicator.alpha = 1.0
                })
            }
            
        }
    }
    
    //|------------------------------------------------------
    //| Método de acesso para parar o loading com animação.
    func stop() {
        UIView.animateWithDuration(self.fade, animations: {
            self.indicator.alpha = 0.0
            }, completion: { (value: Bool) in
                self.indicator.removeFromSuperview()
                for subview in self.indicator.subviews {
                    subview.layer.removeAllAnimations()
                }
        })
    }
    
}
