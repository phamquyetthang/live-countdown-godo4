# Code đủ thứ
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.loadGame()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$CanvasLayer/Control/Live.text = str(Global.live)
	$CanvasLayer/Control/Time.text =": ".join([ Global.countDown.minute,  Global.countDown.second])
	pass


func _on_button_pressed():
	Global.kill()
	pass # Replace with function body.


func _on_exit_pressed():
	Global.saveGame()
	get_tree().quit()
	pass # Replace with function body.
