class FoodDisplay{
  final String spoonacularSourceUrl;

  FoodDisplay( {
    required this.spoonacularSourceUrl,
});
  factory FoodDisplay.fromMap(
      Map<String,dynamic>map
      ){return FoodDisplay(
    spoonacularSourceUrl:map['spoonacularSourceUrl']);
  }
}