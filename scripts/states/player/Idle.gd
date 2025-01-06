extends PlayerState

func physics_update(delta: float) -> void:
	if player.direction != 0:
		state_machine.transition_to("Walk")
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air",{jump=true})
	
	if Input.is_action_just_pressed("fire"):
		state_machine.transition_to("Recoil")
