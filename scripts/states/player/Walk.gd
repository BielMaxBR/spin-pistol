extends PlayerState

func physics_update(delta: float) -> void:
	var force = player.direction * player.speed
	player.velocity.x = force - (force/2 * (player.spin_force/100))
	
	player.move_and_slide()
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air",{jump=true})
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	if force == 0:
		state_machine.transition_to("Idle")
	
	if Input.is_action_just_pressed("fire"):
		state_machine.transition_to("Recoil")
