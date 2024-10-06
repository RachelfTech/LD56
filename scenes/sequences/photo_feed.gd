class_name PhotoFeed
extends Marker2D

signal feed_photo_liked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for child: PhonePhoto in get_children():
        child.liked.connect(_handle_photo_liked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _handle_photo_liked():
    print("emit")
    feed_photo_liked.emit()