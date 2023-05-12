import SwiftUI

struct GameView: View {
    
    //Plots
    @State private var plot: [[String]] = []
    @State private var initialPlot: [[String]] = []
    @State private var maxPlotX = 20
    @State private var maxPlotY = 20
    @State private var portalX = 0
    @State private var portalY = 0
    @State private var clinicX = 0
    @State private var clinicY = 0
    @State private var blacksmithX = 0
    @State private var blacksmithY = 0
    
    //World Info
    @State private var worldNumber = 1 //Change world number
    @State private var worldName = ["Mojiville", "Emote Heights", "The Cave"]
    
    //Grass
    @State private var grassStartX = Int.random(in: 1...20)
    @State private var grassStartY = Int.random(in: 1...15)
    @State private var grassSize = Int.random(in: 5...15)
    
    //Player
    @Binding var playerName: String
    @State private var playerX = 0
    @State private var playerY = 0
    @State private var playerHealth = 100
    @State private var playerMaxHealth = 100
    @State private var playerDef = 5
    @State private var playerAtk = 10
    @State private var playerGold = 20
    @State private var maxSpace = 8
    @State private var playerEXP = 0
    @State private var playerRequiredEXP = 60
    @State private var playerLevel = 1 //Change val
    @State private var playerDied = false
    
    //Player Inventory and Equipped Items
    @State private var healthPocket: [healthItems] = []
    @State private var weaponPocket: [attackItems] = []
    @State private var armorPocket: [armorItems] = []
    @State private var equippedWeapon = attackItem[0]
    @State private var equippedArmor = armorItem[0]
    @State private var dropMode = false
    @State private var modeText = "Drop"
    
    //Clinic and Blacksmith
    @State private var itemToBuy = healingItem[0]
    @State private var weaponToBuy = attackItem[0]
    @State private var armorToBuy = armorItem[0]    
    @State private var buyItemCategory = 0
    @State private var sellerDialogue = ""
    
    //Enemy
    @State private var enemiesX: [Int] = []
    @State private var enemiesY: [Int] = []
    @State private var enemyName = "Enemy"
    @State private var enemyHealth = 250
    @State private var enemyMaxHealth = 100
    @State private var enemyAtk = 30
    @State private var enemyDef = 30
    @State private var enemyLevel = 1
    @State private var enemiesEliminated = 0
    @State private var isBoss = false
    
    //Icons
    @Binding var playerIcon: String
    @State private var grassIcon = "🌾"
    @State private var waterIcon = "🌊"
    @State private var portalIcon = "🧿"
    @State private var enemyIcon = "🤖"
    @State private var groundIcon = "◾️"
    @State private var clinicIcon = "🏥"
    @State private var blacksmithIcon = "⚒️"
    @State private var chestIcon = "🎁"
    @State private var dragonIcon = "🐉"
    
    //Chest
    @State private var chestX = 0
    @State private var chestY = 0
    
    //Portal
    @State private var requiredLevel = 3
    @State private var requiredEnemies = 5
    @State private var portalMessage = ""
    
    //Dialogue
    @State private var dialogue = "A wild enemy appeared!"
    
    //Battle
    @State private var battleTurn = 1
    @State private var inBattle = false
    @State private var battlePhase = 0
    
    //Chest
    @State private var goldAmount = 0
    
    //UI Toggles
    @State public var visibleControls = true
    @State public var visiblePlot = true
    @State private var battleScreen = false
    @State private var visibleActionButtons = false
    @State private var visibleNextButton = true
    @State private var visibleFinishBattleButton = false
    @State public var visibleInventory = false
    @State private var visibleClinic = false
    @State private var visibleBlacksmith = false
    @State private var visibleConfirmBuy = false
    @State private var visiblePortalMenu = false
    @State private var backToMenu = false
    @State private var visibleChest = false
    @State public var inventoryMenu = 0
    @State private var blacksmithMenu = 0
    @State private var buttonToggle = ""
    @State private var visibleEnding = false
    
    var body: some View {
        if(backToMenu){
            CharacterSelectionView()
        }else if(visibleEnding){
            EndingView()
        }
        
        VStack{
            if(visiblePlot){
                Text("World \(worldNumber): \(worldName[worldNumber - 1])")
                    .font(.system(size: 14, weight: .bold, design: .monospaced)).padding()
                ForEach(plot, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { column in
                            Text(column)
                                .font(.system(size: 16, weight: .regular, design: .monospaced))
                        }
                    }
                }
                
                
                if(visibleControls){
                    HStack{
                        Text("[\(playerName)]").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        Text("LEVEL: \(playerLevel)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        if(playerLevel < 6){
                            Text("EXP: \(playerEXP)/\(playerRequiredEXP)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                            Text("GOLD: \(playerGold)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        }else{
                            Text("EXP: MAX").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                            Text("GOLD: \(playerGold)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        }
                    }
                    HStack{
                        Text("HP: \(playerHealth)/\(playerMaxHealth)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        
                        Text("ATK: \(playerAtk)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        
                        Text("DEF: \(playerDef)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                        
                    }
                
                }
                
                HStack{
                    VStack(alignment: .leading){
                        Button(action: {
                            movePlayer(xOffset: -1, yOffset: 0)
                        }) {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 24)).frame(width: 40, height: 40)
                                .foregroundColor(.black)
                                .background(Color.white)
                        }.padding(.horizontal, 20)
                        HStack {
                            
                            Button(action: {
                                movePlayer(xOffset: 0, yOffset: -1)
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 24)).frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                            }
                            
                            Button(action: {
                                movePlayer(xOffset: 0, yOffset: 1)
                            }) {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 24)).frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                            }
                            Spacer()
                            
                        }
                        Button(action: {
                            movePlayer(xOffset: 1, yOffset: 0)
                        }) {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 24)).frame(width: 40, height: 40)
                                .foregroundColor(.black)
                                .background(Color.white)
                        }.padding(.horizontal, 20)
                    }.padding(.horizontal, 50)
                    HStack{
                        if(buttonToggle == "Portal" || buttonToggle == "Clinic" || buttonToggle == "Blacksmith" || buttonToggle == "Chest"){
                            Button(action: {
                                if(buttonToggle == "Portal"){
                                    visitPortal()
                                }else if(buttonToggle == "Clinic"){
                                    visitClinic()
                                }else if(buttonToggle == "Blacksmith"){
                                    visitBlacksmith()
                                }else if(buttonToggle == "Chest"){
                                    visiblePlot = false
                                    visibleControls = false
                                    visibleChest = true
                                    openChest()
                                }
                            }, label: {
                                Text("\(buttonToggle)")
                                    .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 120, height: 40)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                
                            }).padding(.horizontal)
                        }
                        Button(action: {
                            openInventory()
                        }, label: {
                            Text("🎒Backpack")
                                .font(.system(size: 14, weight: .regular, design: .monospaced)) .frame(width: 120, height: 40)
                                .foregroundColor(.black)
                                .background(Color.white)
                            
                        }).padding(.horizontal)
                        

                        
                    }
                }.padding(.horizontal)
            }
        }.onAppear {
            generateMap()
            itemInitialization()
        }
            
        
        //Inventory button
        
        if(visibleInventory){
            InventoryView(visibleInventory: $visibleInventory, dropMode: $dropMode, inventoryMenu: $inventoryMenu, healthPocket: $healthPocket, weaponPocket: $weaponPocket, armorPocket: $armorPocket, equippedWeapon: $equippedWeapon, equippedArmor: $equippedArmor, playerHealth: $playerHealth, playerMaxHealth: $playerMaxHealth, playerDef: $playerDef, playerAtk: $playerAtk, visiblePlot: $visiblePlot, visibleControls: $visibleControls, inBattle: $inBattle, battleScreen: $battleScreen)
        }
        
        //Clinic screen
        
        if(visibleClinic){
            ClinicView(visibleClinic: $visibleClinic, playerGold: $playerGold, playerHealth: $playerHealth, playerMaxHealth: $playerMaxHealth, healthPocket: $healthPocket, visibleConfirmBuy: $visibleConfirmBuy, itemToBuy: $itemToBuy, buyItemCategory: $buyItemCategory, sellerDialogue: $sellerDialogue, visiblePlot: $visiblePlot, visibleControls: $visibleControls, maxSpace: $maxSpace)
        }
        
        //Blacksmith Shop
        
        if(visibleBlacksmith){
            BlacksmithView(visibleBlacksmith: $visibleBlacksmith, blacksmithMenu: $blacksmithMenu, playerGold: $playerGold, playerLevel: $playerLevel, weaponPocket: $weaponPocket, armorPocket: $armorPocket, visibleConfirmBuy: $visibleConfirmBuy, weaponToBuy: $weaponToBuy, armorToBuy: $armorToBuy, buyItemCategory: $buyItemCategory, sellerDialogue: $sellerDialogue, visiblePlot: $visiblePlot, visibleControls: $visibleControls, maxSpace: $maxSpace)
        }
        
        //Confirm Buy
        
        if(visibleConfirmBuy){
            VStack{
                Text("Are you sure you want to buy").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                if(buyItemCategory == 0){
                    Text("\(itemToBuy.itemName)").font(.system(size: 20, weight: .bold, design: .monospaced))
                    Text("for \(itemToBuy.itemPrice) GOLD?").font(.system(size: 16, weight: .regular, design: .monospaced))
                }else if(buyItemCategory == 1){
                    Text("\(weaponToBuy.itemName)").font(.system(size: 20, weight: .bold, design: .monospaced))
                    Text("for \(weaponToBuy.itemPrice) GOLD?").font(.system(size: 16, weight: .regular, design: .monospaced))
                }else{
                    Text("\(armorToBuy.itemName)").font(.system(size: 20, weight: .bold, design: .monospaced))
                    Text("for \(armorToBuy.itemPrice) GOLD?").font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                }
                HStack{
                    Button(action: {
                        if(buyItemCategory == 0){
                            buyItem(itemPos: itemToBuy.itemId, itemCategory: 0)
                            visibleConfirmBuy = false
                            visibleClinic = true
                        }else if(buyItemCategory == 1){
                            buyItem(itemPos: weaponToBuy.itemId, itemCategory: 1)
                            visibleConfirmBuy = false
                            visibleBlacksmith = true
                        }else{
                            buyItem(itemPos: armorToBuy.itemId, itemCategory: 2)
                            visibleConfirmBuy = false
                            visibleBlacksmith = true
                        }
                    }) {
                        Text("Yes")
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.white) 
                    }.padding()
                    
                    Button(action: {
                        if(buyItemCategory == 0){
                            visibleConfirmBuy = false
                            visibleClinic = true
                        }else{
                            visibleConfirmBuy = false
                            visibleBlacksmith = true
                        }
                    }) {
                        Text("No")
                            .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .background(.white) 
                    }.padding()
                    
                }
                
            }
        }
        
        //Battle Screen
        
        if(battleScreen && !visibleChest && !visibleInventory && !visibleBlacksmith && !visiblePortalMenu && !visibleClinic){
            BattleView(battleScreen: $battleScreen, inBattle: $inBattle, playerName: $playerName, playerHealth: $playerHealth, playerMaxHealth: $playerMaxHealth, playerAtk: $playerAtk, playerDef: $playerDef, playerGold: $playerGold, playerLevel: $playerLevel, playerEXP: $playerEXP, playerRequiredEXP: $playerRequiredEXP, playerDied: $playerDied, enemyName: $enemyName, enemyHealth: $enemyHealth, enemyMaxHealth: $enemyMaxHealth, enemyAtk: $enemyAtk, enemyDef: $enemyDef, enemyLevel: $enemyLevel, enemiesEliminated: $enemiesEliminated, isBoss: $isBoss, visibleNextButton: $visibleNextButton, visibleActionButtons: $visibleActionButtons, visibleFinishBattleButton: $visibleFinishBattleButton, visibleEnding: $visibleEnding, dialogue: $dialogue, visibleInventory: $visibleInventory, visiblePlot: $visiblePlot, visibleControls: $visibleControls, equippedWeapon: $equippedWeapon, equippedArmor: $equippedArmor, playerX: $playerX, playerY: $playerY, initialPlot: $initialPlot, maxPlotX: $maxPlotX, maxPlotY: $maxPlotY, groundIcon: $groundIcon, enemyIcon: $enemyIcon, chestIcon: $chestIcon, chestX: $chestX, chestY: $chestY)
        }
        
        if(visiblePortalMenu){
            VStack{
                Text("Portal").font(.system(size: 16, weight: .bold, design: .monospaced))
                
                Text("Quests to be completed:").font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Text("🤖 Enemies eliminated: \(enemiesEliminated)/\(requiredEnemies)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                
                Text("🏳️ Reach level \(requiredLevel): \(playerLevel)/\(requiredLevel)").font(.system(size: 16, weight: .regular, design: .monospaced)).padding()
                
                if(worldNumber == 2){
                    Text("⚠️Going through this portal will send you The Cave where the dragon sleeps. Be sure to prepare potions and gear before proceeding.").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                }else{
                    Text("⚔️Make sure to buy gear as enemies beyond this portal are a lot stronger!").font(.system(size: 14, weight: .regular, design: .monospaced)).padding()
                }
                
                Button(action: {
                    goToNextWorld()
                }) {
                    Text("> Move to Next World")
                        .font(.system(size: 16, weight: .bold, design: .monospaced)) .frame(width: 250, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding().padding()
                
                Text("\(portalMessage)").font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Button(action: {
                    exitPortal()
                }) {
                    Text("< Back")
                        .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding()
                
                //Continue here
            }
        }
        
        if(visibleChest){
            VStack{
                Text("You found a chest!").font(.system(size: 30, weight: .bold, design: .monospaced))
                Text("💰").font(.system(size: 100, weight: .bold, design: .monospaced))
                
                Text("You found \(goldAmount) GOLD in there!").font(.system(size: 20, weight: .regular, design: .monospaced))
                Button(action: {
                  visiblePlot = true
                    visibleControls = true
                    visibleChest = false
                }) {
                    Text("OK")
                        .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding()
            }
        }
        
        else if(playerDied){
            VStack{
                Text("You Died!").font(.system(size: 30, weight: .bold, design: .monospaced)).padding()
                Text("😵").font(.system(size: 100, weight: .bold, design: .monospaced))
                
                Text("TIP: You can always flee from higher level enemies if they're too difficult to fight.").font(.system(size: 16, weight: .bold, design: .monospaced)).padding()
                
                Button(action: {
                    resetData()
                    backToMenu = true
                }) {
                    Text("OK")
                        .font(.system(size: 16, weight: .regular, design: .monospaced)) .frame(width: 100, height: 50)
                        .foregroundColor(.black)
                        .background(.white)
                }.padding()
            }
        }
        

    }
    
    func generateMap() {
        if(worldNumber == 3){
            plot = Array(repeating: Array(repeating: groundIcon, count: maxPlotX), count: maxPlotY)
            plot[10][10] = dragonIcon
            initialPlot = plot
            plot[0][0] = playerIcon
        }
        else{
            plot = Array(repeating: Array(repeating: groundIcon, count: maxPlotX), count: maxPlotY)
            
            // Replace some of the dots with a square of Vs
            grassStartX = Int.random(in: 1...(maxPlotX-grassSize))
            grassStartY = Int.random(in: 1...(maxPlotY-grassSize))
            grassSize = Int.random(in: 5...12)
            
            for x in grassStartX...(grassStartX + grassSize) {
                for y in grassStartY...(grassStartY + grassSize) {
                    if x < maxPlotX && y < maxPlotY {
                        plot[y][x] = grassIcon
                        
                    }
                }
            }
            
            let waterStartX = Int.random(in: 1...(maxPlotX-grassSize))
            let waterStartY = Int.random(in: 1...(maxPlotY-grassSize))
            let waterSize = Int.random(in: 3...7)
            
            for x in waterStartX...(waterStartX + waterSize) {
                for y in waterStartY...(waterStartY + waterSize) {
                    if x < maxPlotX && y < maxPlotY {
                        plot[y][x] = waterIcon
                        
                    }
                }
            }
            
            portalX = Int.random(in: 2...maxPlotX - 1)
            portalY = Int.random(in: 2...maxPlotY - 1)
            
            clinicX = Int.random(in: 2...maxPlotX - 1)
            clinicY = Int.random(in: 2...maxPlotY - 1)
            
            blacksmithX = Int.random(in: 2...maxPlotX - 1)
            blacksmithY = Int.random(in: 2...maxPlotY - 1)
            
            let numberOfEnemies = Int.random(in: 3...5)
            
            let chestChance = Int.random(in: 1...3)
            
            if(chestChance == 1){
                 chestX = Int.random(in: 2...maxPlotX - 1)
                 chestY = Int.random(in: 2...maxPlotY - 1)
                plot[chestX][chestY] = chestIcon
            }
            
            for i in 0...numberOfEnemies{
                let enemyX = Int.random(in: 2...maxPlotX - 1)
                let enemyY = Int.random(in: 2...maxPlotY - 1)
                
                enemiesX.append(enemyX)
                enemiesY.append(enemyY)
                
                plot[enemiesX[i]][enemiesY[i]] = enemyIcon
            }
            
            // Set the player's starting position
            plot[clinicX][clinicY] = clinicIcon
            
              
            while(plot[blacksmithX][blacksmithY] != groundIcon){
                blacksmithX = Int.random(in: 2...maxPlotX - 1)
                blacksmithY = Int.random(in: 2...maxPlotY - 1)
            }
            
             plot[blacksmithX][blacksmithY] = blacksmithIcon
            
            
            while(plot[portalX][portalY] != grassIcon){
                portalX = Int.random(in: 2...maxPlotX - 1)
                portalY = Int.random(in: 2...maxPlotY - 1)
            }
            
            plot[portalX][portalY] = portalIcon

            
           // plot[0][0] = "🆂"
            initialPlot = plot
            plot[0][0] = playerIcon
        }
        
    }
    
    func itemInitialization(){
        for _ in 0...maxSpace - 1{
            healthPocket.append(healingItem[0])
            armorPocket.append(armorItem[0])
            weaponPocket.append(attackItem[0])
        }
        healthPocket[0] = healingItem[2]

    }
    
    func initiateBattle(){
        visiblePlot = false
        visibleControls = false
        battleScreen = true
        visibleActionButtons = false
        visibleFinishBattleButton = false
        visibleNextButton = true
        inBattle = true
        
        if(!isBoss){
            let randomRobotNum = Int.random(in: 100...999)
            enemyName = "🤖Robot-R\(randomRobotNum)"
            if(worldNumber == 1){
                enemyLevel = Int.random(in: worldNumber...worldNumber * 3)
            }else if(worldNumber == 2){
                enemyLevel = Int.random(in: worldNumber * 2...worldNumber * 3)
            }
            if(worldNumber == 1){
                 enemyHealth = (40 + Int.random(in: -15...10) + 40 * enemyLevel)
            }else{
                enemyHealth = Int(Double(40 + Int.random(in: -15...10) + 40 * enemyLevel) * 1.35)
            }
            enemyMaxHealth = enemyHealth
            enemyAtk = 7 + (2 * enemyLevel) * worldNumber + Int.random(in: -3...3)
            enemyDef = 7 + (2 * enemyLevel) * worldNumber + Int.random(in: -3...3)
            dialogue = "You encountered with \(enemyName)"
        }else{
            enemyLevel = 6
            enemyName = "🐉Mecha Dragon"
            enemyHealth = 1500
            enemyMaxHealth = enemyHealth
            enemyAtk = 40
            enemyDef = 50
            dialogue = "You encountered with the Mecha Dragon!"
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
            visibleClinic = false
            visibleBlacksmith = false
            visiblePortalMenu = false
            visibleChest = false
        }
    }
    
    func buyItem(itemPos: Int, itemCategory: Int){
        if(itemCategory == 0){
            for i in 0..<maxSpace {
                if(healthPocket[i] == healingItem[0]){
                    healthPocket[i] = healingItem[itemPos]
                    playerGold -= itemToBuy.itemPrice
                    break
                }
            }
            
        }else if(itemCategory == 1){
            for i in 0..<maxSpace {
                if(weaponPocket[i] == attackItem[0]){
                    weaponPocket[i] = attackItem[itemPos]
                    playerGold -= weaponToBuy.itemPrice
                    break
                }
            }
        }else{
            for i in 0..<maxSpace {
                if(armorPocket[i] == armorItem[0]){
                    armorPocket[i] = armorItem[itemPos]
                    playerGold -= armorToBuy.itemPrice
                    break
                }
            }
        }
    }
    
    func visitClinic(){
        if(!visibleInventory){
            visibleClinic = true
            visiblePlot = false
            visibleControls = false
            sellerDialogue = "Receptionist: Welcome to the clinic! What do you need?"
        }
    }
    
    
    func visitBlacksmith(){
        if(!visibleInventory){
            visibleBlacksmith = true
            visiblePlot = false
            visibleControls = false
            sellerDialogue = "Blacksmith: Welcome to the my shop! What can I do for you?"
        }
    }
    
    func visitPortal(){
        if(!visibleInventory){
            visiblePortalMenu = true
            visiblePlot = false
            visibleControls = false
            portalMessage = ""
        }
    }
    
    func exitPortal(){
        visiblePortalMenu = false
        visiblePlot = true
        visibleControls = true
    }
    
    func openChest(){
        if(!visibleInventory){
            goldAmount = Int.random(in: 10 * playerLevel...10 * playerLevel + 20)
            playerGold += goldAmount
            playerX = chestX
            playerY = chestY
            initialPlot[playerX][playerY] = groundIcon
            movePlayer(xOffset: 0, yOffset: 0)
            buttonToggle = ""
        }
    }
    
    func goToNextWorld(){
        if(enemiesEliminated >= requiredEnemies && playerLevel >= requiredLevel){
            worldNumber += 1
            generateMap()
            portalMessage = ""
            visiblePlot = true
            visibleControls = true
            visiblePortalMenu = false
            playerX = 0
            playerY = 0
            requiredLevel += 2
            requiredEnemies += 4
        }else{
            portalMessage = "Please complete all the quests to enter portal."
        }
    }
    
    //Dialogue in battle
    
    func resetData(){
        //Player
        playerX = 0
        playerY = 0
        playerHealth = 100
        playerMaxHealth = 100
        playerDef = 5
        playerAtk = 10
        playerGold = 500
        maxSpace = 8
        playerEXP = 0
        playerRequiredEXP = 100
        playerLevel = 1
        playerDied = false
        
        worldNumber = 1
        
        //Player Inventory and Equipped Items
        itemInitialization()
        equippedWeapon = attackItem[0]
        equippedArmor = armorItem[0]
    }
    
    func movePlayer(xOffset: Int, yOffset: Int) {
        plot = initialPlot       
        
        if playerX + xOffset >= 0 && playerX + xOffset < maxPlotX && playerY + yOffset >= 0 && playerY + yOffset < maxPlotY {
            if plot[playerX + xOffset][playerY + yOffset] == waterIcon && equippedArmor.itemId != 1{
                
            }else{
                playerX += xOffset
                playerY += yOffset
            }
        }
        
        
        plot[playerX][playerY] = playerIcon
        
        //detect tiles
        switch initialPlot[playerX][playerY] {
        case grassIcon:
            print("Stepped on grass")
            let fightChance = Int.random(in: 1...10)
            if(fightChance == 1){
                initiateBattle()
            }
            buttonToggle = ""
        case waterIcon:
            let fightChance = Int.random(in: 1...10)
            if(fightChance == 1){
                initiateBattle()
            }
            buttonToggle = ""
        case enemyIcon:
            isBoss = false
            initiateBattle()
            initialPlot[playerX][playerY] = groundIcon
            buttonToggle = ""
        case portalIcon:
            //visitPortal()
            print("Portal")
            buttonToggle = "Portal"
        case clinicIcon:
            print("Clinic")
            //visitClinic()
            buttonToggle = "Clinic"
        case blacksmithIcon:
            print("Blacksmith")
            //visitBlacksmith()
            buttonToggle = "Blacksmith"
        case dragonIcon:
            isBoss = true
            initiateBattle()
        case chestIcon:
            buttonToggle = "Chest"

            
        default:
            buttonToggle = ""
            
        }
        
        
    }
    
    
}

