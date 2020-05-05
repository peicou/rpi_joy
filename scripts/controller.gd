extends Node2D

var devicesConnected = [0, 0, 0, 0]
signal sig_controllerUnplugged(device_id)
signal sig_controllerPlugged(device_id)

func _ready():
    doAvailableControllers()
    Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

#Called whenever a joypad has been connected or disconnected.
func _on_joy_connection_changed(device_id, connected):
    if connected:
        emit_signal("sig_controllerPlugged", device_id)
        if devicesConnected[device_id] == 0:
            devicesConnected[device_id] = 1
            match device_id:
                0:
                    $balls/available1.modulate = Color (1, 1, 1, 1)
                1:
                    $balls/available2.modulate = Color (1, 0, 0, 1)
                2:
                    $balls/available3.modulate = Color (0, 1, 0, 1)
                3:
                    $balls/available4.modulate = Color (0, 0, 1, 1)
    else:
        devicesConnected[device_id] = 0
        emit_signal("sig_controllerUnplugged", device_id)
        match device_id:
            0:
                $balls/available1.modulate.a = 0.25
            1:
                $balls/available2.modulate.a = 0.25
            2:
                $balls/available3.modulate.a = 0.25
            3:
                $balls/available4.modulate.a = 0.25

func _input(event):
    if event.is_action_pressed("dev%s_btn_10" % event.device):
        print("Thanks for playing!")
        get_tree().quit()

func doAvailableControllers():
    # get connected devices
    var connected = Input.get_connected_joypads()
    for i in range(0,  connected.size()):
            devicesConnected[i] = 1
    
    # color balls depending on available controllers
    $balls/available1.modulate.a = 0.25 if devicesConnected[0] == 0 else 1.0
    $balls/available2.modulate = Color (1, 0, 0, 0.25) if devicesConnected[1] == 0 else Color (1, 0, 0, 1)
    $balls/available3.modulate = Color (0, 1, 0, 0.25) if devicesConnected[2] == 0 else Color (0, 1, 0, 1)
    $balls/available4.modulate = Color (0, 0, 1, 0.25) if devicesConnected[3] == 0 else Color (0, 0, 1, 1)

