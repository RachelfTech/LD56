extends Sequence

var sequence_text: Array[String] = [
    "Strangely, I found myself [pulse]happy[/pulse] for you.",
    "Proud you'd fully embraced your [rainbow]new form[/rainbow].",
    "In the end, maybe the real question was never [wave]\"would you still love me?\"[/wave]",
    "But rather, [wave]\"How would our love evolve?\"[/wave]"]

var allow_advance: bool = false
var animation_in_progress: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    if allow_advance and not animation_in_progress and Input.is_action_just_pressed("left-click"):
            allow_advance = false
            var text_finished: bool = text_renderer.advance_text()
            if text_finished:
                end()

func start():
    text_renderer.set_sequence_text(sequence_text)
    text_renderer.play_text()

func _handle_animation_finished(_animation_name: String):
    animation_in_progress = false
    text_renderer.animate_ready()

func _handle_line_rendered():
    allow_advance = true
    text_renderer.animate_ready()

func _handle_all_text_rendered():
    animation_in_progress = true
    text_renderer.stop_animate_ready()
    animation_player.play("play")