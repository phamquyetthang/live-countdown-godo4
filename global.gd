extends Node

var live = 0
var lastLiveUpdatedAt = null
var countDown = {"minute": 0, "second": 0}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if live == 0 and lastLiveUpdatedAt == null:
		live = 5
	elif live < 5 &&  lastLiveUpdatedAt != null:
		countDown = Time.get_time_dict_from_unix_time(1 * 20 - (Time.get_unix_time_from_system() - Global.lastLiveUpdatedAt))
		if countDown.minute == 0 and countDown.second == 0:
			live += 1
			lastLiveUpdatedAt = Time.get_unix_time_from_system()
	pass

func kill():
	if lastLiveUpdatedAt == null:
		lastLiveUpdatedAt = Time.get_unix_time_from_system()
	live -= 1


func saveGame():
	var file = FileAccess.open('res://savegame4.bin', FileAccess.WRITE)
	var data:Dictionary = {"live": live, "lastLiveUpdatedAt": lastLiveUpdatedAt}
	file.store_line(JSON.stringify(data))
	
func loadGame():
	var file = FileAccess.open('res://savegame4.bin', FileAccess.READ)
	if FileAccess.file_exists('res://savegame4.bin') == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				live = current_line['live']
				var lastUpdate = current_line['lastLiveUpdatedAt']
				var diff = Time.get_unix_time_from_system() - lastUpdate
				var addLive = round((diff / 20))
				var p = (diff / 20) - round(diff / 20)
				if live + addLive >= 5:
					live = 5
				else:
					live += addLive
				
				lastLiveUpdatedAt = Time.get_unix_time_from_system() - (p * 20)
