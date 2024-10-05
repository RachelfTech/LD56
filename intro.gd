extends Sequence

var sequence_text: Array[String] = [
    "[center]I woke up one morning and you had [wave]changed....[/wave][/center]",
    "I still can't believe it actually happened."]


var allow_advance: bool = false
var animation_finished: bool = false

var active_animation: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()
    id = Globals.Sequences.INTRO

func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("opening")
    active_animation = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    if not active_animation and allow_advance and Input.is_action_just_pressed("left-click"):
        var text_finished: bool = text_renderer.advance_text()
        if text_finished:
            finished.emit()
        else:
            allow_advance = false

func _handle_animation_finished(_animation_name: String):
    active_animation = false

func _handle_line_rendered():
    allow_advance = true