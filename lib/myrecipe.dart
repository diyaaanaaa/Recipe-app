import 'package:flutter/material.dart';
import 'package:recipe_app/newrecipe.dart';
import 'package:recipe_app/profilepage.dart';
import 'package:recipe_app/searchpage.dart';
import 'package:recipe_app/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyRecipePage extends StatefulWidget {
  const MyRecipePage({super.key});

  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  List<Map<String, dynamic>> recipes = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    final String bearerToken =
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtYXJnYXJ5YW4uYW5uYUBnbWFpbC5jb20iLCJyb2xlIjpbIlJPTEVfQ1VTVE9NRVIiXSwidXNlcklkIjo3LCJuYW1lIjoiQW5uYSBNYXJnYXJ5YW4iLCJpYXQiOjE3MTU2Mjc3NzYsImV4cCI6MTcxNjQ5MTc3Nn0.u7B3W1PvanfPLM767BZWllHkFqxJaRgSTu0ERFFkzsk';
    final Uri url = Uri.parse('http://192.168.209.80:8080/account/my-recipes');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': bearerToken
      });
      if (response.statusCode == 200) {
        print("here111");
        final List<dynamic> fetchedRecipes = json.decode(response.body);
        setState(() {
          recipes = fetchedRecipes
              .map((recipe) => {
                    'title': recipe['title'],
                    'description': recipe['description']
                  })
              .toList();
        });
      } else {
        print('Failed to fetch recipes: ${response.body}');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }

  void _navigateToNewRecipe() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewRecipePage()),
    ).then((_) => _fetchRecipes());
  }

  int _selectedIndex = 2;

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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchPage()));
        break;
      case 2:
        if (!Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
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
        automaticallyImplyLeading: false,
        title: const Text(
          'My Recipes',
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
        child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(recipes[index]['title'] ?? ''),
              subtitle: Text(recipes[index]['description'] ?? ''),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNewRecipe,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.add_circle_outline_outlined,
          color: Color(0xFF7EE36D),
          size: 50,
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
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF7EE36D),
          unselectedItemColor: const Color(0xFFD6DBDE),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
