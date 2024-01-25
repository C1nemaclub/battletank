extends ProgressBar

@onready var animation_player = $AnimationPlayer
signal animation_done;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_animation():
	animation_player.play("fill")


func _on_animation_player_animation_finished(anim_name):
	animation_done.emit()
