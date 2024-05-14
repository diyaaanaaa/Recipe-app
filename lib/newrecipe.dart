import 'package:flutter/material.dart';
import 'package:recipe_app/myrecipe.dart';
import 'package:recipe_app/profilepage.dart';
import 'package:recipe_app/searchpage.dart';
import 'package:recipe_app/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewRecipePage extends StatefulWidget {
  const NewRecipePage({super.key});

  @override
  _NewRecipePageState createState() => _NewRecipePageState();
}

class _NewRecipePageState extends State<NewRecipePage> {
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

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _saveRecipe() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;

    // Encode your credentials
    // String basicAuth = 'Basic ' +
    //     base64Encode(utf8.encode('margaryan.anna@gmail.com:Test123@'));
    final String bearerToken =
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtYXJnYXJ5YW4uYW5uYUBnbWFpbC5jb20iLCJyb2xlIjpbIlJPTEVfQ1VTVE9NRVIiXSwidXNlcklkIjo3LCJuYW1lIjoiQW5uYSBNYXJnYXJ5YW4iLCJpYXQiOjE3MTU2Mjc3NzYsImV4cCI6MTcxNjQ5MTc3Nn0.u7B3W1PvanfPLM767BZWllHkFqxJaRgSTu0ERFFkzsk';
    final Uri url = Uri.parse('http://192.168.209.80:8080/account/my-recipes');
    final Map<String, dynamic> body = {
      'title': title,
      'description': description,
    };

    try {
      final http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': bearerToken,
        },
        body: json.encode(body),
      );
      print("here");
      print(response.body);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyRecipePage()),
        );
      } else {
        print(response.statusCode);
        throw Exception('Failed to save recipe');
      }
    } catch (e) {
      print('Error saving recipe: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 255, 242),
          title: const Text(
            'New Recipe',
            style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: 24,
                color: Color(0xFF7EE36D)),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF7EE36D),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: DecoratedBox(
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15),
                const Text(
                  'Title',
                  style: TextStyle(
                      color: Color(0xFF7EE36D),
                      fontFamily: 'Gilroy-Bold',
                      fontSize: 15),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 360,
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 249, 249),
                    borderRadius: BorderRadius.circular(19),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Type...',
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy-Medium',
                          color: Color(0xFFC6C0C0)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 360,
                  height: 360,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 249, 249),
                    borderRadius: BorderRadius.circular(19),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      labelText: 'Type...',
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy-Medium',
                          color: Color(0xFFC6C0C0)),
                    ),
                    maxLines: 20,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _saveRecipe();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyRecipePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7EE36D),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Save',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
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
        ));
  }
}
