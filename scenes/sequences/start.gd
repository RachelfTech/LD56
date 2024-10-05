extends Sequence


var sequence_text: Array[String] = ["Click to begin"]

@export var play_sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()
    text_renderer.silent = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("left-click"):
        end()

func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("ready")


func _handle_animation_finished(_animation_name: String):
    print("done")
    _animate_sprite()

func _handle_line_rendered():
    text_renderer.animate_ready()

func _animate_sprite():
    var tween: Tween = self.create_tween().set_loops()
    tween.tween_property(play_sprite, "scale:x", .85, 4).set_ease(Tween.EASE_IN)
    tween.set_parallel()
    tween.tween_property(play_sprite, "scale:y", .85, 4).set_ease(Tween.EASE_IN)
    tween.set_parallel(false)
    tween.tween_property(play_sprite, "scale:x", 1, 4).set_ease(Tween.EASE_OUT)
    tween.set_parallel()
    tween.tween_property(play_sprite, "scale:y", 1, 4).set_ease(Tween.EASE_OUT)