extends Sprite2D;

var MOVE_SPEED = 0;
var ROTATE_SPEED = 1.5;
@onready var collision_shape_2d = $"../CollisionShape2D"

func _process(delta):
	if Input.is_action_pressed("up"):
		position += Vector2(0,-1).rotated(rotation) * MOVE_SPEED;
	if Input.is_action_pressed("down"):
		position += Vector2(0,1).rotated(rotation) * MOVE_SPEED;
	if Input.is_action_pressed("right"):
		rotation_degrees += 1 * ROTATE_SPEED;
	if Input.is_action_pressed("left"):
		rotation_degrees -= 1 * ROTATE_SPEED;
	#collision_shape_2d.position = position
func _physics_process(delta):
	collision_shape_2d.position = position
	
