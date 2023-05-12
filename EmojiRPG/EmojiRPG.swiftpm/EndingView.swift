import SwiftUI

struct EndingView: View {
    
    @State private var visibleEndingScreen = true
    @State private var pageIndex = 1
    
    var body: some View{
        if(visibleEndingScreen){
            if(pageIndex == 1){
                Image("Emoji_Comic_Page4").resizable().scaledToFit()
                    .frame(width: 550, height: 550)
            }else if(pageIndex == 2){
                Image("Emoji_Comic_Page5").resizable().scaledToFit()
                    .frame(width: 550, height: 550)
            }else if(pageIndex == 3){
                Image("Emoji_Comic_Page6").resizable().scaledToFit()
                    .frame(width: 550, height: 550)
            }
            
            
            Button(action: {
                pageIndex += 1
                if pageIndex == 4{
                    visibleEndingScreen = false
                }
            }) {
                Text("> Next")
                    .font(.system(size: 16, weight: .bold, design: .monospaced)) .frame(width: 140, height: 50)
                    .foregroundColor(.black)
                    .background(.white)
            }.padding()
        }else{
            StartScreenView()
        }
        
    }
    
}
