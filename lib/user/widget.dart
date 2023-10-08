import 'package:flutter/material.dart';
import 'package:rentcartest/user/enums.dart';

import 'car_detail.dart';
import 'cart_model.dart';
import 'home.dart';

class Wid extends StatefulWidget {
  const Wid({super.key});

  @override
  State<Wid> createState() => _WidState();
}

class _WidState extends State<Wid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

final List<Widget> carouselItems = [
  Container(
    color: Colors.blue,
    child: Center(child: Text('Item 1')),
  ),
  Container(
    color: Colors.red,
    child: Center(child: Text('Item 2')),
  ),
  Container(
    color: Colors.green,
    child: Center(child: Text('Item 3')),
  ),
];

class homecars extends StatelessWidget {
  const homecars({Key? key, required this.carsItem}) : super(key: key);
  final House carsItem;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            height: size.height * 0.33,
            width: size.width * 0.9,
            child: Stack(
              children: [
                Image(
                  image: AssetImage(carsItem.images[0]),
                  fit: BoxFit.fill,
                  height: size.height * 0.25,
                  width: size.width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star_border_purple500_sharp,
                              size: 20,
                            ),
                          ),
                          Text("5.0"),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_outline_sharp),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, top: MediaQuery.of(context).size.width * 0.45),
                  child: Text(
                    carsItem.Title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.52),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.57, left: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: size.width * 0.05,
                      ),
                      Text(
                        carsItem.location,
                        style: TextStyle(fontSize: size.width * 0.035),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Icon(
                        Icons.gamepad,
                        size: size.width * 0.05,
                      ),
                      Text(
                        carsItem.mode,
                        style: TextStyle(fontSize: size.width * 0.035),
                      ),
                      SizedBox(
                        width: size.width * 0.15,
                      ),
                      Text(
                        carsItem.rent,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.045),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class brand_card extends StatelessWidget {
  const brand_card({
    Key? key,
    required this.Title,
    required this.image,
    required this.press,
  }) : super(key: key);
  final String Title;
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Image.asset(
              image,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.14,
            ),
          ),
          Text(
            Title,
            style: TextStyle(fontSize: size.width * 0.04),
          )
        ],
      ),
      onTap: press as void Function(),
    );
  }
}

class Reviewcon extends StatelessWidget {
  const Reviewcon({
    Key? key,
    required this.Review,
    required this.Name,
  }) : super(key: key);

  final String Review;
  final String Name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.14,
      width: size.width * 0.6,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Text(Review + '\n' + '~' + Name,
                  style: TextStyle(
                      fontSize: size.width * 0.038,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
              // Padding(
              //   padding: const EdgeInsets.only(left: 48.0),
              //   child: Text(
              //     '~' + Name,
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class car_widget extends StatelessWidget {
  const car_widget({super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: Colors.transparent,
          child: Image.network(
            image,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class Car_Card extends StatelessWidget {
  final String imagePath;
  final String carName;
  final String carDetails;
  final String pricePerHour;
  final String distanceAway;

  const Car_Card({
    Key? key,
    required this.imagePath,
    required this.carName,
    required this.carDetails,
    required this.pricePerHour,
    required this.distanceAway,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      child: Card(
        child: Container(
          height: size.height * 0.40,
          width: size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.25,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/rolls.png")),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_outline_sharp),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Tata Tiago 2022",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Automatic * Petrol * 5 Seats",
                  style: TextStyle(
                      fontSize: size.width * 0.025, color: Colors.red),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.credit_card_outlined,
                              size: size.width * 0.07,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "FastTag",
                              style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "\$1000/Hr",
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class car_specs extends StatelessWidget {
  const car_specs({
    Key? key,
    required this.Title,
    required this.image,
    required this.press,
  }) : super(key: key);
  final String Title;
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                image,
                scale: 15,
              ),
              Text(Title),
            ],
          ),
        ),
      ),
      onTap: press as void Function(),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
      selectedLabelStyle: TextStyle(
        color: Colors.black, // Change the color of selected item label
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.grey, // Change the color of unselected item label
      ),
      selectedItemColor: Colors.black, // Change the color of selected item icon
      unselectedItemColor:
          Colors.grey, // Change the color of unselected item icon
    );
  }
}

List<String> generateYearsList() {
  int currentYear = DateTime.now().year;
  List<String> years = [];
  for (int year = currentYear; year >= 2007; year--) {
    years.add(year.toString());
  }
  return years;
}

List<String> cities = [
  'New Delhi',
  'Mumbai',
  'Bangalore',
  'Chennai',
  'Kolkata',
  'Hyderabad',
  'Pune',
  'Ahmedabad',
  'Jaipur',
  'Lucknow',
  'Surat',
  'Kanpur',
  'Nagpur',
  'Indore',
  'Thane',
  'Bhopal',
  'Visakhapatnam',
  'Pimpri-Chinchwad',
  'Patna',
  'Vadodara',
];

class FuelBut extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  FuelBut({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 10,
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.deepPurple,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? Colors.deepPurple : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

List<String> selectedbook = [
  'All',
  'Upcoming',
  'Ongoing',
  'Completed',
  'Cancelled',
  'Not Served'
];
List<String> selectedcar = [
  'MH02AV3274',
  'MH02AV9852',
  'GJ02AV4778',
  'MP02AV2346',
  'LA02AV6895',
];

List<String> carlist = [
  'Hyundai I10 ',
  'Ferrari LaFerrari',
  'Lambirghini Aventadir',
  'Mercedes AMG',
  'Buggati Chiron',
];

class earn extends StatelessWidget {
  const earn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
        child: Container(
            width: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Text(
                  "MONTHLY EARNINGS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [earncard(), earncard()],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class rate extends StatelessWidget {
  const rate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
        child: Container(
            width: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Text(
                  "MONTHLY RATINGS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [ratecard(), ratecard()],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class earncard extends StatelessWidget {
  const earncard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 90,
        width: 130,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Text("June Earnings till Date")
            ],
          ),
        ),
      ),
    );
  }
}

class ratecard extends StatelessWidget {
  const ratecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 90,
        width: 130,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                      Icon(
                        Icons.star_purple500_sharp,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Text("June Earnings till Date")
            ],
          ),
        ),
      ),
    );
  }
}

class FilBut extends StatelessWidget {
  final String? text;
  final bool isSelected;
  final VoidCallback onPressed;

  FilBut({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.white,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Expanded(
          child: Container(
            width: 42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home_sharp,
                  size: 18,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                SizedBox(height: 8),
                Text(
                  text!,
                  style: TextStyle(
                    fontSize: 8,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Fav_Card extends StatelessWidget {
  final String imagePath;
  final String carName;
  final String carDetails;

  const Fav_Card({
    Key? key,
    required this.imagePath,
    required this.carName,
    required this.carDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      child: Card(
        child: Container(
          height: size.height * 0.32,
          width: size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.25,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/rolls.png")),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_outline_sharp),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Tata Tiago 2022",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.width * 0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Automatic * Petrol * 5 Seats",
                  style: TextStyle(
                      fontSize: size.width * 0.025, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
