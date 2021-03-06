//
//  GameScene.swift
//  CagesFarm
//
//  Created by Gilberto Magno on 3/8/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

// swiftlint:disable unused_optional_binding cyclomatic_complexity
class GameScene: SKScene, DialogueBoxDelegate, ImageRetriever {
    var closeCallbackToMenu: (() -> Void)?
    
    let keys = Items(itemType: .keys)
    let knifer = Items(itemType: .knife)
    let contract = Items(itemType: .contract)
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var backgroundSound: AVAudioPlayer?

    @UserDefaultsWrapper(key: .isSoundOn, defaultValueForKey: true)
    var isSoundOn: Bool

    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var tony = Characters(characterType: .tony)
    private var quadro = InteractableObjects(objectType: .quadro)
    private var bau = InteractableObjects(objectType: .bau)
    private var cama = InteractableObjects(objectType: .cama)
    private var comoda = InteractableObjects(objectType: .comoda)
    var interruptor = InteractableObjects(objectType: .interruptor)
    private var tapete = InteractableObjects(objectType: .tapete)
    private var quadroPerspectiva = InteractableObjects(objectType: .quadroPerspectiva)
    private var door = InteractableObjects(objectType: .door)
    private var dialogBox = DialogueBox()
    private var background = SKSpriteNode(imageNamed: "quartoBackground")
    lazy var blackOverlay = SKSpriteNode(color: .black, size: frame.size)

    var inventory = Inventory(items: [])
    private var lastInteraction: LastInteraction?
    
    override func sceneDidLoad() {
        background.texture = SKTexture(image: image(.quartoBackground))
        background.size = SKTexture(image: image(.quartoBackground)).size()
        SceneCoordinator.coordinator.gameScene = self
        setupNodes()
        dialogBox.delegate = self
        configureZPositions()
        customizeNodes()

        if isSoundOn { loadBackgroundAudio() }
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIScene.willDeactivateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)

        animates()
    }

    private func loadBackgroundAudio() {
        let data = NSDataAsset(name: "Mysterious")!.data

        do {
            backgroundSound = try AVAudioPlayer(data: data)
            backgroundSound?.numberOfLoops = -1
            backgroundSound?.play()
        } catch {
            // Error("Can not read sound.")
        }
    }

    @objc private func willResignActive() {
        backgroundSound?.pause()
    }

    @objc private func willEnterForeground() {
        backgroundSound?.play()
    }

    private func setupNodes() {
        self.scaleMode = .aspectFit
        self.addChild(tony)
        self.addChild(quadro)
        self.addChild(background)
        self.addChild(bau)
        self.addChild(comoda)
        self.addChild(interruptor)
        self.addChild(tapete)
        self.addChild(cama)
        self.addChild(quadroPerspectiva)
        self.addChild(inventory)
        self.addChild(door)
        self.addChild(blackOverlay)
        
        dialogBox.delegate = self
        background.zPosition = -1
        tony.zPosition = +1
        dialogBox.zPosition = +1

        let data = NSDataAsset(name: "Mysterious")!.data
        
        do {
            backgroundSound = try AVAudioPlayer(data: data)
            backgroundSound?.numberOfLoops = -1
            backgroundSound?.play()
        } catch {
            //Error("Can not read sound.")
        }
    }

    private func configureZPositions() {
        background.zPosition = -1
        tony.zPosition = +3
        dialogBox.zPosition = +4
        interruptor.zPosition = +2
        blackOverlay.zPosition = +1
    }

    private func customizeNodes() {
        blackOverlay.alpha = 0.9
    }

    private func buildSprite() -> [SKTexture] {
      var frames: [SKTexture] = []

      for index in 0...24 {
        let frame = SKTexture(imageNamed: "tony_getting_up_sprite_\(String(format: "%02d", index))")
        frames.append(frame)
      }
        return frames
    }

    private func animates() {
        let frames: [SKTexture] = buildSprite()

        let startedAnimation = SKAction.run {
            self.tony.isWalking = true
        }

        let endedAnimation = SKAction.run {
            self.tony.isWalking = false
        }

        let animation = SKAction.animate(with: frames, timePerFrame: 0.2)
        let sequence = SKAction.sequence([startedAnimation, animation, endedAnimation])
        tony.run(sequence)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        quadro.setScale(1)
        quadroPerspectiva.yScale = 2
        quadroPerspectiva.xScale = 1.6
        comoda.setScale(0.45)

        // Positions
        tony.position = CGPoint(x: 240, y: -35)
        tony.xScale = -1
        tony.size = CGSize(width: 120, height: 120)
        cama.position = CGPoint(x: -255, y: -115)
        cama.setScale(0.8)
        quadro.position = CGPoint(x: 120, y: 80)
        tapete.position = CGPoint(x: -25, y: -120)
        tapete.setScale(2)
        comoda.position = CGPoint(x: 120, y: -20)
        quadroPerspectiva.position = CGPoint(x: -250, y: 45)
        interruptor.position = CGPoint(x: 280, y: 20)
        bau.position = CGPoint(x: -150, y: -43)
        door.position = CGPoint(x: -25, y: 16)
        door.setScale(0.6)
    }
    
    func interactionObject(pos: CGPoint) {

        guard let objectInTouch = atPoint(pos) as? InteractableObjects else {

            let object = atPoint(pos)
            if object is DialogueBox {

                self.dialogBox.removeFromParent()
                tony.isWalking = false
            } else if object.isKind(of: SKSpriteNode.self) {

                guard let newObject = object as? SKSpriteNode else {return}
                if newObject.color == UIColor(red: 0, green: 0, blue: 0, alpha: 0) {
                    self.dialogBox.removeFromParent()
                    tony.isWalking = false
                }
                
            }
            
            return
        }

        objectInTouch.updateAnswersArray()
        
        if  objectInTouch.objectType == .comoda, objectInTouch.isCloseInteract {
            if let shouldShowPuzzle = SceneCoordinator.coordinator.shouldShouldKeyboardPuzzle {
                if shouldShowPuzzle {
                    objectInTouch.actualAnswer = 2
                } else {
                    objectInTouch.actualAnswer = 3
                }
            }
        }

        if objectInTouch.objectType == .interruptor {
            if !SceneCoordinator.coordinator.shouldShowInterrupterScene {
                SceneCoordinator.coordinator.shouldShowInterrupterScene = true
            } else {
                if SceneCoordinator.coordinator.entryPuzzleScenes["interrupter"]! {
                    dialogBox.removeFromParent()
                    let transition: SKTransition = SKTransition.fade(withDuration: 0)
                    let scene: SKScene = InterrupterScene(size: UIScreen.main.bounds.size)
                    scene.anchorPoint = .init(x: 0.5, y: 0.5)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
        
        if objectInTouch.isCloseInteract {
            // MUDAR PRA TORNAR MAIS AUTOMATICO PRA TODOS OBJETOS
            tony.isWalking = false
            if dialogBox.parent == nil {

                let actualAnswerID = objectInTouch.actualAnswer
                self.addChild(dialogBox)
                guard let answer = objectInTouch.answers else {return}
                self.dialogBox.nextText(answer: answer[actualAnswerID])
                lastInteraction = nil
                lastInteraction = LastInteraction(objectType: objectInTouch,
                                                  currentAnswer: objectInTouch.actualAnswer)
                if objectInTouch.canProceedInteraction {
                    objectInTouch.nextDialogue()
                    
                }
            }
        }
    }
    
    func makeMCWalk(pos: CGPoint) {

        let itIsInventory = atPoint(pos)
        if !(itIsInventory is Inventory) && !(itIsInventory is SKShapeNode) && !(itIsInventory is DialogueBox) {
            if !tony.isWalking && pos.x < tony.frame.minX {
                tony.xScale = -1
            } else if !tony.isWalking && pos.x >= tony.frame.minX {
                tony.xScale = +1
            }
            if !tony.isWalking {
                tony.walk(posx: pos.x,gameScene: self)
            }
        }
    }
    
    func didShowDialog(currentDialog: Int, object: InteractableObjects) {
        switch object.objectType {
        case .comoda:
            handleComodaTouch(currentDialog: currentDialog, comoda: object)
        case .bau:
            handleChestTouch(bau: object)
        case .door:
            handleExitRoomTouch()
        default:
            break
        }
    }
    
    func didFinishShowingText() {
        if let lastInteraction = lastInteraction {
            didShowDialog(currentDialog: lastInteraction.currentAnswer,
                          object: lastInteraction.objectType)
        }
    }
    
    private func handleComodaTouch(currentDialog: Int, comoda: InteractableObjects) {
        self.tony.isWalking = false
        let coordinator = SceneCoordinator.coordinator
        if currentDialog == 1 {
            if coordinator.shouldAddKnife {
                guard let kniferItem = SceneCoordinator.coordinator.gameScene?.knifer else { return }
                coordinator.addItemToInventory(item: kniferItem)
                coordinator.shouldAddKnife = false
            }
        }
        
        if currentDialog == 2 && coordinator.shouldShouldKeyboardPuzzle == nil {
            coordinator.shouldShouldKeyboardPuzzle = true
        }
        
        comoda.canProceedInteraction = !(coordinator.shouldShouldKeyboardPuzzle ?? false)
        
        if coordinator.shouldShouldKeyboardPuzzle ?? false {
            dialogBox.removeFromParent()
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = DresserKeyboard(size: UIScreen.main.bounds.size)
            scene.anchorPoint = .init(x: 0.5, y: 0.5)
            self.view?.presentScene(scene, transition: transition)
        }
    }

    private func handleChestTouch(bau: InteractableObjects) {
        tony.isWalking = false
        if SceneCoordinator.coordinator.entryPuzzleScenes["colors"]! {
            dialogBox.removeFromParent()
            let transition: SKTransition = SKTransition.fade(withDuration: 1)
            let scene: SKScene = PuzzleScene(size: UIScreen.main.bounds.size)
            scene.anchorPoint = .init(x: 0.5, y: 0.5)
            backgroundSound?.stop()
            self.view?.presentScene(scene, transition: transition)
        } else {
            dialogBox.removeFromParent()
            let transition: SKTransition = SKTransition.fade(withDuration: 1)
            let scene: SKScene = OpenedTrunkScene(size: UIScreen.main.bounds.size)
            scene.anchorPoint = .init(x: 0.5, y: 0.5)
            backgroundSound?.stop()
            self.view?.presentScene(scene, transition: transition)
        }
    }

    private func handleExitRoomTouch() {
        self.tony.isWalking = false
        if SceneCoordinator.coordinator.gameScene!.inventory.items.contains(keys) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene = HallScene(size: UIScreen.main.bounds.size)
            scene.anchorPoint = .init(x: 0.5, y: 0.5)
            scene.closeCallbackToMenu = closeCallbackToMenu
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        // TRANSICAO DE CENA, FALTA COLOCAR A PORTA PARA ISSO OCORRER COM ELA
        //        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        //        let scene:SKScene = HallwayScene(size: UIScreen.main.bounds.size)
        //        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        //        self.view?.presentScene(scene, transition: transition)
        let walkBeforeTalk = SKAction.run {
            self.makeMCWalk(pos: pos)
            self.tony.zPosition = -1
            self.dialogBox.zPosition = -1
        }

        let talkAfterWalk = SKAction.run {
            self.interactionObject(pos: pos)
            self.tony.zPosition = +1
            self.dialogBox.zPosition = +1
        }
        
        let sequence = SKAction.sequence([walkBeforeTalk,talkAfterWalk])
        self.run(sequence)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        quadro.microInteraction(player: tony)
        interruptor.microInteraction(player: tony)
        quadroPerspectiva.microInteraction(player: tony)
        tapete.microInteraction(player: tony)
        cama.microInteraction(player: tony)
        comoda.microInteraction(player: tony)
        bau.microInteraction(player: tony)
        door.microInteraction(player: tony)
        if !(dialogBox.parent == nil){
            
            tony.isWalking = true
        }
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
