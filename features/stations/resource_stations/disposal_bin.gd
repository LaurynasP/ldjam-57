extends ResourceStation

func add_item(_item: Item) -> bool:
	play_add_remove_sound_effect()
	return true

func remove_item() -> Item:
	return null
