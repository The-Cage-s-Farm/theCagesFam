//
//  UIFontsExtension.swift
//  CagesFarm
//
//  Created by Tales Conrado on 15/03/21.
//

import UIKit

extension UIFont {
    
    class func pixel(_ size: CGFloat) -> UIFont {
        return UIFont(name: "pixel", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func pixeland(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Pixeland", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func pixelPlay(_ size: CGFloat) -> UIFont {
        return UIFont(name: "PixelPlay", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func dogica(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Dogica", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func dogicaBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Dogica_bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func dogicaPixel(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Dogica_Pixel", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
