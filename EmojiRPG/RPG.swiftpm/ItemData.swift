import Foundation

struct healthItems: Hashable{
    var itemName: String
    var itemHealing: Int
    var itemCategory: String
    var itemPrice: Int
    
    init(itemName: String, itemHealing: Int, itemCategory: String, itemPrice: Int) {
        self.itemName = itemName
        self.itemHealing = itemHealing
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
    }
}

let healingItem =
[
    healthItems(itemName: "Empty", itemHealing: 0, itemCategory: "Empty", itemPrice: 0),
    healthItems(itemName: "Small Health Potion", itemHealing: 50, itemCategory: "Healing", itemPrice: 20),
    healthItems(itemName: "Medium Health Potion", itemHealing: 100, itemCategory: "Healing", itemPrice: 45),
    healthItems(itemName: "Large Health Potion", itemHealing: 200, itemCategory: "Healing", itemPrice: 90)
]

struct armorItems: Hashable{
    var itemName: String
    var itemDefense: Int
    var itemCategory: String
    var itemPrice: Int
    var isEquipped: Bool
    
    init(itemName: String, itemDefense: Int, itemCategory: String, itemPrice: Int, isEquipped: Bool) {
        self.itemName = itemName
        self.itemDefense = itemDefense
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
        self.isEquipped = isEquipped
    }
    
}

let armorItem =
[
    armorItems(itemName: "Empty", itemDefense: 0, itemCategory: "Empty", itemPrice: 0, isEquipped: false),
    armorItems(itemName: "Wooden Armor", itemDefense: 4, itemCategory: "Armor", itemPrice: 40, isEquipped: false),
    armorItems(itemName: "Ironclad Armor", itemDefense: 7, itemCategory: "Armor", itemPrice: 75, isEquipped: false),
    armorItems(itemName: "Crusader Armor", itemDefense: 12, itemCategory: "Armor", itemPrice: 140, isEquipped: false)
]

struct attackItems: Hashable{
    var itemName: String
    var itemAttack: Int
    var itemCategory: String
    var itemPrice: Int
    var isEquipped: Bool
    
    init(itemName: String, itemAttack: Int, itemCategory: String, itemPrice: Int, isEquipped: Bool) {
        self.itemName = itemName
        self.itemAttack = itemAttack
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
        self.isEquipped = isEquipped
    }
    
}

let attackItem =
[
    attackItems(itemName: "Empty", itemAttack: 0, itemCategory: "Empty", itemPrice: 0, isEquipped: false),
    attackItems(itemName: "Wooden Sword", itemAttack: 4, itemCategory: "Weapon", itemPrice: 40, isEquipped: false),
    attackItems(itemName: "Stone Dagger", itemAttack: 7, itemCategory: "Weapon", itemPrice: 75, isEquipped: false),
    attackItems(itemName: "Iron Spear", itemAttack: 12, itemCategory: "Weapon", itemPrice: 140, isEquipped: false)
]

