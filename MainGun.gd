class_name MainGun;

extends Sprite2D

@export var BULLET: PackedScene;
@export var FIRE_RATE = 0.5;
@export var bullet_speed = 1000;
@onready var marker = %Marker2D
@onready var audio = $AudioStreamPlayer

var can_shoot = true;

func _ready():
	pass
	
func _process(delta):
	pass
	
func aimAt(direction):
	var target_rotation_degrees = direction.angle() * 180 / PI
	var new_rot = lerp_angle(rotation_degrees, target_rotation_degrees, 5)
	rotate(deg_to_rad(new_rot - rotation_degrees) * 4)
	look_at(direction);
	rotation_degrees += 90;
# Helper function to interpolate angles
func lerp_angle(a, b, t):
	return (1.0 - t) * a + t * b
	
func shoot():
	if (!can_shoot): return;

	if(!BULLET):
		print("You need to instantiated a bullet!")
		return;
		
	var bullet  = BULLET.instantiate()
	bullet.add_group_to_area("friendly")
	bullet.position = marker.get_global_position()
	bullet.rotation_degrees = rotation_degrees + get_parent().rotation_degrees;
	
	var direction = Vector2(0, 1).rotated(rotation + get_parent().rotation) * -1
	bullet.apply_impulse(direction * bullet_speed, Vector2.ZERO)
	audio.play()
	get_tree().get_root().add_child(bullet)
	
	can_shoot = false
	await get_tree().create_timer(FIRE_RATE).timeout;
	can_shoot = true
	

