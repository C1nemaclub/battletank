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


# Called when the node enters the scene tree for the first time.
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
	animation_player.play("hit")


func _on_area_2d_body_entered(body):
	print(body.is_in_group("bullet"))
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet") and !area.is_in_group("friendly"):
		Health.takeDamage(20)
	if area.is_in_group("enemy"):
		Health.takeDamage(20)
		
func explode():
	var explosion = death_explosion.instantiate(); 
	explosion.global_position = tank.global_position;
	explosion.rotation = tank.global_rotation;
	explosion.emitting = true;
	get_tree().get_root().add_child(explosion)
	queue_free()
	
func emitKill(score: int):
	onKill.emit(score)
