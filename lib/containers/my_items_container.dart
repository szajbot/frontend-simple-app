import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../components/my_categories_textfield.dart';
import '../components/my_price_textfield.dart';
import '../components/my_expanded_textfield.dart';

class MyItemsContainer extends StatefulWidget {
  @override
  State<MyItemsContainer> createState() => _MyItemsContainerState();
}

class _MyItemsContainerState extends State<MyItemsContainer> {
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final keyController = TextEditingController();
  final categoriesController = TextEditingController();
  // final imagePicker = ImagePicker();
  // final user = FirebaseAuth.instance.currentUser!;

  bool isExpanded = false;
  bool uploadedPhoto = false;
  bool editMode = false;
  // XFile? pickedFile;
  io.File? _photo;
  String? _editedPhoto;

  // Future<Map<String, double>> getLocation() async {
  //   var location = Location();
  //   LocationData locationData = await location.getLocation();
  //   return {
  //     "latitude": locationData.latitude!,
  //     "longitude": locationData.longitude!,
  //   };
  // }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      _photo = null;
      editMode = false;
      uploadedPhoto = false;
      _editedPhoto = null;
      descriptionController.text = "";
      priceController.text = "";
    });
  }

  void toggleImage() {
    setState(() {
      uploadedPhoto = true;
    });
  }

  Future<String> downloadImage(fileName) async {
    String downloadURL = 'TODO';
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

  Future<void> deleteData(String dataKey) async {
    // try {
      // DatabaseReference ref = FirebaseDatabase.instance.ref().child("test");
      //
      // await ref.child(dataKey).remove();
      // print("Data deleted successfully.");
      // setState(() {});
    // } catch (e) {
    //   print("Error deleting data: $e");
    // }
  }

  Future<void> editPost(String dataKey) async {
    final data = await fetchData();
    final record =
        data?.entries.where((element) => element.key == dataKey).first;
    var downloaded = await downloadImage(record!.value["photo"]);
    setState(() {
      descriptionController.text = record!.value["description"];
      priceController.text = record.value["price"];
      _editedPhoto = downloaded;
    });
  }

  Future<Map<dynamic, dynamic>?> fetchData() async {
    // final ref = FirebaseDatabase.instance.ref();
    // final result = await ref.child('test').get();
    // if (result.exists) {
    //   return result.value as Map<dynamic, dynamic>;
    // } else {
    //   return null;
    // }
  }

  Future<bool> uploadData() async {
    return true;
    // try {
    //   DatabaseReference ref = FirebaseDatabase.instance.ref().child("test");
    //
    //   Map<String, double> location = await getLocation();
    //
    //   Map<String, dynamic> postData = {
    //     "description": descriptionController.value.text,
    //     "price": priceController.value.text,
    //     "email": user.email,
    //     "photo": basename(_photo!.path),
    //     "latitude": location["latitude"].toString(),
    //     "longitude": location["longitude"].toString(),
    //     "categories": categoriesController.value.text,
    //   };
    //
    //   DatabaseReference newEntryRef = ref.push();
    //   await newEntryRef.set(postData);
    //
    //   toggleExpansion();
    //   print("Example data upserted successfully.");
    //   return true;
    // } catch (e) {
    //   print("Error upserting example data: $e");
    //   return false;
    // }
  }

  void updateData() async {
    // try {
    //   DatabaseReference ref = FirebaseDatabase.instance.ref().child("test");
    //
    //   DataSnapshot oldData = await ref.child(keyController.value.text).get();
    //   var oldDataPure = oldData.value as Map<dynamic, dynamic>;
    //
    //   await ref.child(keyController.value.text).remove();
    //
    //   Map<String, dynamic> postData = {
    //     "description": descriptionController.value.text,
    //     "price": priceController.value.text,
    //     "email": user.email,
    //     "photo": oldDataPure["photo"],
    //     "latitude": oldDataPure["latitude"].toString(),
    //     "longitude": oldDataPure["longitude"].toString(),
    //     "categories": categoriesController.value.text,
    //   };
    //
    //   DatabaseReference newEntryRef = ref.push();
    //   await newEntryRef.set(postData);
    //
    //   toggleExpansion();
    //   print("Example data upserted successfully.");
    // } catch (e) {
    //   print("Error upserting example data: $e");
    // }
  }

  Future imgFromGallery() async {
    // setState(() {
    //   _photo = null;
    //   _editedPhoto = null;
    // });
    //
    // final XFile? pickedFile =
    //     await imagePicker.pickImage(source: ImageSource.gallery);
    // final filename = basename(io.File(pickedFile!.path).path);
    //
    // setState(() {
    //   _photo = io.File(pickedFile.path);
    // });
    //
    // if (_photo != null) {
    //   try {
    //     await FirebaseStorage.instance
    //         .ref('uploads/$filename')
    //         .putFile(_photo!);
    //   } on FirebaseException catch (e) {
    //     print(e);
    //   }
    // } else {
    //   print('No image selected.');
    // }
  }

  Future imgFromCamera() async {
    // setState(() {
    //   _photo = null;
    //   _editedPhoto = null;
    // });
    // final XFile? pickedFile =
    //     await imagePicker.pickImage(source: ImageSource.camera);
    // final filename = basename(io.File(pickedFile!.path).path);
    //
    // setState(() {
    //   _photo = io.File(pickedFile.path);
    // });
    //
    // if (_photo != null) {
    //   try {
    //     await FirebaseStorage.instance
    //         .ref('uploads/$filename')
    //         .putFile(_photo!);
    //   } on FirebaseException catch (e) {
    //     print(e);
    //   }
    // } else {
    //   print('No image selected.');
    // }
  }

  Future uploadFile() async {
    // final filename = basename(io.File(pickedFile!.path).path);
    //
    // if (_photo != null) {
    //   try {
    //     await FirebaseStorage.instance
    //         .ref('uploads/$filename')
    //         .putFile(_photo!);
    //   } on FirebaseException catch (e) {
    //     // Handle any errors
    //     print(e);
    //   }
    // }
  }

  Future<void> handleUpload(context) async {
    // Showing a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot dismiss the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Uploading..."),
              ],
            ),
          ),
        );
      },
    );

    // Call your asynchronous upload function here
    await uploadData();

    // Once uploadData is complete, close the dialog
    Navigator.pop(context);
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
                              categoriesController.text = entry.value;
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

  void signUserOut() {
    // FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder<Map<dynamic, dynamic>?>(
              future: fetchData(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<dynamic, dynamic>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic>? data = snapshot.data;
                    List<MapEntry> dataFiltered = data!.entries
                        .where((entry) => entry.value['email'] == 'example')
                        .toList();

                    if (dataFiltered.isNotEmpty) {
                      return ListView(
                        children: dataFiltered
                            .map((entry) => Container(
                                  height: 155,
                                  margin: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade500, width: 1),
                                    color: Color.fromARGB(255, 230, 210, 210),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 190, 170, 170),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            width: 75,
                                            height: 75,
                                            child: FutureBuilder<String?>(
                                              future: downloadImage(
                                                  entry.value['photo']),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.hasData &&
                                                      snapshot
                                                          .data!.isNotEmpty) {
                                                    return Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
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
                                                  return CircularProgressIndicator();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width - 150,
                                              height: 50,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  // Default text style
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Description: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text: entry
                                                          .value['description'],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                150,
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              height: 25,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  // Default text style
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Price: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          entry.value['price'],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    280,
                                              ),
                                              Container(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    toggleExpansion();
                                                    editMode = true;
                                                    keyController.text =
                                                        entry.key;
                                                    editPost(entry.key);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.lightBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: const Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await deleteData(entry.key);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      return const Center(child: Text('No data available.'));
                    }
                  } else {
                    return const Center(child: Text('No data available.'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade500,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                // curve: Curves.easeInOut,
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: toggleExpansion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 210, 190, 190),
                  ),
                  child: Text(
                    isExpanded ? 'Add new item' : 'Add new item',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),

          if (isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500, width: 0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: const [
                    BoxShadow(color: Color.fromARGB(255, 240, 220, 220)),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text("Description"),
                      ),
                    ),
                    MyExpandedTextField(
                      controller: descriptionController,
                      hintText: 'Your description...',
                      obscureText: false,
                      height: 120,
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text("Price"),
                      ),
                    ),
                    MyPriceTextField(
                      controller: priceController,
                      hintText: 'Your price',
                      obscureText: false,
                      height: 50,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, right: 6),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text("Category"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectCategories(context);
                          },
                          child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 210, 190, 190),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 22,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    CategoriesTextField(
                      controller: categoriesController,
                      hintText: 'Select your categories...',
                      obscureText: false,
                      height: 50,
                    ),
                    const SizedBox(height: 5),
                    if (_photo != null)
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 6,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.file(io.File(_photo!.path)),
                          ),
                        ),
                      ),
                    if (_editedPhoto != null)
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.height / 6,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(_editedPhoto!),
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            imgFromGallery();
                          },
                          child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 210, 190, 190),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Gallery image',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Icon(
                                    Icons.photo_library,
                                    size: 22,
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            imgFromCamera();
                          },
                          child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 210, 190, 190),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Camera Image',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Icon(
                                    Icons.camera_alt,
                                    size: 22,
                                  ),
                                ],
                              )),
                        ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        const SizedBox(
                          width: 85,
                        ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        if (!editMode)
                          GestureDetector(
                            onTap: () async {
                              await handleUpload(context);
                            },
                            child: Container(
                                height: 35,
                                width: 65,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 210, 190, 190),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Save',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    Icon(
                                      Icons.save,
                                      size: 22,
                                    ),
                                  ],
                                )),
                          ),
                        if (editMode)
                          GestureDetector(
                            onTap: () {
                              updateData();
                            },
                            child: Container(
                                height: 35,
                                width: 65,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 210, 190, 190),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Update',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    Icon(
                                      Icons.save,
                                      size: 22,
                                    ),
                                  ],
                                )),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          //   Container(
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
