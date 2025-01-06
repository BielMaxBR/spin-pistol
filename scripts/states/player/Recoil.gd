extends PlayerState


# essa bagaça faz o tiro também, eu sei, é bizarro
func enter(msg:={}):
		var direction = player.global_position.direction_to(player.get_global_mouse_position())
		var force = player.max_fire_force* (player.spin_force/100)
		if force == 0:
			force = 50 # pra sempre ter uma forcinha
		player.fire_force = (direction * -1) * force
		player.set_pistol_rotation(direction)
		var size = (player.spin_force/100 * 0.7) + 0.3 # size minimo de 30%
		player.spin_force = 0
		Spawner.spawn_fire(player.boca.global_position, direction.angle(), player.get_parent(), size)
		
func physics_update(delta: float):
	player.spin_force = 0
	player.fire_force *= 0.9 # resistencia
	if player.fire_force.length() <= 20:
		player.fire_force = Vector2.ZERO
	
	if player.fire_force.length() > player.max_fire_force * 0.2: # 20% do poder total é o suficiente pra voltar ao comando
		player.velocity = player.fire_force
	else:
		if player.is_on_floor():
			if player.direction == 0:
				state_machine.transition_to("Idle")
			else:
				state_machine.transition_to("Walk")
		else:
			state_machine.transition_to("Air")
	
	player.move_and_slide()
