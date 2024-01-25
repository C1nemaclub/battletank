class_name Bullet;

extends RigidBody2D

@export var explosion: PackedScene;
@onready var visible_on_screen_notifier = $VisibleOnScreenNotifier2D
@export var damage = 10;

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	#print("jllo")if !body.is_in_group("player"):
	print("hello")


func _on_visible_on_screen_notifier_2d_screen_exited():
	explode()
	


func _on_area_2d_body_entered(body):
	if (!body.is_in_group("player")):
		#explode()
		pass
		
	
		
func explode():
	var exp = explosion.instantiate();
	exp.position = global_position;
	get_tree().get_root().add_child(exp)
	queue_free()
	
func add_group_to_area(group):
	$Area2D.add_to_group(group)


func _on_area_2d_area_entered(area):
	if(!area.is_in_group("bullet") and !area.is_in_group("player")):
		explode()
