class_name PlayerCamera;
extends Camera2D

var randomStrenght: float = 15.0;
var shakeFade: float = 50.0;
var duration = 0.1;

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0;


func _process(delta):
	if shake_strength > lerpf(shake_strength, 0,shakeFade * delta):
		offset = randomOffset()
		await get_tree().create_timer(duration).timeout
		shake_strength = 0.0;

func apply_shake(multiplier: float = 1.0):
	shake_strength = randomStrenght * multiplier;

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength));
	
