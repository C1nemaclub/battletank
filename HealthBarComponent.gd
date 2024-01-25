class_name HealthBarComponent;
extends Node2D

@export var HealthComponent: HealthComponent;
@onready var progress = %TextureProgressBar
@export var health_value: float;

func _on_health_component_health_changed(old_value, new_value):
	health_value = new_value;
	progress.value = health_value;
