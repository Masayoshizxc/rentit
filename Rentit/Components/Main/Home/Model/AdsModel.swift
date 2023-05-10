//
//  AdsModel.swift
//  Rentit
//
//  Created by Adilet on 15/10/22.
//
// swiftlint:disable all
import UIKit

struct AdsView{
    var image : UIImage
    var rate : Double
    var voted : Int
    var name : String
    var price : Int
    var mode : String
    var address : String
    
    static func fetch () -> [AdsView]{
        let firstItem = AdsView(image: UIImage(named: "ads1")!, rate: 4.8,voted: 18, name: "Сдается юрта в аренду", price: 1500, mode: "посуточно", address: "Bishkek, Yunusaliev st.")
        let secondItem = AdsView(image: UIImage(named: "ads2")!, rate: 5.0,voted: 9, name: "Парикмахер. Аренда места", price: 7000, mode: "в месяц", address: "Bishkek, Manas st.")
        let thirdItem = AdsView(image: UIImage(named: "ads1")!, rate: 4.5,voted: 3, name: "Сдается юрта в аренду", price: 1200, mode: "посуточно", address: "Bishkek, Dordoi avenue")
        let fourthItem = AdsView(image: UIImage(named: "ads2")!, rate: 3.9,voted: 10, name: "Парикмахер. Аренда места", price: 9000, mode: "в месяц", address: "Osh, Oshington")
        let fifthItem = AdsView(image: UIImage(named: "ads1")!, rate: 4.7,voted: 19, name: "Сдается юрта в аренду", price: 1350, mode: "посуточно", address: "Gum")
        let sixthItem = AdsView(image: UIImage(named: "ads2")!, rate: 4.2,voted: 8, name: "Парикмахер. Аренда места", price: 8500, mode: "в месяц", address: "Djalal-abad, DJALIWOOD")
        return [firstItem,secondItem,thirdItem,fourthItem,fifthItem,sixthItem]
    }
}
