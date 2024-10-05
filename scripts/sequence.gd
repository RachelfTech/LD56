class_name Sequence

extends Node

@export var animation_player: AnimationPlayer
@export var text_renderer: TextRenderer
@export var camera: Camera2D

var id: Globals.Sequences


signal finished

func _ready() -> void:
    if text_renderer:
        text_renderer.line_rendered.connect(_handle_line_rendered)
        text_renderer.all_text_rendered.connect(_handle_all_text_rendered)

    if animation_player:
        animation_player.animation_finished.connect(_handle_animation_finished)

func start():
    pass

func end():
    finished.emit()

func _handle_animation_finished(_animation_name: String):
    pass

func _handle_line_rendered():
    pass

func _handle_all_text_rendered():
    pass