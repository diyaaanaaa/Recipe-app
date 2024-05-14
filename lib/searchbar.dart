import 'package:flutter/material.dart';
import 'package:recipe_app/myrecipe.dart';
import 'package:recipe_app/profilepage.dart';
import 'package:recipe_app/homepage.dart';
import 'package:http/http.dart' as client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:recipe_app/recipe_model.dart';
import 'package:recipe_app/recipepage.dart';

class SearchBarPage extends StatefulWidget {
  final String? searchQuery;
  const SearchBarPage({Key? key, this.searchQuery = ""}) : super(key: key);

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  late SharedPreferences prefs;
  List<Recipe> recipes = [];
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    print("query----> ${widget.searchQuery}");

    var url = Uri.parse(
        'http://192.168.209.80:8080/recipes/by-title?title=${Uri.encodeComponent(widget.searchQuery!)}');

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        recipes =
            data.map((recipeJson) => Recipe.fromJson(recipeJson)).toList();
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        if (!Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 255, 242),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF7EE36D)),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipePage(recipe: recipe),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "http://192.168.209.80:8080/images/${recipe.image}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            recipe.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
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
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFF7EE36D),
            unselectedItemColor: const Color(0xFFD6DBDE),
            onTap: _onItemTapped,
          ),
        ));
  }
}
