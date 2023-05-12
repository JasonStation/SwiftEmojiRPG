import SwiftUI

struct StartScreenView: View {
    
    @State private var pageIndex = 0
       @State private var visibleStartScreen = true
    @State private var versionNumber = 1.18
    var body: some View{
        
        if(visibleStartScreen){
            if(pageIndex == 0){
                Image("EmojiRPG_Logo").resizable().scaledToFit()
                    .frame(width: 200, height: 200)
                
                Image("EmojiRPG_Artwork").resizable().scaledToFit()
                    .frame(width: 300, height: 300)
                
                Button(action: {
                    pageIndex += 1
                }) {
                    Text("Start Game")
                        .font(.system(size: 16, weight: .bold, design: .monospaced)) .frame(width: 160, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding()
                
                Button(action: {
                    pageIndex = -1
                }) {
                    Text("About")
                        .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 120, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding()
            }else{
                
                if(pageIndex == 1){
                    Image("Emoji_Comic_Page1").resizable().scaledToFit()
                        .frame(width: 550, height: 550)
                }else if(pageIndex == 2){
                    Image("Emoji_Comic_Page2").resizable().scaledToFit()
                        .frame(width: 550, height: 550)
                }else if(pageIndex == 3){
                    Image("Emoji_Comic_Page3").resizable().scaledToFit()
                        .frame(width: 550, height: 550)
                }else if(pageIndex == -1){
                    VStack{
                        Text("About").font(.system(size: 20, weight: .bold, design: .monospaced))
                        
                        Image("EmojiRPG_Logo").resizable().scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        Text("My WWDC 2023 Swift Student Challenge Submission! 🤗").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                        
                        Text("Made with ❤️ by Jason Leonardo").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                        
                         Text("🧑🏻‍💻Programming and 🎨assets by Jason Leonardo").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                        
                        Text("v\(String(format: "%.2f", versionNumber))").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                        
                        Button(action: {
                            pageIndex = 0
                        }) {
                            Text("< Back")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 120, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                        
                    }
                    
                    
                }
                
                if(pageIndex != -1){
                    Button(action: {
                        pageIndex += 1
                        if pageIndex == 4{
                            visibleStartScreen = false
                        }
                    }) {
                        Text("> Next")
                            .font(.system(size: 16, weight: .bold, design: .monospaced)) .frame(width: 140, height: 50)
                            .foregroundColor(.black)
                            .background(.white)
                    }.padding()
                }
            }
            
        }else{
           CharacterSelectionView()
            
        }
    }
    
}
