
extends Node2D

var speed = 300
var movedir = Vector2(0,0)
var aimdir = Vector2(0,0)

# assigned in controller script when active
var playerNumber = 0
var isSpawned = 0
# when 0 the player "tests controlls". when 1 it's ready to go and can't move.
var isReady = 0
var randoColorBall = 0
var currentLevel

var inPos = Vector2(0,0)
var ballColor = Color(0, 0, 0, 1)

var powerLvl = 0

var body1
var body2

signal collided(pNumb)

func _ready():
    pass
    
func _physics_process(_delta):
    move(currentLevel)
    doSelfValues(currentLevel)
      
func is_ready(color):
    isReady = 1
    modulate = color

func move(lvl):
    match lvl:
        "doot2d":
            # calculate R stick direction
            aimdir.x = -Input.get_action_strength("dev%s_RightJoystick_left" % playerNumber) + Input.get_action_strength("dev%s_RightJoystick_right" % playerNumber)
            aimdir.y = +Input.get_action_strength("dev%s_RightJoystick_down" % playerNumber) - Input.get_action_strength("dev%s_RightJoystick_up" % playerNumber)
        
            #var aimAngle = aimdir.angle()
            if (aimdir.y != 0) || (aimdir.x != 0):
                #change sprite to arrow ball
                #$ball.set_texture(tex_ball_arrow)
                #apply rotation
                rotation = aimdir.angle()
            else:
                pass #$ball.set_texture(tex_ball)
        _:
            #calculate movement from left joystick
            movedir.x = -Input.get_action_strength("dev%s_LeftJoystic_left" % playerNumber) + Input.get_action_strength("dev%s_LeftJoystic_right" % playerNumber)
            movedir.y = +Input.get_action_strength("dev%s_LeftJoystic_down" % playerNumber) - Input.get_action_strength("dev%s_LeftJoystic_up" % playerNumber)
            var velocity = movedir.clamped(1) * speed
            if ((velocity.x == 0) && (velocity.y == 0)):
                #if there's no direction from analog sticks try d-pad
                movedir.x = -Input.get_action_strength("dev%s_btn_14" % playerNumber) + Input.get_action_strength("dev%s_btn_15" % playerNumber)
                movedir.y = +Input.get_action_strength("dev%s_btn_13" % playerNumber) - Input.get_action_strength("dev%s_btn_12" % playerNumber)
                velocity = movedir.clamped(1) * speed
            
            #apply movement
            if (isReady == 0):
                velocity = body1.move_and_slide(velocity)
                if body1.get_slide_count() != 0 :
                    powerLvl = 0
                    emit_signal("collided", playerNumber)

func doSelfValues(lvl):
    match lvl:
        "sumo":
            if((isSpawned == 1) && (powerLvl < 99)):
                pass #$power.text = String(powerLvl)
