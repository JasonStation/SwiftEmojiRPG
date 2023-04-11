import SwiftUI

struct ContentView: View {
    
    //Plots
    @State private var plot: [[String]] = []
    @State private var initialPlot: [[String]] = []
    @State private var maxPlotX = 25
    @State private var maxPlotY = 25
    @State private var portalX = 0
    @State private var portalY = 0
    
    //Grass
    @State private var grassStartX = Int.random(in: 1...20)
    @State private var grassStartY = Int.random(in: 1...15)
    @State private var grassSize = Int.random(in: 5...15)
    
    //Player
    @State private var playerName = "Player"
    @State private var playerX = 0
    @State private var playerY = 0
    @State private var playerHealth = 100
    @State private var playerMaxHealth = 100
    @State private var playerDef = 5
    @State private var playerAtk = 10
    @State private var playerGold = 0
    @State private var healthPocket: [healthItems] = []
    @State private var weaponPocket: [attackItems] = []
    @State private var armorPocket: [armorItems] = []
    @State private var maxSpace = 8
    @State private var playerEXP = 0
    @State private var playerRequiredEXP = 100
    @State private var playerLevel = 1
    
    
    //Enemy
    @State private var enemiesX: [Int] = []
    @State private var enemiesY: [Int] = []
    @State private var enemyName = "Enemy"
    @State private var enemyHealth = 100
    @State private var enemyAtk = 10
    @State private var enemyDef = 3
    
    //Icons
    @State private var playerIcon = "🙂"
    @State private var grassIcon = "🌾"
    @State private var portalIcon = "🧿"
    @State private var enemyIcon = "🤖"
    @State private var groundIcon = "◾️"
    
    //Dialogue
    @State private var dialogue = "A wild enemy appeared!"
    
    //Battle
    @State private var battleTurn = 1
    @State private var inBattle = false
    @State private var battlePhase = 0
    
    //UI Toggles
    @State private var visibleControls = true
    @State private var visiblePlot = true
    @State private var battleScreen = false
    @State private var visibleActionButtons = false
    @State private var visibleNextButton = false
    @State private var visibleFinishBattleButton = false
    @State private var visibleInventory = false
    @State private var inventoryMenu = 0
    
    var body: some View {
        
        
        VStack {
            Text("Emoji RPG").font(.system(size: 16, weight: .bold, design: .monospaced))
                .padding()
            if(visiblePlot){
                ForEach(plot, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { column in
                            Text(column)
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                }
            }
            if(visibleControls){
                HStack{
                    Text("[\(playerName)]").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    Text("LEVEL: \(playerLevel)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    Text("EXP: \(playerEXP)/\(playerRequiredEXP)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                }
                HStack{
                    Text("HP: \(playerHealth)/\(playerMaxHealth)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                    Text("ATK: \(playerAtk)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                    Text("DEF: \(playerDef)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                }
                Button(action: {
                    openInventory()
                }, label: {
                    Text("Inventory")
                        .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 100, height: 35)
                        .foregroundColor(.black)
                        .background(Color.white)
                    
                })
                
                HStack {
                    
                    Button(action: {
                        movePlayer(xOffset: 0, yOffset: -1)
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 24))
                    }
                    Spacer()
                    Button(action: {
                        movePlayer(xOffset: -1, yOffset: 0)
                    }) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 24))
                    }
                    Spacer()
                    Button(action: {
                        movePlayer(xOffset: 0, yOffset: 1)
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 24))
                    }
                    Spacer()
                    Button(action: {
                        movePlayer(xOffset: 1, yOffset: 0)
                    }) {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 24))
                    }
                }
                          }
            
        }
        .onAppear {
            generateMap()
            itemInitialization()
        }
        
        //Inventory
        
        if(visibleInventory){
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
                
                //Code here
                
                if(inventoryMenu == 0){
                    VStack {
                        Text("Health Items").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        ForEach(healthPocket, id: \.self) { item in
                            Button(action: {
                                print("\(item.itemName) tapped")
                            }, label: {
                                Text(item.itemName)
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                   
                            })
                           
                        }
                    }
                }
                else if(inventoryMenu == 1){
                    VStack {
                        Text("Weapons").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        ForEach(weaponPocket, id: \.self) { item in
                            Button(action: {
                                print("\(item.itemName) tapped")
                            }, label: {
                                Text(item.itemName)
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                
                            })
                            
                        }
                    }
                }else{
                    VStack {
                        Text("Armor").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        ForEach(armorPocket, id: \.self) { item in
                            Button(action: {
                                print("\(item.itemName) tapped")
                            }, label: {
                                Text(item.itemName)
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 380, height: 35)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                
                            })
                            
                        }
                    }
                }
                
                
                
            }.padding()
            
            Text("Tap an item to use it.")
                .font(.system(size: 14, weight: .regular, design: .monospaced))
            
            Button(action: {
                closeInventory()
            }) {
                Text("< Back")
                    .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                    .foregroundColor(.black)
                    .background(.white)
            }.padding()
            
            
        }
        
        //Battle Screen
        
        if(battleScreen){
            VStack{
                //Enemy
                HStack{
                    Text("[\(enemyName)]").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    Text("HP: \(enemyHealth)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                    Text("ATK: \(enemyAtk)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                    
                    Text("DEF: \(enemyDef)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                    
                }
                
                //Player
                HStack{
                    Text("[\(playerName)]").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    Text("HP: \(playerHealth)/\(playerMaxHealth)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                    
                    Text("ATK: \(playerAtk)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                    
                    Text("DEF: \(playerDef)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding().padding()
                    
                }
                
                //DialogueBox
                HStack{
                    Text("\(dialogue)")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(width: 380, height: 80)
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
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 135, height: 50)
                            .foregroundColor(.black)
                            .background(.white)
                    }.padding()
                }
                
                
                //Buttons
                if(visibleActionButtons){
                    HStack{
                        Button(action: {
                            attackEnemy()
                        }) {
                            Text("Attack")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                        
                        Button(action: {
                            openInventory()
                        }) {
                            Text("Inventory")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                        
                        Button(action: {
                            //movePlayer(xOffset: 0, yOffset: 1)
                        }) {
                            Text("Flee")
                                .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .background(.white)
                        }.padding()
                        
                        
                    }
                }
                
            }
        }
    }
    
    func generateMap() {
        plot = Array(repeating: Array(repeating: groundIcon, count: maxPlotX), count: maxPlotY)
        
        // Replace some of the dots with a square of Vs
        grassStartX = Int.random(in: 1...(maxPlotX-grassSize))
        grassStartY = Int.random(in: 1...(maxPlotY-grassSize))
        grassSize = Int.random(in: 2...10)
        
        for x in grassStartX...(grassStartX + grassSize) {
            for y in grassStartY...(grassStartY + grassSize) {
                if x < maxPlotX && y < maxPlotY {
                    plot[y][x] = grassIcon
                    
                }
            }
        }
        portalX = Int.random(in: 2...maxPlotX - 1)
        portalY = Int.random(in: 2...maxPlotY - 1)
        
        let numberOfEnemies = Int.random(in: 3...5)
        
        for i in 0...numberOfEnemies{
            let enemyX = Int.random(in: 2...maxPlotX - 1)
            let enemyY = Int.random(in: 2...maxPlotY - 1)
            
            enemiesX.append(enemyX)
            enemiesY.append(enemyY)
            
            plot[enemiesX[i]][enemiesY[i]] = enemyIcon
        }
        
        // Set the player's starting position
        plot[portalX][portalY] = portalIcon
        
        plot[0][0] = "🆂"
        initialPlot = plot
        
    }
    
    func itemInitialization(){
        for _ in 0...maxSpace - 1{
            healthPocket.append(healingItem[0])
            armorPocket.append(armorItem[0])
            weaponPocket.append(attackItem[0])
        }
        healthPocket[0] = healingItem[1]
    }
    
    func initiateBattle(){
        visiblePlot = false
        visibleControls = false
        battleScreen = true
        visibleActionButtons = false
        visibleFinishBattleButton = false
        visibleNextButton = true
        inBattle = true
        dialogue = "You encountered a(n) \(enemyName)"
        
        
        enemyHealth = 100 + Int.random(in: -15...10)
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
    
    func closeInventory(){
        if(inBattle){
            visibleInventory = false
            battleScreen = true
            print("\(inBattle)")
        }
        else{
            visibleInventory = false
            visiblePlot = true
            visibleControls = true
        }
    }
    
    func detectEndOfBattle(){
        if(playerHealth <= 0){
            visibleNextButton = false
            visibleActionButtons = false
            visibleFinishBattleButton = true
            dialogue = "You died"
        }else if(enemyHealth <= 0){
            visibleNextButton = false
            visibleActionButtons = false
            visibleFinishBattleButton = true
            getPlayerReward()     
        }
    }
    
    func enemyHit(){
        if(playerHealth <= 0 || enemyHealth <= 0){
            detectEndOfBattle()
            return
        }
        
        let scaling = enemyAtk / 10
        let damage = enemyAtk + Int.random(in: -2 * scaling...4 * scaling)
        
        dialogue = "\(enemyName) dealt \(damage) HP of damage to you!"
        
        playerHealth -= damage
        battlePhase = 0
        
        visibleActionButtons = false
        visibleNextButton = true
        
    }
    
    //Dialogue in battle
    
    func nextDialogue(){
        if(playerHealth <= 0 || enemyHealth <= 0){
            detectEndOfBattle()
            return
        }
        
        if(battlePhase == 1){
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
        let scaling = playerAtk / 10
        var damage = playerAtk + Int.random(in: -2 * scaling...4 * scaling)
        let criticalChance = Int.random(in: 1...10)
        
        if(criticalChance == 1){
            damage *= 2
            dialogue = "Critical hit! \(playerName) dealt \(damage) damage to \(enemyName)."
        }else{
            dialogue = "\(playerName) dealt \(damage) damage to \(enemyName)."
        }
        
        enemyHealth -= damage
        visibleActionButtons = false
        visibleNextButton = true
        
        battlePhase += 1
    }
    
    
    //End battle
    func endBattle(){
        battleScreen = false
        visiblePlot = true
        visibleControls = true
        visibleNextButton = true
        inBattle = false
        battlePhase = 0
    }
    
    func getPlayerReward(){
        let baseXP = 20
        let xpIncreasePercentage = 0.1
        let randomXP = Int.random(in: 1...20)
        
        let expReward = Int(Double(baseXP) * pow(1 + xpIncreasePercentage, Double(playerLevel))) + randomXP
        
        let goldReward
        = Int(Double(baseXP) * pow(1 + xpIncreasePercentage, Double(playerLevel))) + randomXP
        
        dialogue = "You won the battle! You have earned \(expReward) EXP and \(goldReward) GOLD!"
        playerEXP += expReward + 100
        playerGold += goldReward
        
        if(playerEXP >= playerRequiredEXP){
            playerEXP -= playerRequiredEXP
            playerLevel += 1
            
            playerMaxHealth = Int(round(Double(playerMaxHealth) * 1.1))
            playerAtk = Int(ceil(Double(playerAtk) * 1.05))
            playerDef = Int(ceil(Double(playerDef) * 1.05))
            
            playerHealth = playerMaxHealth
            
        }
    }
    
    func movePlayer(xOffset: Int, yOffset: Int) {
        plot = initialPlot       
        
        if playerX + xOffset >= 0 && playerX + xOffset < maxPlotX && playerY + yOffset >= 0 && playerY + yOffset < maxPlotY {
            playerX += xOffset
            playerY += yOffset
        }
        
        
        plot[playerX][playerY] = playerIcon
        
        //detect tiles
        
        if initialPlot[playerX][playerY] == grassIcon{
            print("Stepped on grass")
        }else if initialPlot[playerX][playerY] == enemyIcon{
            print("Enemy")
            initiateBattle()
        }
        else if initialPlot[playerX][playerY] == portalIcon{
            print("Portal")
            
        }
        
        
    }
    
    
}
