class_name PlayerStates extends BaseState

var player: Player
var animator: AnimatedSprite2D

func _ready() -> void:
    await owner.ready
    player = owner as Player
    animator = player.animator
    print(player)