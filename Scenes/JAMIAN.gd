extends StaticBody3D

signal jamian_talk

@onready var I8Door: MeshInstance3D = $"../../MeshInstance3D11"

@export var interaction_text: String = "Jamian"
@export var dialogue_line: Array[String] = [
	"Ian you completely missed it...",
	"Class has been over for like 3 hours...",
	"You better start walking to work...",
	"You don't want to be too late"
]
@export var speaker_name: String = "Jamian" 

var dialogue_index := 0

func interact():
	print("interacted with Jamian")
	emit_signal("jamian_talk")
	
	
func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
			"text": line,
			"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		return null

func get_interaction_text():
	return interaction_text
