import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/recipe_model.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;

  RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late Future<Recipe> recipe;

  @override
  void initState() {
    super.initState();
    recipe = recipe = Future.value(widget.recipe);
  }

  Future<Recipe> fetchRecipe() async {
    final response = await http.get(Uri.parse(
        'http://192.168.209.80:8080/recipes/by-title?title=pancakes'));

    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: FutureBuilder<Recipe>(
        future: recipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return RecipeDetails(recipe: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  RecipeDetails({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network('http://192.168.209.80:8080/images/${recipe.image}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              recipe.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              recipe.description.replaceAll('\\n', '\n'),
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipe.ingredients.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(recipe.ingredients[index].ingredientName),
                trailing: Text(recipe.ingredients[index].measurement),
              );
            },
          ),
        ],
      ),
    );
  }
}
