//
//  CollectionViewCell.swift
//  Rentit
//
//  Created by Adilet on 14/10/22.
//

import UIKit

struct HomeeViewModel {
    var colors = [UIColor.gray, UIColor.systemBlue, UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    
}
struct KategoryCell {
    var image : UIImage
    var name : String
    var background : UIColor
    
    static func forFetch() -> [KategoryCell] {
        let firstItem = KategoryCell(image: UIImage(named: "allK")!, name: "Все", background: UIColor.kategoryGray)
        let secondItem = KategoryCell(image: UIImage(named: "homeK")!, name: "Недвижимость", background: UIColor.kategoryBiruse)
        let thirdItem = KategoryCell(image: UIImage(named: "carK")!, name: "Транспорт", background: UIColor.kategoryRed)
        let fourthItem = KategoryCell(image: UIImage(named: "teleK")!, name: "Электроника", background: UIColor.kategoryBlue)
        let fifthItem = KategoryCell(image: UIImage(named: "plantK")!, name: "Дом и сад", background: UIColor.kategoryGreen)
        let sixthItem = KategoryCell(image: UIImage(named: "serviceK")!, name: "Услуги", background: UIColor.kategoryYellow)
        let seventhItem = KategoryCell(image: UIImage(named: "printerK")!, name: "Оборудование", background: UIColor(red: 0, green: 0.353, blue: 0.767, alpha: 1))
        let eigthItem = KategoryCell(image: UIImage(named: "shirtK")!, name: "Личные вещи", background: UIColor(red: 1, green: 0.54, blue: 0, alpha: 1))
        let ninethItem = KategoryCell(image: UIImage(named: "bookK")!, name: "Спорт и хобби", background: UIColor(red: 0.467, green: 0.788, blue: 0.316, alpha: 1))
//        let tenthItem = KategoryCell(image: UIImage(named: "childK")!, name: "Десткий мир", background: UIColor(red: 1, green: 0.139, blue: 0.604, alpha: 1))
        let eleventhItem = KategoryCell(image: UIImage(named: "medicineK")!, name: "Медтовары", background: UIColor(red: 0.396, green: 0.392, blue: 0.859, alpha: 1))
        return [firstItem, secondItem, thirdItem, fourthItem, fifthItem, sixthItem, seventhItem, eigthItem, ninethItem, eleventhItem]
    }
}
