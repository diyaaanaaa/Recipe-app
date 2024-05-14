class Recipe {
  final int id;
  final String title;
  final String description;
  final String image;
  final List<Ingredient> ingredients;

  Recipe(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var list = json['ingridients'] as List;
    List<Ingredient> ingredientsList =
        list.map((i) => Ingredient.fromJson(i)).toList();

    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      ingredients: ingredientsList,
    );
  }
}

class Ingredient {
  final String ingredientName;
  final String measurement;

  Ingredient({required this.ingredientName, required this.measurement});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientName: json['ingridientName'],
      measurement: json['measurement'],
    );
  }
}
