extends CharacterBody2D
class_name Player

var speed = 450.0
var jump_force = 650.0
var gravity = 1400
var max_fire_force = 1000

@onready var pistol: Sprite2D = $Pistol
@onready var boca: Marker2D = $Pistol/Boca

var direction :float = 0
var last_direction :float = 0
var fire_force = Vector2.ZERO
var spin_force: float = 0

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left","right")
	if direction != 0:
		last_direction = direction
	#print((global_position.direction_to(get_global_mouse_position()).rotated(deg_to_rad(90)).angle()))

	if Input.is_action_pressed("spin"):
		spin_force += 1
	else:
		spin_force -= .5
	spin_force = clamp(spin_force,0,100)
	
	if spin_force != 0:
		pistol.rotate(deg_to_rad(spin_force/2))
	else:
		set_pistol_rotation(global_position.direction_to(get_global_mouse_position()))
	#print(spin_force)
func set_pistol_rotation(direction_to_aim):
	pistol.scale.y = 2*int(direction_to_aim.rotated(deg_to_rad(90)).angle() > 0)-1
	pistol.rotation = direction_to_aim.angle()
	$Sprite.flip_h = direction_to_aim.rotated(deg_to_rad(90)).angle() < 0
	# moça, TUDO q tem aq embaixo, separa entre os states
	
