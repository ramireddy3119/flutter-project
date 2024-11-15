import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_app_project/utils/colors.dart';
import 'package:food_app_project/model/items_model.dart';
import 'package:food_app_project/screen/items_diplay.dart';

class HeaderParts extends StatefulWidget {
  const HeaderParts({super.key});

  @override
  State<HeaderParts> createState() => _HeaderPartsState();
}

class _HeaderPartsState extends State<HeaderParts> {
  int indexCategory = 0;
  List<FoodDetail> meals = []; // Updated to use FoodDetail model
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topHeader(),
        const SizedBox(height: 30),
        title(),
        const SizedBox(height: 21),
        searchBar(),
        const SizedBox(height: 30),
        categorySelection(),
        // Display the items in a grid using ItemsDisplay widget
        meals.isNotEmpty ? ItemsDisplay(foodsItems: meals) : Container(),
      ],
    );
  }

  Padding categorySelection() {
    List<String> categories = ["All", "Fruits", "Vegetables", "Grocery"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  indexCategory = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    fontSize: 20,
                    color: indexCategory == index ? primaryColors : Colors.black45,
                    fontWeight: indexCategory == index ? FontWeight.bold : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container searchBar() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  fetchMeals(value); // Fetch meals when user submits
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: primaryColors),
                hintText: "Search food",
                hintStyle: TextStyle(color: Colors.black26),
              ),
            ),
          ),
          Material(
            color: primaryColors,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {
                if (_searchController.text.isNotEmpty) {
                  fetchMeals(_searchController.text); // Fetch meals on tap
                }
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.insert_emoticon_sharp,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> fetchMeals(String query) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        meals = (data['meals'] ?? []).map<FoodDetail>((json) => FoodDetail.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load meals');
    }
  }

  Padding title() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi Nabin",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColors,
              fontSize: 18,
            ),
          ),
          Text(
            "Find your food",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }

  Padding topHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Material(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_open_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.location_on,
            color: primaryColors,
            size: 18,
          ),
          const Text(
            "Vijayawada",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "asset/MY_Photho.jpg",
              height: 40,
              width: 40,
            ),
          )
        ],
      ),
    );
  }
}
