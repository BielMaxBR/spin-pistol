extends PlayerState


func enter(msg:={}):
	if msg.has("jump"):
		player.velocity.y = -player.jump_force

func physics_update(delta: float):
	
	player.velocity.y += player.gravity * delta
	
	if player.spin_force > 0:
		var resistance = player.gravity/10 - (player.spin_force)
		player.velocity.y = clampf(player.velocity.y,-player.gravity, resistance)
	
	var force = player.direction * player.speed
	player.velocity.x = force
	
	if Input.is_action_just_released("jump") and player.velocity.y <= 0:
		player.velocity.y = -13 # hehe lulinha
	
	player.move_and_slide()
	if player.is_on_floor():
		if is_equal_approx(player.direction, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
	
	if Input.is_action_just_pressed("fire"):
		state_machine.transition_to("Recoil")
