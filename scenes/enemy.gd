class_name Enemy;
extends Sprite2D

signal death;
@export var death_explosion: PackedScene
@onready var player: Player = get_tree().current_scene.get_node("Player");
@onready var gameManager = get_tree().get_root().get_node("GameManager")
var t = 0.0;
var speed = randf_range(0.05, 0.15);
var damage: float = 20;


func _process(delta):
	if(is_instance_valid(player)):
		look_at(player.tank.global_position)
		chase(delta)
	else:
		#print("Player is DEAD!")
		pass
	
func chase(delta):
	t += delta * 0.4
	#var playerDirection = global_position.direction_to(player.tank.global_position)
	var pos = position.lerp(player.tank.global_position, t * speed);
	position = pos;



func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if(area.is_in_group("player")):
		explode()
	
	if(area.is_in_group("bullet")):
		queue_free()
		player.emitKill(50)
		death.emit(50)
		#gameManager.updateScore(50)

func explode():
	var explosion = death_explosion.instantiate(); 
	explosion.position = global_position;
	explosion.rotation = global_rotation;
	explosion.emitting = true;
	get_tree().current_scene.add_child(explosion)
	queue_free()
