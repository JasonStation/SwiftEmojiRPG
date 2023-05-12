import SwiftUI

struct InfoView: View {
    
    @State private var visibleInfoView = true
    @Binding var playerName: String
    @Binding var playerIcon: String
    
    var body: some View{
        if(visibleInfoView){
            VStack{
                Text("How to Play").font(.system(size: 16, weight: .bold, design: .monospaced)).padding()
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "arrow.up")
                            .font(.system(size: 24))
                        Text("Tap arrow keys to move.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("\(playerIcon)").font(.system(size: 25, weight: .regular, design: .monospaced))
                        Text("This is the player. If HP gets to 0, it's game over!").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("🎒").font(.system(size: 25, weight: .regular, design: .monospaced))
                        Text("The player has a backpack. You can open it to use items.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("🤖").font(.system(size: 25, weight: .regular, design: .monospaced))
                        Text("These are enemies. If you touch them, you'll encounter a fight with them.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("🏥⚒️").font(.system(size: 25, weight: .regular, design: .monospaced))
                        Text("These are a clinic and a blacksmith. Interact with them to buy items. You can also heal to full health from the clinic.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("🌾").font(.system(size: 25, weight: .regular, design: .monospaced))
                        Text("This is grass. You have a chance to fight enemies if you pass through here.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("🌊").font(.system(size: 25, weight: .regular, design: .monospaced))
                        Text("This is water. Just like grass, you can encounter enemies. You need a specific item to walk through water.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                    HStack{
                        Text("🧿").font(.system(size: 25, weight: .regular, design: .monospaced))
                        Text("This is the portal. You can go to the next world through here.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                    }.padding(.horizontal)
                    
                }
                Button(action: {
                    visibleInfoView = false
                }) {
                    Text("OK")
                        .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding()
            }
        }else{
            GameView(playerName: $playerName, playerIcon: $playerIcon, visibleControls: true, visiblePlot: true, visibleInventory: false, inventoryMenu: 0)
        }
    }
    
}
