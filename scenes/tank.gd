extends Sprite2D

var MOVE_SPEED = 0;
var ROTATE_SPEED = 1.5;

func _process(delta):
	if Input.is_action_pressed("up"):
		position += Vector2(0,-1).rotated(rotation) * MOVE_SPEED;
	if Input.is_action_pressed("down"):
		position += Vector2(0,1).rotated(rotation) * MOVE_SPEED;
	if Input.is_action_pressed("right"):
		rotation_degrees += 1 * ROTATE_SPEED;
	if Input.is_action_pressed("left"):
		rotation_degrees -= 1 * ROTATE_SPEED;
