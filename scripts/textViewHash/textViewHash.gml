function textViewHash(view){
	return hash(
		view.width,
		view.height, view.maxWidth,
		view.maxHeight, view.maxLine,
		view.text,view.background,
		view.backgroundAlpha,view.stokeWidth,
		view.stokeColor,
		view.stokeColorAlpha,
		view.font,
		view.textColor,
		view.margin,
		)
}