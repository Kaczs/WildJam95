class_name CardData
extends Resource

@export var card_name:String = "Card Name"
@export var description:String = "Words Here"
## Effects are commands that control what the card can do
## deal damage, apply effect, block etc.
@export var effects:Array[CardEffect]