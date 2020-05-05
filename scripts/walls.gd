extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func growFieldCollision(level):
    match level:
        0:
            # SUMO
            # move and scale the collision elements so they match the new frame
            $wall_left/collision.position = Vector2(-189, 0)
            $wall_right/collision.position = Vector2(-32, 0)
            $wall_up/collision.position = Vector2(-110, 0)
            $wall_down/collision.position = Vector2(-110, 0)
            
            $wall_up/collision.scale = Vector2(1.3, 1)
            $wall_down/collision.scale = Vector2(-1.3, 1)
            
            # play animation that grows the "playing field" frame
            $AnimationPlayer.play("growField")
