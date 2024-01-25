class_name HealthComponent;

extends Node2D

signal hasDied;
signal health_changed(old_value, new_value);

@export var max_health: float = 100;
var current_healt: float;

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Max Health: ", max_health);
	initializeHealth();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func initializeHealth():
	current_healt = max_health;
	
func takeDamage(value: float):
	var old_health = current_healt;
	current_healt -= value;
	if(current_healt <= 0):
		hasDied.emit()
	health_changed.emit(old_health, current_healt);
	
	

