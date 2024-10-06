extends Sequence

var sequence_text: Array[String] = ["I wanted to make things work.",
            "So I did everything I could..."]


var allow_advance: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()
    id = Globals.Sequences.SECOND

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
   # if allow_advance:
      #  text_renderer.animate_ready()

func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("start")

func _input(_event: InputEvent) -> void:
    if allow_advance and Input.is_action_just_pressed("left-click"):
            allow_advance = false
            var text_finished: bool = text_renderer.advance_text()
            if text_finished:
                end()


func _handle_line_rendered():
    allow_advance = true
    text_renderer.animate_ready()