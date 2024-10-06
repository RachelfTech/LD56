extends Sequence


var sequence_text: Array[String] = ["But, one morning I woke up...",
            "and you were gone."]

var allow_advance: bool = false
var allow_text_advance: bool = false
var active_animation: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()

func _input(_event: InputEvent) -> void:
    _update_ready_to_advance()
    if allow_advance and Input.is_action_just_pressed("left-click"):
        var text_finished: bool = text_renderer.advance_text()
        if text_finished:
            end()
        else:
            allow_text_advance = false

func start():
    text_renderer.set_sequence_text(sequence_text)
    text_renderer.play_text()

func _handle_animation_finished(_animation_name: String):
    active_animation = false

func _handle_line_rendered():
    allow_text_advance = true

func _handle_all_text_rendered():
    animation_player.play("play")
    active_animation = true

func _update_ready_to_advance():
    var last_ready_to_advance = allow_advance

    allow_advance = allow_text_advance and not active_animation

    if last_ready_to_advance != allow_advance and allow_advance:
        text_renderer.animate_ready()
