extends Sequence

# meta-name: Default sequence
# meta-description: Predefined functions for sequences
# meta-default: true
# meta-space-indent: 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    pass

func start():
    pass

func _handle_animation_finished(_animation_name: String):
    pass

func _handle_line_rendered():
    pass

func _handle_all_text_rendered():
    pass