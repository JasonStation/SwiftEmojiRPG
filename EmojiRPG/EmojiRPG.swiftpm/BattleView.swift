import SwiftUI

struct BattleView: View {
    
    @Binding var battleScreen: Bool
    @Binding var inBattle: Bool
    @State private var battleState = 0
    
    @Binding var playerName: String
    @Binding var playerHealth: Int
    @Binding var playerMaxHealth: Int
    @Binding var playerAtk: Int
    @Binding var playerDef: Int
    @Binding var playerGold: Int
    @Binding var playerLevel: Int
    @Binding var playerEXP: Int
    @Binding var playerRequiredEXP: Int
    @Binding var playerDied: Bool
    
    @Binding var enemyName: String
    @Binding var enemyHealth: Int
    @Binding var enemyMaxHealth: Int
    @Binding var enemyAtk: Int
    @Binding var enemyDef: Int
    @Binding var enemyLevel: Int
    @Binding var enemiesEliminated: Int
    @Binding var isBoss: Bool
    
    @Binding var visibleNextButton: Bool
    
    @Binding var visibleActionButtons: Bool
    @Binding var visibleFinishBattleButton: Bool
    @Binding var visibleEnding: Bool
    @Binding var dialogue: String
    @State private var battlePhase = 0
    @State private var battleTurn = 0
    
    @Binding var visibleInventory: Bool
    
    @Binding var visiblePlot: Bool
    @Binding var visibleControls: Bool
    @Binding var equippedWeapon: attackItems
    @Binding var equippedArmor: armorItems
    
    @Binding var playerX: Int
    @Binding var playerY: Int
    @Binding var initialPlot: [[String]]
    @Binding var maxPlotX: Int
    @Binding var maxPlotY: Int
    @Binding var groundIcon: String
    @Binding var enemyIcon: String
    @Binding var chestIcon: String
    @Binding var chestX: Int
    @Binding var chestY: Int
    
    @State private var attackMode = false
    @State private var avoidMode = false
    @State private var criticalHit = false
    @State private var missAttack = false
    @State private var avoidAttack = false
    @State private var isSpinning = false
    
    let timer = Timer.publish(every: 0.07, on: .main, in: .common).autoconnect()
    
    var body: some View{
        if(visibleEnding){
            EndingView()
        }
        if(battleScreen){
           VStack {
                VStack{
                     Text("Battle!").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    //Enemy
                    HStack{
                        Text("[\(enemyName)] LV. \(enemyLevel)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        Text("HP: \(enemyHealth)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        
                        Text("ATK: \(enemyAtk)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                        
                        Text("DEF: \(enemyDef)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                        
                    }
                    
                    ProgressView(value: Double(enemyHealth) / Double(enemyMaxHealth))
                        .frame(width: 200, height: 20)
                   
                    if(attackMode || avoidMode){
                        RouletteWheel(isSpinning: $isSpinning, criticalHit: $criticalHit, avoidAttack: $avoidAttack, missAttack: $missAttack, attackMode: $attackMode, avoidMode: $avoidMode, visibleNextButton: $visibleNextButton, battlePhase: $battlePhase, dialogue: $dialogue)
                    }else if(!isBoss){
                        Image("Robot_Default")
                            .resizable()
                            .frame(width: 200, height: 200)

                    }else{
                        Image("Dragon_Default")
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                    
                    //Player
                    HStack{
                        Text("[\(playerName)] LV. \(playerLevel)").font(.system(size: 16, weight: .bold, design: .monospaced)).padding()
                        Text("HP: \(playerHealth)/\(playerMaxHealth)").font(.system(size: 16, weight: .bold, design: .monospaced)).padding()
                        
                        Text("ATK: \(playerAtk)").font(.system(size: 16, weight: .bold, design: .monospaced)).padding().padding()
                        
                        Text("DEF: \(playerDef)").font(.system(size: 16, weight: .bold, design: .monospaced)).padding().padding()
                        
                    }
                    
                    
                    //DialogueBox
                    HStack{
                        Text("\(dialogue)")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .frame(width: 490, height: 80)
                            .foregroundColor(.black)
                            .background(.white)
                    }
                    
                    //Next button
                    if(visibleNextButton){
                        Button(action: {
                            nextDialogue()
                        }) {
                            Text("Next >")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                    }
                    
                    //Finish battle button
                    if(visibleFinishBattleButton){
                        Button(action: {
                            endBattle()
                        }) {
                            Text("Continue >")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 140, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                    }
                    
                    
                    //Buttons
                    if(visibleActionButtons){
                        HStack{
                            Button(action: {
                                battlePhase = 0
                                if(!visibleInventory){
                                    spinAttack()
                                }
                            }) {
                                Text("⚔️ Attack")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced)) .frame(width: 140, height: 50)
                                    .foregroundColor(.black)
                                    .background(.white)
                            }.padding()
                            
                            Button(action: {
                                if(!attackMode){
                                    openInventory()
                                }
                            }) {
                                Text("🎒 Backpack")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced)) .frame(width: 140, height: 50)
                                    .foregroundColor(.black)
                                    .background(.white)
                            }.padding()
                            
                            Button(action: {
                                if(!isBoss){
                                    visibleInventory = false
                                    endBattle()
                                }else{
                                    dialogue = "You cannot flee in a boss battle."
                                }
                            }) {
                                Text("🏃🏻 Flee")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced)) .frame(width: 120, height: 50)
                                    .foregroundColor(.black)
                                    .background(.white)
                            }.padding()
                            
                            
                        }
                    }
                    
                }
            }
        }
    }
    
    func nextDialogue(){
        if(playerHealth <= 0 || enemyHealth <= 0){
            detectEndOfBattle()
            return
        }
        
        if(battlePhase == 1){
            attackEnemy()
            return
        }else if(battlePhase == 2){
            visibleNextButton = false
            spinAvoid()
            return
        }else if(battlePhase == 3){
            enemyHit()
            return
        }
        
        if(battleTurn == 1){
            visibleActionButtons = true
            visibleNextButton = false
            dialogue = "What will you do?"
            battleTurn += 1
        }else{
            visibleActionButtons = true
            visibleNextButton = false
            dialogue = "What will you do next?"
        }
        
        
    }
    
    func attackEnemy(){
        if(playerHealth <= 0 || enemyHealth <= 0){
            detectEndOfBattle()
            return
        }
        //Change val
        var damage = Int.random(in: playerAtk...playerAtk * 2) + 0 //Change damage values here
        
        if(damage < 1){
            damage = 1
        }
        
        if(missAttack){
            damage = 0
            dialogue = "You missed your attack!"
            missAttack = false
            
        }else if(criticalHit && !missAttack){
            damage *= 2
            dialogue = "Critical hit! \(playerName) dealt \(damage) damage to \(enemyName)."
            criticalHit = false
        }else if(!criticalHit && !missAttack){
            dialogue = "\(playerName) dealt \(damage) damage to \(enemyName)."
        }
        
        if(enemyHealth - damage < 0){
            enemyHealth = 0
        }else{
            enemyHealth -= damage
        }
        attackMode = false
        visibleActionButtons = false
        visibleNextButton = true

        
        battlePhase += 1
    }
    
    
    //End battle
    func endBattle(){
        if(playerHealth > 0 && !isBoss){
            //hard code...
            
            if(initialPlot[playerX][playerY] == groundIcon){
                initialPlot[playerX][playerY] = groundIcon
            }else if(initialPlot[playerX][playerY] == "🌾"){
                initialPlot[playerX][playerY] = "🌾"
            }else if(initialPlot[playerX][playerY] == "🌊"){
                initialPlot[playerX][playerY] = "🌊"
            }
            
            let enemyX = Int.random(in: 2...maxPlotX - 1)
            let enemyY = Int.random(in: 2...maxPlotY - 1)
       
            if(initialPlot[enemyX][enemyY] == groundIcon || initialPlot[enemyX][enemyY] == "🌾" || initialPlot[playerX][playerY] == "🌊"){
                initialPlot[enemyX][enemyY] = "🤖"
            }
            battleScreen = false
            visiblePlot = true
            visibleControls = true
            visibleNextButton = true
            inBattle = false
            battlePhase = 0
        }else if(playerHealth > 0 && isBoss){
            visibleEnding = true
            inBattle = false
            battlePhase = 0
            battleScreen = false
        }
        else{
            battleScreen = false
            inBattle = false
            battlePhase = 0
            playerDied = true
        }
    }
    
    func openInventory(){
        if(inBattle){
            battleScreen = false
            visibleInventory = true
        }else{
            visibleInventory = true
            visiblePlot = false
            visibleControls = false
        }
    }
    
    func detectEndOfBattle(){
        if(playerHealth <= 0){
            visibleNextButton = false
            visibleActionButtons = false
            visibleFinishBattleButton = true
            dialogue = "You died!"
        }else if(enemyHealth <= 0){
            visibleNextButton = false
            visibleActionButtons = false
            visibleFinishBattleButton = true
            enemiesEliminated += 1
            getPlayerReward()     
        }
    }
    
    func spinAttack(){
        if(!visibleInventory){
            dialogue = "Your turn to attack!\nHit 💥 for Critical damage.\nIf you hit ❌, you'll miss your attack."
            visibleActionButtons = false
            attackMode = true
            isSpinning = true
        }
    }
    
    func spinAvoid(){
        dialogue = "Enemy is trying to attack you! Hit 🛡️ to avoid getting hit!"
        visibleActionButtons = false
        avoidMode = true
        isSpinning = true
    }
    
    func enemyHit(){
        if(playerHealth <= 0 || enemyHealth <= 0){
            detectEndOfBattle()
            return
        }
        
       
        var damage = Int(Double.random(in: Double(enemyAtk) * 1.5...Double(enemyAtk) * 2.3)) - playerDef
        
        if(damage < 1){
            damage = 1
        }

        
        if(avoidAttack){
            dialogue = "You avoided the enemy's attack!"
            avoidAttack = false
 
        }else{
            
            dialogue = "\(enemyName) dealt \(damage) HP of damage to you!"
            if(playerHealth - damage < 0){
                playerHealth = 0
            }else{
                playerHealth -= damage
            }
        }
        battlePhase = 0
        
        avoidMode = false
        visibleActionButtons = false
        visibleNextButton = true
        
    }
    
    func getPlayerReward(){
        let baseXP = 20
        let xpIncreasePercentage = 0.1
        let randomXP = Int.random(in: 1...20)
        let randomGold = Int.random(in: -5...25)
        
        let expReward = Int(Double(baseXP) * pow(1 + xpIncreasePercentage, Double(playerLevel) * Double(enemyLevel / playerLevel))) + randomXP
        
        let goldReward
        = Int(Double(baseXP) * pow(1 + xpIncreasePercentage, Double(enemyLevel))) * 2 + randomGold
        
      
        dialogue = "You won the battle! You have earned \(expReward) EXP and \(goldReward) GOLD!"
        
        playerEXP += expReward
        playerGold += goldReward
        
        let chestChance = Int.random(in: 1...4)
        
        if(chestChance == 1){
            chestX = Int.random(in: 2...maxPlotX - 1)
            chestY = Int.random(in: 2...maxPlotY - 1)
            if(initialPlot[chestX][chestY] == groundIcon || initialPlot[chestX][chestY] == "🌾"){
                initialPlot[chestX][chestY] = chestIcon
            }
        }
        
        if(playerEXP >= playerRequiredEXP && playerLevel < 6){
            
            playerEXP -= playerRequiredEXP
            playerLevel += 1
            
            dialogue = "YOU LEVELED UP TO LEVEL \(playerLevel)! You have won the battle and earned \(expReward) EXP and \(goldReward) GOLD!"
            
            playerMaxHealth = Int(round(Double(playerMaxHealth) * 1.2))
            playerAtk = Int(ceil(Double(playerAtk - equippedWeapon.itemAttack) * 1.12)) + equippedWeapon.itemAttack
            playerDef = Int(ceil(Double(playerDef - equippedArmor.itemDefense) * 1.3)) + equippedArmor.itemDefense
            playerRequiredEXP = Int(ceil(Double(playerRequiredEXP) * 1.3))
            
            playerHealth = playerMaxHealth
            
        }
    }
 
    
}
