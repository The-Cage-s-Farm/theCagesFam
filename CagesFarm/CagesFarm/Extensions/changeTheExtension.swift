//
//  changeTheExtension.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/9/21.
//

import Foundation
import UIKit
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}


extension UIScreen {

    static var aspectRatioY: CGFloat  =  UIScreen.main.bounds.height/428
    static var aspectRatioX: CGFloat  =  UIScreen.main.bounds.width/926

}
