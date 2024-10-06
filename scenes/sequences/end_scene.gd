extends Sequence


var sequence_text: Array[String] = ["And now I have the space to grow too."]

var allow_advance: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _input(_event: InputEvent) -> void:
    if allow_advance and Input.is_action_just_pressed("left-click"):
            allow_advance = false
            var text_finished: bool = text_renderer.advance_text()
            if text_finished:
                end()

func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("start")

func _handle_animation_finished(_animation_name: String):
    pass

func _handle_line_rendered():
    allow_advance = true
    text_renderer.animate_ready()

func _handle_all_text_rendered():
    pass
