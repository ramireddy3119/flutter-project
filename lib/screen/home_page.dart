import 'package:flutter/material.dart';
import 'package:food_app_project/services/meal_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  // Function to handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to fetch meals based on search input
  void _searchMeals(String query) async {
    setState(() {
      _isLoading = true;
    });

    final results = await MealService().searchMeals(query);
    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
              radius: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for recipes...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSubmitted: _searchMeals, // Call search on submit
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
      ),
      body: _selectedIndex == 0 ? _buildSearchResults() : _buildOtherScreens(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }

  // Method to build the search results view
  Widget _buildSearchResults() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_searchResults.isEmpty) {
      return Center(child: Text('No recipes found.'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final meal = _searchResults[index];
          return MealCard(meal: meal);
        },
      );
    }
  }

  // Placeholder for other screens
  Widget _buildOtherScreens() {
    switch (_selectedIndex) {
      case 1:
        return Center(child: Text('Cart Screen'));
      case 2:
        return Center(child: Text('Favorites Screen'));
      case 3:
        return Center(child: Text('Settings Screen'));
      default:
        return Container();
    }
  }
}

// Widget to display each meal card
class MealCard extends StatelessWidget {
  final dynamic meal;

  MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.network(
          meal['strMealThumb'],
          width: 50,
          fit: BoxFit.cover,
        ),
        title: Text(meal['strMeal']),
        subtitle: Text(meal['strCategory']),
      ),
    );
  }
}
