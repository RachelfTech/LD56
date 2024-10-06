class_name PhonePhoto
extends Sprite2D

@export var area_2d: Area2D
@export var heart_area: Area2D
@export var heart: Sprite2D
@export var grey_heart: Sprite2D


var already_liked: bool = false

var insta_sequence: InstaSequence

signal liked

func _ready() -> void:
    area_2d.input_event.connect(_handle_area_input_event)
    heart_area.mouse_entered.connect(_handle_heart_area_mouse_entered)
    heart_area.mouse_exited.connect(_handle_heart_area_mouse_exited)

    insta_sequence = get_owner()

func _handle_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
    if already_liked or insta_sequence.scrolling or not insta_sequence.game_running:
        return

    if event is InputEventMouseMotion:
        return

    print(Input.get_last_mouse_velocity())

    if Input.is_action_just_released("left-click"):
        var tween: Tween = self.create_tween().set_loops()
        heart.visible = true
        grey_heart.visible = false

        tween.tween_property(heart, "modulate:a", 1, .3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
        tween.set_parallel()
        tween.tween_property(heart, "scale", Vector2(1, 1), .5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
        tween.set_parallel(false)
        tween.tween_property(heart, "rotation_degrees", -10, .8).set_trans(Tween.TRANS_SINE)
        tween.tween_property(heart, "rotation_degrees", 10, .8).set_trans(Tween.TRANS_SINE)

        already_liked = true
        liked.emit()

func _handle_heart_area_mouse_entered():
    if not insta_sequence.game_running:
        return
    var tween: Tween = self.create_tween()
    tween.tween_property(grey_heart, "scale", Vector2(1, 1), .5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

func _handle_heart_area_mouse_exited():
    if not insta_sequence.game_running:
        return
    var tween: Tween = self.create_tween()
    tween.tween_property(grey_heart, "scale", Vector2(.5, .5), .5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)