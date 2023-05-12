import SwiftUI

struct RouletteWheel: View {
    @State private var selected = 0
    @Binding var isSpinning: Bool
    @State private var randomPos = Int.random(in: 0..<6)
    @State private var randomPosCrit = Int.random(in: 4..<6)
    @State private var randomPosMiss = Int.random(in: 0..<4)
    @State private var visibleStopButton = true
    @Binding var criticalHit: Bool
    @Binding var avoidAttack: Bool
    @Binding var missAttack: Bool
    
    @Binding var attackMode: Bool
    @Binding var avoidMode: Bool
    @Binding var visibleNextButton: Bool
    @Binding var battlePhase: Int
    @Binding var dialogue: String

    let timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            //Text("Selected: \(selected) \(randomPos)")
            
            ZStack {
                ForEach(0..<8) { index in
                    Slice(startAngle: .degrees(Double(index) * 45 + 22.5), endAngle: .degrees(Double(index + 1) * 45 + 22.5))
                        .fill(Color(hue: Double(index) / 8, saturation: 0.8, brightness: 0.9))
                    if index == randomPosCrit + 2 && attackMode{
                        Text("                 💥")
                            .rotationEffect(.degrees(Double(index) * 45.0))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }else if(index == randomPosMiss + 2 && attackMode){
                        Text("                               ❌")
                            .rotationEffect(.degrees(Double(index) * 45.0))
                            .foregroundColor(.white)
                    }
                    else if(index == randomPos + 2 && avoidMode){
                        Text("                 🛡️")
                            .rotationEffect(.degrees(Double(index) * 45.0))
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(.degrees(Double(selected) * 45))
            }
            .frame(width: 220, height: 220)
            
            if(isSpinning){
                Button(action: {
                    if(attackMode && !avoidMode){
                        stopSpinning()
                        visibleStopButton = false
                        visibleNextButton = true
                        if(selected == randomPosCrit){
                            criticalHit = true
                            dialogue = "You landed a CRITICAL HIT!"
                        }else if(selected == randomPosMiss){
                            missAttack = true
                            dialogue = "Whoops..."
                        }
                        else{
                            dialogue = "You landed a hit!"
                        }
                        
                        battlePhase = 1
                    }
                    else{
                        stopSpinning()
                        if(selected == randomPos){
                            avoidAttack = true
                            dialogue = "Whoo! That was close!"
                        }else{
                            dialogue = "Enemy hit you!"
                        }
                        visibleStopButton = false
                        visibleNextButton = true
                    
                        battlePhase = 3
                    }
            
                }) {
                    Text("Stop")
                        .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding()
                    .disabled(!isSpinning)
            }
           
        }
        .onAppear(perform: {
            startSpinning()
        })
        .onReceive(timer) { _ in
            if isSpinning {
                selected = (selected + 1) % 8
            }
        }
    }
    
    func startSpinning() {
        isSpinning = true
    }
    
    func stopSpinning() {
        isSpinning = false
    }
    
    
}


struct Slice: Shape {
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}
