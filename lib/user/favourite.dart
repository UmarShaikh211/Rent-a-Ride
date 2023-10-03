import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'global.dart';
import 'home.dart'; // Replace with the actual import of your model class

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  late Box<FavoriteCar> favoriteBox; // Declare the Hive box as a class field
  bool isBoxInitialized = false;
  String userId = "";
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId ??
        ""; // Use an empty string as a default if userId is null
    openHiveBox(); // Open the Hive box when the widget is initialized
  }

  Future<void> openHiveBox() async {
    favoriteBox = favoriteBox = await Hive.openBox<FavoriteCar>(
        'favorite_cars_$userId'); // Replace 1 with the actual user ID
    setState(() {
      isBoxInitialized = true;
    }); // Trigger a rebuild to display the data
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (!isBoxInitialized) {
      // Handle the case where the box is not initialized yet
      return CircularProgressIndicator(); // You can show a loading indicator
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Favorite Cars'),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
            itemCount: favoriteBox.length,
            itemBuilder: (context, index) {
              final favoriteCar = favoriteBox.getAt(index);

              if (favoriteCar != null) {
                return GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                    int sensitivity = 8;
                    if (details.delta.dx > sensitivity) {
                      // Right Swipe
                    } else if (details.delta.dx < -sensitivity) {
                      favoriteBox.deleteAt(index);
                      // Notify the UI to update
                      setState(() {});
                      //Left Swipe
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepPurple)),
                            child: Row(
                              children: [
                                Container(
                                    height: 100,
                                    width: 110,
                                    child: Image.network(
                                      favoriteCar.image,
                                      fit: BoxFit.fill,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        favoriteCar.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(favoriteCar.location),
                                    ])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                //WORKING
                // return GestureDetector(
                //   onTap: () {
                //     favoriteBox.deleteAt(index);
                //     // Notify the UI to update
                //     setState(() {});
                //   },
                //   child: Card(
                //     color: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(15),
                //       ),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 0,
                //       ),
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         height: size.height * 0.35,
                //         width: size.width * 0.9,
                //         child: Stack(
                //           children: [
                //             Container(
                //               height: size.height * 0.25,
                //               width: size.width,
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                   image: NetworkImage(
                //                     favoriteCar.image,
                //                   ),
                //                   fit: BoxFit.cover,
                //                 ),
                //                 borderRadius: BorderRadius.only(
                //                   topRight: Radius.circular(12),
                //                   topLeft: Radius.circular(12),
                //                 ),
                //               ),
                //             ),
                //             Padding(
                //               padding: EdgeInsets.only(
                //                 left: 20,
                //                 top: MediaQuery.of(context).size.width * 0.53,
                //               ),
                //               child: Text(
                //                 favoriteCar.name,
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: size.width * 0.05,
                //                 ),
                //               ),
                //             ),
                //             Padding(
                //               padding: EdgeInsets.only(
                //                 top: MediaQuery.of(context).size.width * 0.57,
                //               ),
                //               child: Divider(
                //                 thickness: 1,
                //               ),
                //             ),
                //             Padding(
                //               padding: EdgeInsets.only(
                //                 top: MediaQuery.of(context).size.width * 0.60,
                //                 left: 10,
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.only(top: 6.0),
                //                 child: Row(
                //                   children: [
                //                     Icon(
                //                       Icons.location_on_sharp,
                //                       size: size.width * 0.05,
                //                     ),
                //                     Text(
                //                       favoriteCar.location,
                //                       style: TextStyle(
                //                         fontSize: size.width * 0.035,
                //                       ),
                //                     ),
                //                     SizedBox(
                //                       width: size.width * 0.04,
                //                     ),
                //                     Icon(
                //                       Icons.gamepad,
                //                       size: size.width * 0.05,
                //                     ),
                //                     Text(
                //                       favoriteCar.trans,
                //                       style: TextStyle(
                //                         fontSize: size.width * 0.035,
                //                       ),
                //                     ),
                //                     SizedBox(
                //                       width: size.width * 0.15,
                //                     ),
                //                     Text(
                //                       "\$" + favoriteCar.price.toString() + "/Hr",
                //                       style: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: size.width * 0.045,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // );
              }
              ;
            }));
  }
}
