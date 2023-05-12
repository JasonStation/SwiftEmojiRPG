import SwiftUI

struct ClinicView: View {
    
    @Binding var visibleClinic: Bool
    
    @Binding var playerGold: Int
    @Binding var playerHealth: Int
    @Binding var playerMaxHealth: Int
    
    @Binding var healthPocket: [healthItems]
    @Binding var visibleConfirmBuy: Bool
    @Binding var itemToBuy: healthItems
    @Binding var buyItemCategory: Int
    @Binding var sellerDialogue: String
    
    @Binding var visiblePlot: Bool
    @Binding var visibleControls: Bool
    @Binding var maxSpace: Int

    
    var body: some View{
        if(visibleClinic){
            VStack {
                VStack{
                    Text("Buy Health Items").font(.system(size: 16, weight: .bold, design: .monospaced)).padding()
                    ForEach(1...healingItem.count - 1, id: \.self) { pos in
                        Button(action: {
                            print("\(healingItem[pos].itemName) tapped")
                            if(!inventoryIsFull(itemCategory: 0) && playerGold >= healingItem[pos].itemPrice){
                                visibleClinic = false
                                visibleConfirmBuy = true
                                buyItemCategory = 0
                                itemToBuy = healingItem[pos]
                            }else if(inventoryIsFull(itemCategory: 0)){
                                sellerDialogue = "Seller: Your inventory is full."
                            }else{
                                sellerDialogue = "Seller: You can't afford that."
                            }
                            
                        }, label: {
                            Text("\(healingItem[pos].itemName)\n\(healingItem[pos].itemPrice) GOLD")
                                .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 45)
                                .foregroundColor(.black)
                                .background(Color.white)
                            
                        })
                        
                    }
                    Text("\(sellerDialogue)")
                        .font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    
                    Text("GOLD: \(playerGold)")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    
                    HStack{
                        Button(action: {
                            exitClinic()
                        }) {
                            Text("< Back")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white) 
                        }.padding()
                        
                        Button(action: {
                            healPlayer()
                        }) {
                            Text("Heal to Full Health\n\((playerMaxHealth - playerHealth) / 6) GOLD")
                                .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 200, height: 50)
                                .foregroundColor(.black)
                                .background(.white) 
                        }.padding()
                        
                    }
                }
                
            }
        }
    }
    
    func exitClinic(){
        visibleClinic = false
        visiblePlot = true
        visibleControls = true
    }
    
    func healPlayer(){
        let healingPrice = (playerMaxHealth - playerHealth) / 6
        
        if(playerGold >= healingPrice && playerHealth < playerMaxHealth){
            playerHealth = playerMaxHealth
            playerGold -= healingPrice
            sellerDialogue = "Your health has been fully recovered."
        }else if(playerHealth >= playerMaxHealth){
            sellerDialogue = "Your health is already full."
        }else{
            sellerDialogue = "You can't afford that."
        }
        
    }
    
    func inventoryIsFull(itemCategory: Int) -> Bool{
        if(itemCategory == 0){
            for i in 0..<maxSpace{
                if(healthPocket[i] == healingItem[0]){
                    return false
                }
            }
        }
        return true
        
    }
}

