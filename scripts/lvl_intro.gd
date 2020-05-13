extends Node2D

var tex_array = [preload("res://assets/P1.png"), 
                 preload("res://assets/P2.png"), 
                 preload("res://assets/P3.png"), 
                 preload("res://assets/P4.png"), 
                 preload("res://assets/P_hold.png")]
var tex_ball_arrow
var tex_ball
var gold = Color (0.83, 0.69, 0.22, 1)
var playersReady = 0
var minPlayers = 1

func _process(_delta):
    #do framerate
    globals.get_node("Framerate").text = globals.g_fps

func _ready():
    $start_circle/sc_sprite.modulate = gold
    $start_circle.connect("body_entered", self, "_on_body_enter")
    
func _on_body_enter(body):
    if body.get_parent().has_method("is_ready"):
        body.get_parent().is_ready(gold)
        playersReady += 1
        if playersReady >= minPlayers:
            get_node("lbl_gameReady").visible = true 

func _input(event):
    var device = event.device
    var playersNode = get_node("../players")
    
    if event.is_action_pressed("dev%s_btn_0" % device):
        #player n joins the game
        playersNode.addPlayer(device)
        
                
    if event.is_action_pressed("dev%s_btn_1" % device):
        #player n has left the game
        playersNode.doLeaveGame(device)
    
    if event.is_action_pressed("dev%s_btn_11" % device):
        if playersReady >= minPlayers:
            print("Let's play!")
            sceneChanger.change_scene("res://doot2d.tscn")

func doJoinLeave(pNode, inOut):
    if inOut == 1:
        match pNode.playerNumber:
            0:
                $avatars/frame1.texture = tex_array[pNode.playerNumber] 
            1:
                $avatars/frame2.texture = tex_array[pNode.playerNumber]
            2:
                $avatars/frame3.texture = tex_array[pNode.playerNumber]
            3:
                $avatars/frame4.texture = tex_array[pNode.playerNumber]
    elif inOut == 0:
        if(pNode.isReady == 1):
            playersReady -= 1
        match pNode.playerNumber:
            0:
                $avatars/frame1.texture = tex_array[4]
            1:
                $avatars/frame2.texture = tex_array[4]
            2:
                $avatars/frame3.texture = tex_array[4]
            3:
                $avatars/frame4.texture = tex_array[4]
        if playersReady < minPlayers:
            get_node("lbl_gameReady").visible = false

