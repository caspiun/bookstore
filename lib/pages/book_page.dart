import 'package:badges/badges.dart'
    as badges; // Import the badges package with a prefix
import 'package:bookstoreapp/data/json.dart';
import 'package:bookstoreapp/theme/colors.dart';
import 'package:bookstoreapp/widgets/book_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: appBgColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.vertical_distribute_rounded,
                        color: primary,
                      ))),
              Icon(Icons.search_rounded, color: primary),
              SizedBox(width: 15),
              badges.Badge(
                // Use the badges package with the prefix
                position: badges.BadgePosition.topEnd(top: -10, end: -10),
                badgeContent: Text(
                  '1',
                  style: TextStyle(color: Colors.white),
                ),
                child: InkWell(
                    onTap: _showShoppingBagBottomSheet,
                    child: Icon(Icons.shopping_bag_rounded, color: primary)),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TabBar(
                indicatorColor: primary,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primary,
                ),
                labelPadding: EdgeInsets.only(top: 8, bottom: 8),
                unselectedLabelColor: primary,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Text(
                    "New Books",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Popular Books",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    children: getNewBooks(),
                  ),
                  ListView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    children: getPopularBooks(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShoppingBagBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.cart),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Shopping Bag",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                // Create a ListView of shopping bag books
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    final book = popularBooks[index];
                    return ListTile(
                      title: Container(
                          width: 200,
                          height: 150,
                          child: Image.network(book['image'] ?? '')),
                      subtitle: Center(
                          child: Text(
                        book['ori_price'] ?? '',
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough,fontSize: 15,fontWeight: FontWeight.w500),
                      )),
                      trailing: Text(
                        'Price: ${book['price'] ?? ''}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle buy button click here
                    },
                    child: Text("Buy"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getNewBooks() {
    return List.generate(
        latestBooks.length, (index) => BookItem(book: latestBooks[index]));
  }

  getPopularBooks() {
    return List.generate(
        popularBooks.length, (index) => BookItem(book: popularBooks[index]));
  }
}
