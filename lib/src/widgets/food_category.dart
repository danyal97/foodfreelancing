import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/models/fooditemslist.dart';
import 'package:foodfreelancing/src/models/user.dart';
import 'package:foodfreelancing/src/services/FoodItems.dart';
import 'package:provider/provider.dart';
import 'food_card.dart';

// DAta
import '../data/category_data.dart';

// Model
import '../models/category_model.dart';

class FoodCategory extends StatefulWidget {
  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  final List<Category> _categories = categories;
  @override

  // final docIds = FoodItems().allDocumentIds;

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Task')
            .document(user.uid)
            .collection('FoodList')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            List<FoodItemsList> foods = snapshot.data.documents
                .map(
                  (foodTitles) => FoodItemsList(
                      title: foodTitles.documentID ?? " ",
                      price: foodTitles.data['Price'] ?? 0,
                      category: foodTitles.data['Category'] ?? " ",
                      description: foodTitles.data['Description'] ?? " ",
                      image:
                          foodTitles.data['image'] ?? categories[0].imagePath),
                )
                .toList();
            print(foods.length);

            return Container(
              height: 80.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                itemBuilder: (BuildContext context, int index) {
                  // print("Category called");
                  // print(foods[0].category);
                  return FoodCard(
                    categoryName: foods[index].category,
                    imagePath: foods[0].image,
                    numberOfItems: foods[index].price.length,
                    // numberOfItems: _categories[index].numberOfItems,
                  );
                },
              ),
            );
          }
          return Container(width: 0.0, height: 0.0);
        });
  }
}
