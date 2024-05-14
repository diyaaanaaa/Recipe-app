import 'package:flutter/material.dart';
import 'package:recipe_app/myrecipe.dart';
import 'package:recipe_app/profilepage.dart';
import 'package:recipe_app/searchpage.dart';
import 'package:http/http.dart' as client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:recipe_app/recipepage.dart';
import 'package:recipe_app/recipe_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;
  List<Recipe> recipes = [];
  late List<bool> favoriteStatus;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      // Existing endpoint for pizza
      var pizzaUrl =
          Uri.parse('http://192.168.209.80:8080/recipes/by-title?title=pizza');
      // New endpoint for hot chocolate
      var hotChocolateUrl = Uri.parse(
          'http://192.168.209.80:8080/recipes/by-title?title=hot%20chocolat');
      var strawberrycompotUrl = Uri.parse(
          'http://192.168.209.80:8080/recipes/by-title?title=Strawberry%20Compot');
      var crepsUrl =
          Uri.parse('http://192.168.209.80:8080/recipes/by-title?title=Creps');
      var pancakesUrl = Uri.parse(
          'http://192.168.209.80:8080/recipes/by-title?title=Pancakes');

      // You can create a function to fetch recipes
      await fetchRecipes(pizzaUrl, token);
      await fetchRecipes(hotChocolateUrl, token);
      await fetchRecipes(strawberrycompotUrl, token);
      await fetchRecipes(crepsUrl, token);
      await fetchRecipes(pancakesUrl, token);
    }
  }

  Future<void> fetchRecipes(Uri url, String token) async {
    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        recipes.addAll(data
            .map((recipeJson) => Recipe.fromJson(recipeJson))
            .cast<Recipe>()
            .toList());
        favoriteStatus = List.filled(
            recipes.length, false); // Initialize favoriteStatus here
      });
    } else {
      // Handle other status codes or errors
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Navigate to home
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyRecipePage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
    }

    @override
    void initState() {
      super.initState();
      initializePreferences();
      // Initialize all recipes as not favorite
      favoriteStatus = List.filled(recipes.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 255, 242),
        automaticallyImplyLeading: false,
        title: const Text(
          'Kitchen Compass',
          style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: 24,
              color: Color(0xFF7EE36D)),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 250, 255, 242),
              Color.fromRGBO(225, 249, 221, 1),
              Color.fromRGBO(244, 247, 216, 1),
            ],
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return Stack(
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipePage(recipe: recipe),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16), // Adjust the radius as needed
                            child: Image.network(
                              "http://192.168.209.80:8080/images/${recipe.image}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   // child: Text(recipe.title),
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      favoriteStatus[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          favoriteStatus[index] ? Colors.green : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        favoriteStatus[index] = !favoriteStatus[index];
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 140,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF7EE36D),
          unselectedItemColor: Color(0xFFD6DBDE),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
