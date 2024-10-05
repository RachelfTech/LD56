extends Sequence


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _handle_animation_finished(_animation_name: String):
    pass

func _handle_line_rendered():
    pass