import SwiftUI

struct BlacksmithView: View {
    
    @Binding var visibleBlacksmith: Bool
    @Binding var blacksmithMenu: Int
    
    @Binding var playerGold: Int
    @Binding var playerLevel: Int
    
    @Binding var weaponPocket: [attackItems]
    @Binding var armorPocket: [armorItems]
    @Binding var visibleConfirmBuy: Bool
    @Binding var weaponToBuy: attackItems
    @Binding var armorToBuy: armorItems
    @Binding var buyItemCategory: Int
    @Binding var sellerDialogue: String
    
    @Binding var visiblePlot: Bool
    @Binding var visibleControls: Bool
    @Binding var maxSpace: Int
    
    var body: some View{
        if(visibleBlacksmith){
            VStack{
                HStack{
                    Button(action: {
                        blacksmithMenu = 0
                    }) {
                        Text("Weapons")
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.white)
                    }.padding()
                    
                    Button(action: {
                        blacksmithMenu = 1
                    }) {
                        Text("Armor")
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.white)
                    }.padding()
                    
                    
                }
                
                if(blacksmithMenu == 0){
                    Text("Buy Weapons")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    ForEach(1...attackItem.count - 1, id: \.self) { pos in
                        Button(action: {
                            print("\(attackItem[pos].itemName) tapped")
                            if(!inventoryIsFull(itemCategory: 1) && playerGold >= attackItem[pos].itemPrice && playerLevel >= attackItem[pos].itemRequiredLevel){
                                visibleBlacksmith = false
                                visibleConfirmBuy = true
                                buyItemCategory = 1
                                weaponToBuy = attackItem[pos]
                            }else if(playerLevel < attackItem[pos].itemRequiredLevel){
                                sellerDialogue = "You don't have the required level to buy that. Come back later!"
                            }
                            else if(inventoryIsFull(itemCategory: 1)){
                                sellerDialogue = "Seller: Your inventory is full."
                            }
                            else{
                                sellerDialogue = "Seller: You can't afford that."
                            }
                            
                        }, label: {
                            if(playerLevel >= attackItem[pos].itemRequiredLevel){
                                Text("\(attackItem[pos].itemName)\n\(attackItem[pos].itemPrice) GOLD")
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 45)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                            }else{
                                Text("🔒 Item unlocks at level \(attackItem[pos].itemRequiredLevel)")
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 45)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                            }
                            
                        })
                        
                    }
                }else{
                    Text("Buy Armor")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    ForEach(1...armorItem.count - 1, id: \.self) { pos in
                        Button(action: {
                            print("\(armorItem[pos].itemName) tapped")
                            if(!inventoryIsFull(itemCategory: 2) && playerGold >= armorItem[pos].itemPrice && playerLevel >= armorItem[pos].itemRequiredLevel){
                                visibleBlacksmith = false
                                visibleConfirmBuy = true
                                buyItemCategory = 2
                                armorToBuy = armorItem[pos]
                            }else if(playerLevel < armorItem[pos].itemRequiredLevel){
                                sellerDialogue = "You don't have the required level to buy that. Come back later!"
                            }
                            else if(inventoryIsFull(itemCategory: 2)){
                                sellerDialogue = "Seller: Your inventory is full."
                            }else{
                                sellerDialogue = "Seller: You can't afford that."
                            }
                            
                        }, label: {
                            if(playerLevel >= armorItem[pos].itemRequiredLevel){
                                Text("\(armorItem[pos].itemName)\n\(armorItem[pos].itemPrice) GOLD")
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 45)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                            }else{
                                Text("🔒 Item unlocks at level \(armorItem[pos].itemRequiredLevel)")
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 45)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                            }
                            
                        })
                        
                    }
                }
                Text("\(sellerDialogue)")
                    .font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                
                Text("GOLD: \(playerGold)")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                
                HStack{
                    Button(action: {
                        exitBlacksmith()
                    }) {
                        Text("< Back")
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.white) 
                    }.padding()
                    
                    
                }
            }
        }
    }
    
    func inventoryIsFull(itemCategory: Int) -> Bool{
        if(itemCategory == 1){
            for i in 0..<maxSpace{
                if(weaponPocket[i] == weaponPocket[0]){
                    return false
                }
            }
        }else if(itemCategory == 2){
            for i in 0..<maxSpace{
                if(armorPocket[i] == armorItem[0]){
                    return false
                }
            }
        }
        return true
        
    }
    
    func exitBlacksmith(){
        visibleBlacksmith = false
        visiblePlot = true
        visibleControls = true
        
    }
    
}


