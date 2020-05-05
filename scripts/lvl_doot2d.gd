extends Node2D

var array_initialPos = [75, 75, 725, 75, 75, 430, 725, 430]

func _process(_delta):
    #do framerate
    globals.get_node("Framerate").text = globals.g_fps

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    #sceneChanger.connect("sig_sceneChanged", self, "showPlayers")
    # update the collision box so it matches the field frame
    # get_node("../walls").growFieldCollision(0)
    
    # move the players to the doot2d origins. 
    # First hide them all:
    #for item in ctrl_players_ui.get_node("players").get_children():
        #item.visible = false
    # then move to initial positions in Sumo
        #gotoInit(item)
               
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
            item.currentLevel = "doot2d"
