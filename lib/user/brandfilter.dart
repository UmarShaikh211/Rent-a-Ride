import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'date.dart';
import 'global.dart';

class FilteredCarsPage extends StatefulWidget {
  final String selectedBrand;
  final List<dynamic> sharedCars;
  FilteredCarsPage({required this.selectedBrand, required this.sharedCars});

  @override
  State<FilteredCarsPage> createState() => _FilteredCarsPageState();
}

class _FilteredCarsPageState extends State<FilteredCarsPage> {
  late Box<FavoriteCar> favoriteBox;
  String userId = "";
  bool isCarFavorite = false;
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    userId = userProvider.userId!;
    openHiveBox(); // Ensure that openHiveBox is called
  }

  Future<void> openHiveBox() async {
    try {
      favoriteBox = await Hive.openBox<FavoriteCar>('favorite_cars_$userId');
      setState(() {});
    } catch (e) {
      print('Error opening Hive box: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Filter the sharedCars list based on the selectedBrand
    final filteredCars = widget.sharedCars.where((car) {
      final addedCars = car['added_cars'];
      if (addedCars != null && addedCars.isNotEmpty) {
        final brandName = addedCars[0]['CarBrand'];
        return brandName == widget.selectedBrand;
      }
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cars by ${widget.selectedBrand}'),
        backgroundColor: Color.fromRGBO(254, 205, 59, 1.0),
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
          itemCount: filteredCars.length,
          itemBuilder: (context, index) {
            final car = filteredCars[index];
            final addedCars = car['added_cars'][0]; // Access the first item

            final carBrand = addedCars['CarBrand'];
            final carModel = addedCars['CarModel'];
            final carCity = addedCars['CarCity'];

            final carTrans = addedCars['CarTrans'];
            final carFuel = addedCars['CarFuel'];
            final carSeat = addedCars['CarSeat'];
            final carImageUrl =
                car['car_image'][0]['Image1']; // Access the first image
            final amt = car['car_price'][0]['amount']; // Access the price
            final carId = car['id']; // Add this line to get the car ID
            print(carId);
            return Center(
              child: InkWell(
                onTap: () {
                  print('Selected Car ID: $car');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Date(
                        carn: carBrand + ' ' + carModel,
                        id: car['id'],
                        sharedCars: widget.sharedCars,
                        cprice: amt.toDouble(),
                      ),
                    ),
                  );
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: size.height * 0.35,
                      width: size.width * 0.9,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.25,
                            width: size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  carImageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  isCarFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline_sharp,
                                  color: isCarFavorite ? Colors.red : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isCarFavorite =
                                        !isCarFavorite; // Toggle the favorite state

                                    if (isCarFavorite) {
                                      // Add the car to favorites
                                      favoriteBox.put(
                                        carId.toString(),
                                        FavoriteCar(
                                          name: carBrand + ' ' + carModel,
                                          image: carImageUrl,
                                          location: carCity,
                                          price: amt.toDouble(),
                                          trans: '',
                                        ),
                                      );
                                    } else {
                                      // Remove the car from favorites
                                      favoriteBox.delete(carId.toString());
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: MediaQuery.of(context).size.width * 0.53,
                            ),
                            child: Text(
                              carBrand + ' ' + carModel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.57,
                            ),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.60,
                              left: 10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_sharp,
                                  size: size.width * 0.05,
                                ),
                                Text(
                                  carCity,
                                  style: TextStyle(
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                Icon(
                                  Icons.gamepad,
                                  size: size.width * 0.05,
                                ),
                                Text(
                                  carTrans,
                                  style: TextStyle(
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.15,
                                ),
                                Text(
                                  "\$" + amt.toString() + "/Hr",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class FavoriteIconButton extends StatefulWidget {
  final bool isFavorite;
  final Function onPressed;

  FavoriteIconButton({required this.isFavorite, required this.onPressed});

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isFavorite ? Icons.favorite : Icons.favorite_outline_sharp,
        color: widget.isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        widget.onPressed();
        setState(() {}); // Force rebuild of the widget
      },
    );
  }
}
