extends Sprite2D

@onready var Bullet = preload("res://scenes/bullet.tscn");

var BULLET: PackedScene; 
@onready var gun_marker = $Marker2D
@onready var tank = $".."
@onready var fire_cooldown = %ProgressBar

const BULLET_SPEED = 3000;
const FIRE_RATE = 0.05;
var can_fire = true;


func _process(delta):
	rotation_degrees += 90
	#if Input.is_action_pressed("fire") and can_fire:
		#shoot();
	pass

func shoot():
	if !can_fire:
		return;
	var bullet = BULLET.instantiate();
	
	bullet.position += gun_marker.get_global_position()
	bullet.rotation_degrees += self.rotation_degrees + tank.rotation_degrees;
	
	var shoot_direction = (Vector2(0,1)
		.rotated(self.rotation + tank.rotation) * BULLET_SPEED) * -1
	
	bullet.apply_impulse(shoot_direction, Vector2.ZERO)
	get_tree().get_root().add_child(bullet);
	
	fire_cooldown.set_value_no_signal(0);
	can_fire = false;
	await get_tree().create_timer(FIRE_RATE).timeout;
	fire_cooldown.play_animation()

func _on_progress_bar_animation_done():
	can_fire = true;
