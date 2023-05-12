import SwiftUI

struct InventoryView: View {
    
    @Binding var visibleInventory: Bool
    @Binding var dropMode: Bool
    @Binding var inventoryMenu: Int
    @Binding var healthPocket: [healthItems]
    @Binding var weaponPocket: [attackItems]
    @Binding var armorPocket: [armorItems]
    @Binding var equippedWeapon: attackItems
    @Binding var equippedArmor: armorItems
    
    @Binding var playerHealth: Int
    @Binding var playerMaxHealth: Int
    @Binding var playerDef: Int
    @Binding var playerAtk: Int
    
    @Binding var visiblePlot: Bool
    @Binding var visibleControls: Bool
    
    @Binding var inBattle: Bool
    @Binding var battleScreen: Bool
    
    @State private var modeText = "Drop"
    
    var body: some View{
        if visibleInventory{
            VStack{
                VStack{
                    HStack{
                        Button(action: {
                            inventoryMenu = 0
                        }) {
                            Text("Health")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                        
                        Button(action: {
                            inventoryMenu = 1
                        }) {
                            Text("Weapons")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                        
                        Button(action: {
                            inventoryMenu = 2
                        }) {
                            Text("Armor")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                        
                        
                    }
                    
                    
                    if(inventoryMenu == 0){
                        VStack {
                            Text("Health Items").font(.system(size: 16, weight: .bold, design: .monospaced)).padding()
                            ForEach(healthPocket.indices, id: \.self) { pos in
                                Button(action: {
                                    print("\(healthPocket[pos].itemName) tapped")
                                    if(!dropMode){
                                        useItem(itemPos: pos, itemIndex: healthPocket[pos].itemId, itemCategory: 0)
                                    }
                                    else{
                                        dropItem(itemPos: pos, itemCategory: 0)
                                    }
                                }, label: {
                                    Text(healthPocket[pos].itemName)
                                        .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                    
                                })
                                
                            }
                        }
                    }
                    else if(inventoryMenu == 1){
                        VStack {
                            Text("Weapons").font(.system(size: 16, weight: .bold, design: .monospaced))
                            Text("Equipped: \(equippedWeapon.itemName)").font(.system(size: 16, weight: .regular, design: .monospaced))
                            ForEach(weaponPocket.indices, id: \.self) { pos in
                                Button(action: {
                                    if(!dropMode){
                                        useItem(itemPos: pos, itemIndex: weaponPocket[pos].itemId, itemCategory: 1)
                                    }
                                    else{
                                        dropItem(itemPos: pos, itemCategory: 1)
                                    }
                                }, label: {
                                    if(equippedWeapon.itemName == weaponPocket[pos].itemName && weaponPocket[pos].itemName != "Empty"){
                                        Text("\(weaponPocket[pos].itemName) (EQUIPPED)")
                                            .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                    }else{
                                        Text(weaponPocket[pos].itemName)
                                            .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                    }
                                    
                                })
                                
                            }
                        }
                    }else{
                        VStack {
                            Text("Armor").font(.system(size: 16, weight: .bold, design: .monospaced))
                            Text("Equipped: \(equippedArmor.itemName)").font(.system(size: 16, weight: .regular, design: .monospaced))
                            ForEach(armorPocket.indices, id: \.self) { pos in
                                Button(action: {
                                    print("\(armorPocket[pos].itemName) tapped")
                                    if(!dropMode){
                                        useItem(itemPos: pos, itemIndex: armorPocket[pos].itemId, itemCategory: 2)
                                    }
                                    else{
                                        dropItem(itemPos: pos, itemCategory: 2)
                                    }
                                }, label: {
                                    if(equippedArmor.itemName == armorPocket[pos].itemName && armorPocket[pos].itemName != "Empty"){
                                        Text("\(armorPocket[pos].itemName) (EQUIPPED)")
                                            .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                    }else{
                                        Text(armorPocket[pos].itemName)
                                            .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                    }
                                    
                                })
                                
                            }
                        }
                    }
                }.padding()
                if(!dropMode){
                    Text("[Use Item] Tap an item to use it.")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                    
                    HStack{
                        Text("You can tap an equipped weapon/armor to unequip it.")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                    }
                }
                else{
                    Text("[Drop Item] Tap an item to discard it.")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                    
                    HStack{
                        Text("Unequip weapon/armor first to be able to drop it.")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                    }
                }
                
                HStack{
                    Text("HP: \(playerHealth)/\(playerMaxHealth)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                    Text("ATK: \(playerAtk)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                    Text("DEF: \(playerDef)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                }
                HStack{
                    Button(action: {
                        closeInventory()
                    }) {
                        Text("< Back")
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.white) 
                    }.padding()
                    
                    Button(action: {
                        if(!dropMode){
                            modeText = "Use"
                            dropMode = true
                        }else{
                            modeText = "Drop"
                            dropMode = false
                        }
                    }) {
                        Text("\(modeText)")
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.white) 
                    }.padding()
                    
                }
            }
        }
    }
    
    func useItem(itemPos: Int, itemIndex: Int, itemCategory: Int){
        if(itemCategory == 0){
            if(playerHealth + healingItem[itemIndex].itemHealing <= playerMaxHealth){
                playerHealth += healingItem[itemIndex].itemHealing
            }else{
                playerHealth = playerMaxHealth
            }
            healthPocket[itemPos] = healingItem[0]
            
        }
        else if(itemCategory == 1 && weaponPocket[itemPos].itemName != "Empty"){
            if(weaponPocket[itemPos].itemName == equippedWeapon.itemName){
                playerAtk -= equippedWeapon.itemAttack
                equippedWeapon = attackItem[0]
            }else{
                playerAtk -= equippedWeapon.itemAttack
                equippedWeapon = weaponPocket[itemPos]
                playerAtk += equippedWeapon.itemAttack
                
            }
            print("Player atk: \(playerAtk)")
        }else if(itemCategory == 2 && armorPocket[itemPos].itemName != "Empty"){
            if(armorPocket[itemPos].itemName == equippedArmor.itemName){
                playerDef -= equippedArmor.itemDefense
                equippedArmor = armorItem[0]
            }else{
                playerDef -= equippedArmor.itemDefense
                equippedArmor = armorPocket[itemPos]
                playerDef += equippedArmor.itemDefense
            }
        }
    }
    
    func dropItem(itemPos: Int, itemCategory: Int){
        if(itemCategory == 0 && healthPocket[itemPos].itemName != "Empty"){
            healthPocket[itemPos] = healingItem[0]
        }else if(itemCategory == 1 && weaponPocket[itemPos].itemName != "Empty" && weaponPocket[itemPos].itemName != equippedWeapon.itemName){
            weaponPocket[itemPos] = attackItem[0]
        }else if(itemCategory == 2 && armorPocket[itemPos].itemName != "Empty" && armorPocket[itemPos].itemName != equippedArmor.itemName){
            armorPocket[itemPos] = armorItem[0]
        }
    }
    
    func closeInventory(){
        if(inBattle){
            visibleInventory = false
            battleScreen = true
            dropMode = false
        }
        else{
            visibleInventory = false
            visiblePlot = true
            visibleControls = true
            dropMode = false
        }
    }
    
}
