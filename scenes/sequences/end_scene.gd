extends Sequence


var sequence_text: Array[String] = ["And, without your [shake rate=1.0 level=2]transformation...[/shake]",
"I wouldn't have had the chance to [wave]grow[/wave] too."]

var allow_advance: bool = false
var all_done: bool = false
var end_anim_done: bool = false
var end_anim_played: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    if allow_advance and Input.is_action_just_pressed("left-click"):
        if all_done and not end_anim_played:
            text_renderer.hide_text()
            end_anim_played = true
            animation_player.play("end")
            allow_advance = false
        if end_anim_done:
            end()
        else:
            allow_advance = false
            var text_finished: bool = text_renderer.advance_text()


func start():
    text_renderer.set_sequence_text(sequence_text)
    text_renderer.play_text()

func _handle_animation_finished(_animation_name: String):
    if _animation_name == "start":
        all_done = true
        allow_advance = true
    if _animation_name == "end":
        end_anim_done = true
        allow_advance = true

func _handle_line_rendered():
    allow_advance = true
    text_renderer.animate_ready()

func _handle_all_text_rendered():
    animation_player.play("start")
