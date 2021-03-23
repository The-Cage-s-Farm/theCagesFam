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

    func substring(to string: Int) -> String {
        let toIndex = index(from: string)
        return String(self[..<toIndex])
    }

    func substring(with string: Range<Int>) -> String {
        let startIndex = index(from: string.lowerBound)
        let endIndex = index(from: string.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension UIScreen {

    static var aspectRatioY: CGFloat  =  UIScreen.main.bounds.height/428
    static var aspectRatioX: CGFloat  =  UIScreen.main.bounds.width/926

}
