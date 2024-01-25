extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateScore(score):
	$ScoreLabel.text = "Score: " + str(score);

func gameOver():
	$GameOverLabel.visible = true

func _on_enemy_5_death():
	pass # Replace with function body.


func _on_player_on_kill():
	pass # Replace with function body.
