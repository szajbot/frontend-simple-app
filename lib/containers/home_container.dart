import 'dart:math';

import 'package:flutter/material.dart';

class HomeContainer extends StatefulWidget {
  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class ItemData {
  final Map<dynamic, dynamic> data;
  bool expanded;

  ItemData(this.data, {this.expanded = false});
}

class _HomeContainerState extends State<HomeContainer> {
  final categoriesController = TextEditingController();
  late Future<Map<String, double>> location;
  bool isExpanded = false;
  Map<dynamic, dynamic>? data;
  List<ItemData> itemDataList = [];
  double _currentValue = 200;

  @override
  void initState() {
    super.initState();
    // location = getLocation();
    // updateData();
  }

  Future<void> selectCategories(BuildContext context) async {
    // final ref = FirebaseDatabase.instance.ref();
    // final result = await ref.child('categories').get();

    final Map<String, dynamic> exampleData = {
      'categories': {
        '1': {'name': 'Electronics', 'id': '1'},
        '2': {'name': 'Clothing', 'id': '2'},
        '3': {'name': 'Books', 'id': '3'}
      }
    };

    if (true) {
      var map = exampleData as Map<dynamic, dynamic>;
      Map<String, List<MapEntry<dynamic, dynamic>>> groupedEntries = {};
      for (var entry in map.entries) {
        String value = entry.key as String;
        int dotsCount = '_'.allMatches(value).length;
        groupedEntries.putIfAbsent(dotsCount.toString(), () => []);
        groupedEntries[dotsCount.toString()]?.add(entry);
      }
      List<List<MapEntry>> listOfLists = groupedEntries.values.toList();
      listOfLists.sort((List<MapEntry<dynamic, dynamic>> a, List<MapEntry<dynamic, dynamic>> b) {
        int dotCountA = '_'.allMatches(a[0].key).length;
        int dotCountB = '_'.allMatches(b[0].key).length;
        return dotCountA.compareTo(dotCountB);
      });

      if (listOfLists.isNotEmpty) {
        String firstSelection = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Category'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: listOfLists[0].map((entry) {
                    return ListTile(
                      title: Text(entry.value),
                      onTap: () {
                        Navigator.of(context).pop(entry.key); // Return the selected key
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ) ?? '';

        if (firstSelection.isNotEmpty) {
          String firstNumber = firstSelection.split('.')[0];
          var secondList = listOfLists[1].where((entry) => entry.key.startsWith(firstNumber)).toList();

          String secondSelection = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Category'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: secondList.map((entry) {
                      return ListTile(
                        title: Text(entry.value),
                        onTap: () {
                          Navigator.of(context).pop(entry.key);
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ) ?? '';

          if (secondSelection.isNotEmpty) {
            String firstTwoNumbers = secondSelection.split('.')[0];
            var thirdList = listOfLists[2].where((entry) => entry.key.startsWith(firstTwoNumbers)).toList();

            if (thirdList.isNotEmpty) {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Category'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: thirdList.map((entry) {
                          return ListTile(
                            title: Text(entry.value),
                            onTap: () {
                              if (categoriesController.text.length > 2) {
                                categoriesController.text = categoriesController.text + ', ' + entry.value;
                                updateData();
                              } else {
                                categoriesController.text = entry.value;
                                updateData();
                              }
                              Navigator.of(context).pop(); // Close the dialog after selection
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            } else {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error', style: TextStyle(color: Colors.red)),
                    content: Text('No matching items found.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK', style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the error dialog
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }
        }
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error', style: TextStyle(color: Colors.red)),
              content: Text('No items found.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the error dialog
                  },
                ),
              ],
            );
          },
        );
        return;
      }
    }
  }

  double distanceInKmBetweenEarthCoordinates(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = ((sin(dLat / 2) * sin(dLat / 2)) +
        (cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2)));

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  // Future<Map<String, double>> getLocation() async {
    // var location = Location();
    // LocationData locationData = await location.getLocation();
    // return {
    //   "latitude": locationData.latitude!,
    //   "longitude": locationData.longitude!,
    // };
  // }

  Future<String> downloadImage(fileName) async {
    String downloadURL = 'example';
    // try {
    //   downloadURL = await FirebaseStorage.instance
    //       .ref('uploads/$fileName')
    //       .getDownloadURL();
    // } on FirebaseException catch (e) {
    //   print(e);
    //   return "";
    // }
    return downloadURL;
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  Future<Map<dynamic, dynamic>?> updateData() async {
    // final ref = FirebaseDatabase.instance.ref();
    // final result = await ref.child('test').get();
    // if (result.exists) {
    //   var values = result.value as Map<dynamic, dynamic>;
    //   var awaitedLocation = await location;
    //   itemDataList = values.entries
    //       .where((entry) =>
    //           distanceInKmBetweenEarthCoordinates(
    //               awaitedLocation["latitude"]!,
    //               awaitedLocation["longitude"]!,
    //               double.parse(entry.value["latitude"]),
    //               double.parse(entry.value["longitude"])) <
    //           _currentValue)
    //       .where((entry) =>
    //             entry.value["categories"].toString().isNotEmpty &&
    //                 (categoriesController.text.isEmpty ||
    //             categoriesController.value.text.contains(entry.value["categories"].toString()) ||
    //             categoriesController.value.text.length < 2)
    //       )
    //       .map((e) => ItemData(e.value))
    //       .toList();
    //   setState(() {});
    // } else {
    //   return null;
    // }
  }

  Future<Map<dynamic, dynamic>?> fetchData() async {
    // final ref = FirebaseDatabase.instance.ref();
    // final result = await ref.child('test').get();
    // if (result.exists) {
    //   var values = result.value as Map<dynamic, dynamic>;
    //   itemDataList = values.entries.map((e) => ItemData(e.value)).toList();
    //   setState(() {});
    // } else {
    //   return null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 230, 210, 210),
                      boxShadow: [
                        // Adding shadow for depth
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: const Text(
                      'Search Filters',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Adjust text color if needed
                      ),
                    ),
                  ),
                )),
            if (isExpanded)
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 210, 210),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Selected Distance: $_currentValue km',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '10 km',
                              style: TextStyle(fontSize: 18),
                            ),
                            Expanded(
                              child: Slider(
                                value: _currentValue,
                                min: 10,
                                max: 200,
                                divisions: 19,
                                activeColor: Colors.lightGreen,
                                inactiveColor:
                                    Colors.lightGreen.withOpacity(0.3),
                                label: '$_currentValue',
                                onChanged: (value) {
                                  setState(() {
                                    _currentValue = value;
                                    updateData();
                                  });
                                },
                              ),
                            ),
                            Text(
                              '200 km',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 240, 220, 220)),
                          ],
                        ),
                        child: TextField(
                          controller: categoriesController,
                          obscureText: false,
                          readOnly: true,
                          style: const TextStyle(
                              fontSize: 14
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Please select some categories...",
                            hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                            border: InputBorder.none,
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            if (isExpanded) Row(
               children: [
                 Padding(
                     padding: EdgeInsets.only(left: 10, right: 5),
                   child: ElevatedButton(
                       onPressed: () {
                         selectCategories(context);
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor:
                         Color.fromARGB(255, 210, 190, 190),
                       ),
                       child: const Row(
                         children: [
                           Text(
                             'Add',
                             style: TextStyle(
                                 color: Colors.black),
                           ),
                           Icon(
                             Icons.add,
                             size: 22,
                             color: Colors.black,
                           )
                         ],
                       )
                   ),
                 ),
                 ElevatedButton(
                     onPressed: () {
                       setState(() {
                          categoriesController.text = '';
                          updateData();
                       });
                     },
                   style: ElevatedButton.styleFrom(
                     backgroundColor:
                     Color.fromARGB(255, 210, 190, 190),
                   ),
                   child: const Row(
                     children: [
                       Text(
                         'Clear',
                         style: TextStyle(
                             color: Colors.black),
                       ),
                       Icon(
                         Icons.restore_from_trash_outlined,
                         size: 22,
                         color: Colors.black,
                       )
                     ],
                   )
                 ),
               ],
              ),
            if (isExpanded) SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: itemDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  final itemData = itemDataList[index];
                  final isExpanded = itemData.expanded;
                  return AnimatedContainer(
                      height: isExpanded ? 820 : 210,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: const Color.fromARGB(255, 230, 210, 210),
                          border: Border.all(
                            color: Colors.grey.shade700,
                          )),
                      margin: EdgeInsets.all(15),
                      duration: const Duration(milliseconds: 100),
                      child: !isExpanded
                          ? Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 8),
                                      child: FutureBuilder<String?>(
                                        future: downloadImage(
                                            itemData.data['photo']),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData &&
                                                snapshot.data!.isNotEmpty) {
                                              return Container(
                                                width: 125,
                                                height: 125,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const Text(
                                                  'Failed to download the image.');
                                            }
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ),
                                    Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            // alignment: AlignmentDirectional.topStart,
                                            Container(
                                              height: 85,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  190,
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style, // Default text style
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Description: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text: itemData
                                                          .data['description'],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  200,
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  190,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style, // Default text style
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Price: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text: itemData
                                                          .data['price'],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    const TextSpan(
                                                      text: " zł",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          // Toggle the expansion status of the item
                                          itemData.expanded = !isExpanded;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 210, 190, 190),
                                      ),
                                      child: Text(
                                        isExpanded ? 'Hide' : 'Show',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 8),
                                  child: FutureBuilder<String?>(
                                    future:
                                        downloadImage(itemData.data['photo']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData &&
                                            snapshot.data!.isNotEmpty) {
                                          return Container(
                                            width: 250,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    snapshot.data!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const Text(
                                              'Failed to download the image.');
                                        }
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  height: 250,
                                  width: 250,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  // child: GoogleMap(
                                  //   initialCameraPosition: CameraPosition(
                                  //       target: LatLng(
                                  //           double.parse(
                                  //               itemData.data['latitude']),
                                  //           double.parse(
                                  //               itemData.data['longitude'])),
                                  //       zoom: 15),
                                  //   mapType: MapType.normal,
                                  // ),
                                ),
                                Container(
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      color: const Color.fromARGB(
                                          255, 220, 200, 200)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style, // Default text style
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text: 'Description: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text:
                                                  itemData.data['description'],
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 25,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color:
                                          Color.fromARGB(255, 220, 200, 200)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context)
                                            .style, // Default text style
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Price: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: itemData.data['price'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const TextSpan(
                                            text: " zł",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 25,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color:
                                          Color.fromARGB(255, 220, 200, 200)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context)
                                            .style, // Default text style
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Categories: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: itemData.data['categories'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          itemData.expanded = !isExpanded;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 210, 190, 190),
                                      ),
                                      child: Text(
                                        isExpanded ? 'Hide' : 'Show',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
