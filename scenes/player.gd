class_name Player;

extends Node2D

signal onKill;
signal playerDeath;

@export var Health: HealthComponent;
@export var death_explosion: PackedScene;
@export var MOVE_SPEED: int = 0;
@onready var health_bar = $CanvasLayer/HealthBar
@export var main_gun: MainGun;
@onready var animation_player = %AnimationPlayer
@onready var tank = $Tank

func _ready():
	tank.MOVE_SPEED = MOVE_SPEED;
	
func _process(delta):
	if Input.is_action_pressed("fire"):
		main_gun.shoot()
	main_gun.aimAt(get_global_mouse_position())
	
func _on_health_component_has_died():
	playerDeath.emit()
	explode()
	
func _on_health_component_health_changed(old_value, new_value):
	health_bar.value = new_value;
	$CanvasLayer/HealthB.value = new_value;
	animation_player.play("hit")
	

func _on_area_2d_body_entered(body):
	print(body.is_in_group("bullet"))
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet") and !area.is_in_group("friendly"):
		Health.takeDamage(20)
	if area.is_in_group("enemy"):
		var enemy: Enemy = area.get_parent();
		Health.takeDamage(enemy.damage)
		$Tank/Camera2D.apply_shake()
		
		
func explode():
	Engine.time_scale = 0.1;
	var explosion = death_explosion.instantiate(); 
	explosion.global_position = tank.global_position;
	explosion.rotation = tank.global_rotation;
	explosion.emitting = true;
	get_tree().get_root().add_child(explosion)
	queue_free()
	
func emitKill(score: int):
	onKill.emit(score)
	$Tank/Camera2D.apply_shake()
	
func slowMo(duration: float = 0.5, strength: float = 0.5):
	Engine.time_scale = strength;
	await get_tree().create_timer(duration).timeout;
	Engine.time_scale = 1.0;
