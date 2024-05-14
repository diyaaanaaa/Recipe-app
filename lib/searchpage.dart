import 'package:flutter/material.dart';
import 'package:recipe_app/myrecipe.dart';
import 'package:recipe_app/profilepage.dart';
import 'package:recipe_app/homepage.dart';
import 'package:recipe_app/searchbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 1;

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

  void _submitSearch(String searchText) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchBarPage(searchQuery: searchText)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 250, 255, 242),
      //   automaticallyImplyLeading: false,
      //   title: PreferredSize(
      //     preferredSize: const Size.fromHeight(80.0),
      //     child: Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Container(
      //         height: 40,
      //         decoration: BoxDecoration(
      //           color: const Color.fromARGB(255, 250, 249, 249),
      //           borderRadius: BorderRadius.circular(19),
      //           boxShadow: const [
      //             BoxShadow(
      //               color: Colors.black26,
      //               blurRadius: 4,
      //               offset: Offset(0, 2),
      //             ),
      //           ],
      //         ),
      //         child: const Center(
      //           child: TextField(
      //             decoration: InputDecoration(
      //               prefixIcon: Icon(Icons.search),
      //               border: InputBorder.none,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
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
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  height: 40,
                  alignment: Alignment.bottomCenter,
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Gilroy-Medium',
                          color: Color(0xFFC6C0C0)),
                      icon: Icon(Icons.search),
                    ),
                    onFieldSubmitted: (value) {
                      _submitSearch(value);
                    },
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SearchBarPage(
                        //             searchQuery: _searchController.text)),
                        //   );
                        // },
                        child: Column(
                          children: [
                            Container(
                              width: 79,
                              height: 79,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/images/breakfast-bowl-with-oats-blueberries.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Breakfast',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF959595),
                                  fontSize: 8,
                                  fontFamily: 'Gilroy-Bold'),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchBarPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 79,
                              height: 79,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/high-angle-toast-sandwich-with-tomatoes-greens-egg.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Lunch',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF959595),
                                  fontSize: 8,
                                  fontFamily: 'Gilroy-Bold'),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchBarPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 79,
                              height: 79,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/piece-grilled-fish-fillet-with-green-salad-berries-white-plate.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Dinner',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF959595),
                                  fontSize: 8,
                                  fontFamily: 'Gilroy-Bold'),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchBarPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 79,
                              height: 79,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/fresh-raspberry-cheesecake.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Desserts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF959595),
                                  fontSize: 8,
                                  fontFamily: 'Gilroy-Bold'),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchBarPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 79,
                              height: 79,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/refreshing-alcoholic-drinks-with-strawberries.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Drinks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF959595),
                                  fontSize: 8,
                                  fontFamily: 'Gilroy-Bold'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Vegetables',
                      style: TextStyle(
                          color: Color(0xFF7EE36D),
                          fontFamily: 'Gilroy-Bold',
                          fontSize: 12),
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Ex. potato, carrot',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Gilroy-Medium',
                              color: Color(0xFFC6C0C0)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Fruits',
                      style: TextStyle(
                          color: Color(0xFF7EE36D),
                          fontFamily: 'Gilroy-Bold',
                          fontSize: 12),
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Ex. apple, orange',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Gilroy-Medium',
                              color: Color(0xFFC6C0C0)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Dairy Products',
                      style: TextStyle(
                          color: Color(0xFF7EE36D),
                          fontFamily: 'Gilroy-Bold',
                          fontSize: 12),
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Ex. milk, butter',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Gilroy-Medium',
                              color: Color(0xFFC6C0C0)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Meet',
                      style: TextStyle(
                          color: Color(0xFF7EE36D),
                          fontFamily: 'Gilroy-Bold',
                          fontSize: 12),
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Ex. beef',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Gilroy-Medium',
                              color: Color(0xFFC6C0C0)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchBarPage(
                              searchQuery: _searchController.text)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF7EE36D), // Button background color
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Continue',
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
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
      ),
    );
  }
}
