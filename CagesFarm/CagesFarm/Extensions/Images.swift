//
//  Images.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 4/6/21.
//

import Foundation
import UIKit
import SpriteKit

//swiftlint:disable line_length
public enum ImageExtension: String {
    case png, jpeg, jpg, svg
}
public protocol BundleIdentifiable {
    var bundle: Bundle { get }
}

public enum GlobalImage: String, ImageDescriptor {
    case tonyAstonished,tonyAngry,tonyPensive,tonySmiling,tonyTalkingSprite0,tonyTalkingSprite1,quadro,quartoBackground,quadroPerspectiva,comodaFechada,interruptor,cama,lightSwitchOff,lightSwitchOn,tapeteQuadrado,bau, arrow, door
}

public protocol ImageDescriptor: RawRepresentable where RawValue == String { }

public protocol ImageRetriever {
    associatedtype ImageDescriptorType: ImageDescriptor = GlobalImage
    func image<ImageType: ImageDescriptor>(_ imageName: ImageType) -> UIImage
    func imageUrl<ImageType: ImageDescriptor>(_ imageName: ImageType,
                                              imageExtension: ImageExtension) -> URL?
    
    func image(_ imageName: ImageDescriptorType) -> UIImage
    func imageUrl(_ imageName: ImageDescriptorType, imageExtension: ImageExtension) -> URL?
}

public extension ImageRetriever where Self: BundleIdentifiable {
    func image<ImageType: ImageDescriptor>(_ imageName: ImageType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: bundle, compatibleWith: nil)!
    }
    func imageUrl<ImageType: ImageDescriptor>(_ imageName: ImageType, imageExtension: ImageExtension) -> URL? {
        return bundle.url(forResource: imageName.rawValue, withExtension: imageExtension.rawValue)
    }
    func image(_ imageName: ImageDescriptorType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: bundle, compatibleWith: nil)!
    }
    func imageUrl(_ imageName: ImageDescriptorType, imageExtension: ImageExtension) -> URL? {
        return bundle.url(forResource: imageName.rawValue, withExtension: imageExtension.rawValue)
    }
}

public extension ImageRetriever where Self: AnyObject {
    func image<ImageType: ImageDescriptor>(_ imageName: ImageType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }
    func imageUrl<ImageType: ImageDescriptor>(_ imageName: ImageType, imageExtension: ImageExtension) -> URL? {
        return Bundle(for: type(of: self)).url(forResource: imageName.rawValue, withExtension: imageExtension.rawValue)
    }
    func image(_ imageName: ImageDescriptorType) -> UIImage {
        return UIImage(named: imageName.rawValue, in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }
    func imageUrl(_ imageName: ImageDescriptorType, imageExtension: ImageExtension) -> URL? {
        return Bundle(for: type(of: self)).url(forResource: imageName.rawValue, withExtension: imageExtension.rawValue)
    }
}

public extension ImageRetriever {
    var globalRetriver: GlobalImageRetriever {
        return GlobalImageRetriever()
    }
}

public struct GlobalImageRetriever: ImageRetriever, BundleIdentifiable {
    public var bundle: Bundle {
        return Bundle(for: GameScene.self)
    }
    public init() {}
}
