extends Skeleton3D


@onready var anim_player: AnimationPlayer = get_node("../../../../../../../AnimationPlayer")

var idle_start_time: float = 15.5
var idle_end_time: float = 16.5
var walk_start_time: float = 3.0
var walk_end_time: float = 7.0
var jump_start_time: float = 12.0
var jump_end_time: float = 14.5
var death_start_time: float = 5.0
var death_end_time: float = 6.5
var current_animation: String = "DOG_skeleton|DOG_skeleton|DOG_skeleton|DOG_anm"
var idle = true

func _ready():
	anim_player.play(current_animation)
	anim_player.seek(idle_start_time, true)
	set_process(true)
	
func _process(delta):
	if anim_player.current_animation_position >= idle_end_time:
		anim_player.seek(idle_start_time, true)
