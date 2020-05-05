extends Node2D

var array_initialPos = [75, 75, 725, 75, 75, 430, 725, 430]

func _process(_delta):
    #do framerate
    globals.get_node("Framerate").text = globals.g_fps

# Called when the node enters the scene tree for the first time.
func _ready():
    sceneChanger.connect("sig_sceneChanged", self, "showPlayers")
    # update the collision box so it matches the field frame
    get_node("../walls").growFieldCollision(0)
    
    # move the players to the SUMO origins. 
    # First hide them all:
    for item in ctrl_players_ui.get_node("players").get_children():
        item.visible = false
    # then move to initial positions in Sumo
        gotoInit(item)
               
func gotoInit(player):
    var device = player.playerNumber
    # store initial values for Sumo
    player.inPos = Vector2(array_initialPos[device * 2], array_initialPos[(device * 2) + 1])
    # move the player to initial value
    player.position = player.inPos
    # load player color
    player.modulate = player.ballColor

func showPlayers():
    # Show the active ones:
    for item in ctrl_players_ui.get_node("players").get_children():
        if item.isSpawned == 1:
            item.visible = true
            item.isReady = 0
            item.get_node("power").visible = true
            # connect 1 second timer
            get_node("../powerTimers/second%s" % item.playerNumber).connect("timeout", self, "_on_sec_timeout", [item.playerNumber])
            item.connect("collided", self, "_on_collision")
            item.currentLevel = "sumo"

func _on_sec_timeout(pNumb):
    var item = ctrl_players_ui.get_node("players/player%s" % pNumb)
    if ((item.isSpawned == 1) && (item.powerLvl < 99)):
        item.powerLvl += 1

func _on_collision(pNumb):
    # player colided! re-start timer
    get_node("../powerTimers/second%s" % pNumb).start()
    pass
