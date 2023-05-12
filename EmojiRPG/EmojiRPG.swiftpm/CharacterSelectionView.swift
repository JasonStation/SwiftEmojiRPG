import SwiftUI

struct CharacterSelectionView: View {
    
    @State private var playerName = ""
    @State private var playerIcon = "🙂"
    @State private var errorMessage = ""
    @State private var visibleCharacterSelection = true
    
    var body: some View{
        if(visibleCharacterSelection){
            
            VStack{
                Image("EmojiRPG_Logo").resizable().scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Choose a character:").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                
                Text("\(playerIcon)").font(.system(size: 70))
                
                TextField("Enter player name (Tap here)", text: $playerName).font(.system(size: 16, weight: .regular, design: .monospaced))
                    .multilineTextAlignment(.center)
                
                HStack{
                    Button(action: {
                        playerIcon = "🙂"
                    }, label: {
                        Text("🙂")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: true)
                        
                    }).padding()
                    
                    Button(action: {
                        playerIcon = "😕"
                    }, label: {
                        Text("😕")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                    }).padding()
                    
                    Button(action: {
                        playerIcon = "🥸"
                    }, label: {
                        Text("🥸")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                    }).padding()
                    
                    Button(action: {
                        playerIcon = "😎"
                    }, label: {
                        Text("😎")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                    }).padding()
                }
                
                HStack{
                    Button(action: {
                        playerIcon = "😲"
                    }, label: {
                        Text("😲")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: true)
                        
                    }).padding()
                    
                    Button(action: {
                        playerIcon = "😷"
                    }, label: {
                        Text("😷")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                    }).padding()
                    
                    Button(action: {
                        playerIcon = "🤓"
                    }, label: {
                        Text("🤓")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                    }).padding()
                    
                    Button(action: {
                        playerIcon = "🤠"
                    }, label: {
                        Text("🤠")
                            .font(.system(size: 30, weight: .regular, design: .monospaced)) .frame(width: 55, height: 55)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(40, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
                    }).padding()
                }
                
                Text("\(errorMessage)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                
                Button(action: {
                    //Test here
                  //  visibleCharacterSelection = false
                    
                    if(playerName.isEmpty){
                        errorMessage = "Please enter your character's name."
                    }else if(playerName.count > 8){
                        errorMessage = "Player name cannot exceed more than 8 characters."
                    }
                    else{
                        playerName = "\(playerIcon)\(playerName)"
                        visibleCharacterSelection = false
                    }
                }) {
                    Text("> Start")
                        .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 120, height: 50)
                        .foregroundColor(.black)
                        .background(.white) 
                }
                Spacer()
                
                
                
            }
        }else{
            InfoView(playerName: $playerName, playerIcon: $playerIcon)
        }
    }
    
}
