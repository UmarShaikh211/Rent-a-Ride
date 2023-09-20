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
    userId = userProvider.userId!;
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
    if (!isBoxInitialized) {
      // Handle the case where the box is not initialized yet
      return CircularProgressIndicator(); // You can show a loading indicator
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Cars'),
        ),
        body: ListView.builder(
          itemCount: favoriteBox.length,
          itemBuilder: (context, index) {
            final favoriteCar = favoriteBox.getAt(index);

            if (favoriteCar != null) {
              return ListTile(
                title: Text(favoriteCar.name),
                leading: Image.network(favoriteCar.image),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Remove the favorite when the delete button is pressed
                    favoriteBox.deleteAt(index);
                    // Notify the UI to update
                    setState(() {});
                  },
                ),
              );
            } else {
              return ListTile(
                title: Text('Invalid Favorite Car'),
              );
            }
          },
        ));
  }
}
