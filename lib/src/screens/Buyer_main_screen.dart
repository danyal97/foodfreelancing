import 'package:flutter/material.dart';
import 'package:foodfreelancing/src/admin/pages/add_food_item.dart';
import 'package:foodfreelancing/src/scoped-model/main_model.dart';
import '../pages/home_page.dart';
import '../pages/order_page.dart';
import '../pages/explore_page(2).dart';
import '../pages/profile_page.dart';
import '../pages/buyer_home_page.dart';
import 'package:foodfreelancing/src/pages/buyer_request_page.dart';
import 'package:foodfreelancing/src/pages/buyer_explorer_page.dart';
class BuyerMainScreen extends StatefulWidget {
  final MainModel model;

  BuyerMainScreen({this.model});

  @override
  _BuyerMainScreenState createState() => _BuyerMainScreenState();
}

class _BuyerMainScreenState extends State<BuyerMainScreen> {
  int currentTab = 0;

  // Pages
  BuyerHomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  ProfilePage profilePage;

  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    // call the fetch method on food
    // widget.foodModel.fetchFoods();
    widget.model.fetchFoods();

    homePage = BuyerHomePage();
    orderPage = OrderPage();
    favoritePage = FavoritePage(model: widget.model);
    profilePage = ProfilePage();
    pages = [homePage, favoritePage, orderPage, profilePage];

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("Main Model Called");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            currentTab == 0
                ? "Food Delivery App"
                : currentTab == 1
                    ? "All Food Items"
                    : currentTab == 2 ? "Orders" : "Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  try {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => AddFoodItem()));
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddBuyerRequest()));
                                        // .then((value) {
                              // setState(() {
                              //   check = false;
                              // });
                            // });
                  } catch (e) {}
                },
                leading: Icon(Icons.list),
                title: Text(
                  "Add Request",
                  style: TextStyle(fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (index) {
            setState(() {
              currentTab = index;
              currentPage = pages[index];
            });
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
              ),
              title: Text("Explore"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              title: Text("Orders"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text("Profile"),
            ),
          ],
        ),
        body: currentPage,
      ),
    );
  }
}
