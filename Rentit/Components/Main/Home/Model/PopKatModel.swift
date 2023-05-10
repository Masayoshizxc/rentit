//
//  PopKatModel.swift
//  Rentit
//
//  Created by Adilet on 9/11/22.
//
// swiftlint:disable all

import UIKit

struct imagesForCollection {
    var image : UIImage
    
    static func fetch() -> [imagesForCollection]{
        let flats = imagesForCollection(image: R.image.popkat1()!)
        let cars = imagesForCollection(image: UIImage(named: "popKat2")!)
        let laptops = imagesForCollection(image: UIImage(named: "popKat3")!)
        return [flats,cars,laptops]
    }
}
