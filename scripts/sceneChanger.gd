extends CanvasLayer

signal sig_sceneChanged()

onready var animation_player = $AnimationPlayer
onready var bleck = $Control/Bleck

func change_scene(path, delay = .5):
    yield(get_tree().create_timer(delay), "timeout")
    animation_player.play("fade")
    yield(animation_player, "animation_finished")
    assert(get_tree().change_scene(path) == OK)
    animation_player.play_backwards("fade")
    yield(animation_player, "animation_finished")
    yield(get_tree().create_timer(delay), "timeout")
    emit_signal("sig_sceneChanged")
