extends Node


enum Suite {
	SPADES,
	HEARTS,
	CLUBS,
	DIAMONDS,
}

enum Colour {
	BLACK,
	RED,
}

func has_all(array: Array[Variant], values: Array[Variant]) -> bool:
	for value: Variant in values:
		if !array.has(value):
			return false

	return true
