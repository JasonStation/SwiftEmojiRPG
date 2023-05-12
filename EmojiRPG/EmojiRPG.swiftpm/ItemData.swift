import Foundation

struct healthItems: Hashable{
    var itemId: Int
    var itemName: String
    var itemHealing: Int
    var itemCategory: String
    var itemPrice: Int
    
    init(itemId: Int, itemName: String, itemHealing: Int, itemCategory: String, itemPrice: Int) {
        self.itemId = itemId
        self.itemName = itemName
        self.itemHealing = itemHealing
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
    }
}

let healingItem =
[
    healthItems(itemId: 0, itemName: "Empty", itemHealing: 0, itemCategory: "Empty", itemPrice: 0),
    healthItems(itemId: 1, itemName: "🧪 Small Health Potion +25 HP", itemHealing: 25, itemCategory: "Healing", itemPrice: 15),
    healthItems(itemId: 2, itemName: "🥃 Medium Health Potion +50 HP", itemHealing: 50, itemCategory: "Healing", itemPrice: 25),
    healthItems(itemId: 3, itemName: "⚗️ Large Health Potion +100 HP", itemHealing: 100, itemCategory: "Healing", itemPrice: 50)
]

struct armorItems: Hashable{
    var itemId: Int
    var itemName: String
    var itemDefense: Int
    var itemCategory: String
    var itemPrice: Int
    var itemRequiredLevel: Int
    
    init(itemId: Int, itemName: String, itemDefense: Int, itemCategory: String, itemPrice: Int, itemRequiredLevel: Int) {
        self.itemId = itemId
        self.itemName = itemName
        self.itemDefense = itemDefense
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
        self.itemRequiredLevel = itemRequiredLevel
    }
    
}

let armorItem =
[
    armorItems(itemId: 0, itemName: "Empty", itemDefense: 0, itemCategory: "Empty", itemPrice: 0, itemRequiredLevel: 1),
    armorItems(itemId: 1, itemName: "🥿 Flippers SWIM ABILITY", itemDefense: 0, itemCategory: "Armor", itemPrice: 30, itemRequiredLevel: 1),
    armorItems(itemId: 2, itemName: "👕 Wooden Armor +4 DEF", itemDefense: 4, itemCategory: "Armor", itemPrice: 40, itemRequiredLevel: 1),
    armorItems(itemId: 3, itemName: "👕 Ironclad Armor +7 DEF", itemDefense: 7, itemCategory: "Armor", itemPrice: 75, itemRequiredLevel: 2),
    armorItems(itemId: 4, itemName: "👕 Crusader Armor +12 DEF", itemDefense: 12, itemCategory: "Armor", itemPrice: 140, itemRequiredLevel: 3),
    armorItems(itemId: 5, itemName: "👕 Elite Armor +16 DEF", itemDefense: 16, itemCategory: "Armor", itemPrice: 220, itemRequiredLevel: 4),
    armorItems(itemId: 6, itemName: "👕 Legendary Armor +25 DEF", itemDefense: 25, itemCategory: "Armor", itemPrice: 400, itemRequiredLevel: 5)
]

struct attackItems: Hashable{
    var itemId: Int
    var itemName: String
    var itemAttack: Int
    var itemCategory: String
    var itemPrice: Int
    var itemRequiredLevel: Int
    
    init(itemId: Int, itemName: String, itemAttack: Int, itemCategory: String, itemPrice: Int, itemRequiredLevel: Int) {
        self.itemId = itemId
        self.itemName = itemName
        self.itemAttack = itemAttack
        self.itemCategory = itemCategory
        self.itemPrice = itemPrice
        self.itemRequiredLevel = itemRequiredLevel
    }
    
}

let attackItem =
[
    attackItems(itemId: 0, itemName: "Empty", itemAttack: 0, itemCategory: "Empty", itemPrice: 0, itemRequiredLevel: 1),
    attackItems(itemId: 1, itemName: "🗡️ Wooden Sword +4 ATK", itemAttack: 4, itemCategory: "Weapon", itemPrice: 40, itemRequiredLevel: 1),
    attackItems(itemId: 2, itemName: "🗡️ Stone Dagger +7 ATK", itemAttack: 7, itemCategory: "Weapon", itemPrice: 75, itemRequiredLevel: 2),
    attackItems(itemId: 3, itemName: "🗡️ Iron Spear +12 ATK", itemAttack: 12, itemCategory: "Weapon", itemPrice: 140, itemRequiredLevel: 3),
    attackItems(itemId: 4, itemName: "🗡️ Golden Claymore +16 ATK", itemAttack: 16, itemCategory: "Weapon", itemPrice: 220, itemRequiredLevel: 4),
    attackItems(itemId: 5, itemName: "🗡️ Elite Excalibur +22 ATK", itemAttack: 22, itemCategory: "Weapon", itemPrice: 350, itemRequiredLevel: 5),
]

