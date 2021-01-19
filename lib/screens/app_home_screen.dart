import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:service_app/screens/profile_screen.dart';
import 'package:service_app/utility/hexcolor.dart';
import 'package:service_app/utility/home_screen_list_widget.dart';
import 'package:service_app/utility/useful_methods.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  String userLoggedInName = "Loading...";
  String userLoggedInEmail = "Loading...";
  List<HomeScreenList> homeScreenList = [];
  Position userPosition;
  int _currentImageSlider = 0;

  _listTitle(var screenToGo, String text, var icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 30),
      title: Text(text, style: TextStyle(color: Colors.white, fontSize: 13)),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => screenToGo));
      },
    );
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      UsefulMethods().showToast('Location Services are disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      UsefulMethods().showToast(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        UsefulMethods().showToast(
            'Location permissions are denied (actual value: $permission).');
        return;
      }
    }

    userPosition = await Geolocator.getCurrentPosition();
    setState(() {});
  }

  _getUserDetails() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      setState(() {
        userLoggedInName = value.data()["name"];
        userLoggedInEmail = value.data()["email"];
      });
    });
  }

  _getServicesList() async {
    await FirebaseFirestore.instance
        .collection("serviceMan")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        var a = result.data();
        homeScreenList.add(
          HomeScreenList(
            address: a["address"],
            name: a["name"],
            distance: "108km",
            jobsDone: a["jobsDone"],
            rate: a["rate"],
            review: a["reviewSum"] / a["reviewGiven"],
            completionPercent: a["completionPercent"],
          ),
        );
      });
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
    _determinePosition();
    _getServicesList();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Service'),
        backgroundColor: HexColor("04D337"),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Container(
            color: Colors.green[700],
            child: ListView(
              children: [
                Container(
                  height: 210,
                  child: DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          child: Center(
                              child: Image.asset('assets/images/user.png',
                                  height: 70, width: 70)),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        Flexible(child: SizedBox(height: 40)),
                        Text(userLoggedInName,
                            style: TextStyle(color: Colors.white)),
                        Text(userLoggedInEmail,
                            style: TextStyle(fontSize: 8, color: Colors.white)),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _listTitle(AppHomeScreen(), 'Home', Icons.home),
                _listTitle(AppHomeScreen(), 'My Bookings', Icons.touch_app),
                _listTitle(AppHomeScreen(), 'Chats', Icons.chat_bubble_sharp),
                _listTitle(AppHomeScreen(), 'Receipt', Icons.receipt),
                _listTitle(AppHomeScreen(), 'Search Jobs', Icons.search),
                _listTitle(
                    AppHomeScreen(), 'My Wallet', Icons.wallet_membership),
                _listTitle(ProfileScreen(), 'Profile', Icons.person),
                _listTitle(AppHomeScreen(), 'Notifications',
                    Icons.notifications_active),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app,
                            color: HexColor("04D337"), size: 30),
                        Flexible(child: SizedBox(width: double.infinity)),
                        Text('Select Categories'),
                        Flexible(child: SizedBox(width: double.infinity)),
                        Icon(Icons.touch_app,
                            color: HexColor("04D337"), size: 30),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20.0,
                        ),
                      ]),
                  height: 60,
                  width: width),
            ),
            Stack(
              alignment: Alignment(0, 0.9),
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: 150.0,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageSlider = index;
                        });
                      }),
                  items: [1, 2, 3].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Center(
                              child:
                                  Image.asset("assets/images/offerimage$i.png")),
                        );
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: _currentImageSlider == 0
                                  ? Colors.red
                                  : Colors.green),
                          color: _currentImageSlider == 0
                              ? Colors.red
                              : Colors.white,
                          shape: BoxShape.circle),
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: _currentImageSlider == 1
                                  ? Colors.red
                                  : Colors.green),
                          color: _currentImageSlider == 1
                              ? Colors.red
                              : Colors.white,
                          shape: BoxShape.circle),
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: _currentImageSlider == 2
                                  ? Colors.red
                                  : Colors.green),
                          color: _currentImageSlider == 2
                              ? Colors.red
                              : Colors.white,
                          shape: BoxShape.circle),
                    ),
                  ],
                ),
              ],
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homeScreenList.length,
              itemBuilder: (BuildContext context, int index) {
                var review = homeScreenList[index].review;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 210,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor("04D337")),
                                child: Center(
                                    child: Image.asset(
                                  'assets/images/user.png',
                                  height: 60,
                                  width: 60,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                            Column(
                              children: [
                                Text("${homeScreenList[index].name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text(
                                  "₹ ${homeScreenList[index].rate} rate",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: HexColor("04D337")),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_location, color: HexColor("04D337")),
                            Text("${homeScreenList[index].address}",
                                style: TextStyle(fontSize: 8)),
                            SizedBox(width: 5),
                            Icon(Icons.location_history_sharp,
                                color: HexColor("04D337")),
                            Text("${homeScreenList[index].distance} from YOU",
                                style: TextStyle(fontSize: 8)),
                            SizedBox(width: 5),
                            Icon(Icons.timelapse, color: HexColor("04D337")),
                            Text("26 days ago", style: TextStyle(fontSize: 8)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/like.png",
                                height: 20,
                                width: 20,
                                color: review > 1
                                    ? HexColor("04D337")
                                    : Colors.black),
                            Image.asset("assets/images/like.png",
                                height: 20,
                                width: 20,
                                color: review > 2
                                    ? HexColor("04D337")
                                    : Colors.black),
                            Image.asset("assets/images/like.png",
                                height: 20,
                                width: 20,
                                color: review > 3
                                    ? HexColor("04D337")
                                    : Colors.black),
                            Image.asset("assets/images/like.png",
                                height: 20,
                                width: 20,
                                color: review > 4
                                    ? HexColor("04D337")
                                    : Colors.black),
                            Image.asset("assets/images/like.png",
                                height: 20, width: 20, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                                "(${homeScreenList[index].review.toString().substring(0, 3)}/5)",
                                style: TextStyle(fontSize: 8)),
                            SizedBox(width: 20),
                            Text("${homeScreenList[index].jobsDone} jobs done",
                                style: TextStyle(fontSize: 8)),
                            SizedBox(width: 20),
                            Text(
                                "${homeScreenList[index].completionPercent}% completion",
                                style: TextStyle(fontSize: 8)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor("04D337"),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.touch_app, color: Colors.white), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.white), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active, color: Colors.white),
              label: ''),
        ],
      ),
    );
  }
}
