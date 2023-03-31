import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_restaurant.dart';
import 'list_restaurant.dart';
import 'package:google_fonts/google_fonts.dart';

class EditRestaurant extends StatefulWidget {
  const EditRestaurant({super.key});

  @override
  State<EditRestaurant> createState() => _EditRestaurantState();
}

class _EditRestaurantState extends State<EditRestaurant> {
  final formKey = GlobalKey<FormState>();
  final RestaurantNameController = TextEditingController();
  final RestaurantTypeController = TextEditingController();
  final RestaurantAddressController = TextEditingController();

  CollectionReference _restaurantCollection =
      FirebaseFirestore.instance.collection('restaurantData');

  @override
  Widget build(BuildContext context) {
    final restaurantIndex = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Column(
        children: [
        Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [Color.fromRGBO(85, 15, 197, 1),Color.fromRGBO(126, 54, 243, 1)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter),
        ),
        child:  Stack(
          children: [Padding(
            padding: const EdgeInsets.only(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Text(
                  'Edit delivery',
                 style: GoogleFonts.kanit(fontSize: 30, color: Color.fromARGB(255, 224, 236, 227)),
                 ),
              ),
            ),
          ),
           Padding(
                  padding: const EdgeInsets.only(top:50 ,left: 0),
                  child: IconButton(
                      onPressed: (() => Navigator.pop(context)),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
           ]
        ),),
          StreamBuilder(
            stream: _restaurantCollection.doc(restaurantIndex.toString()).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                  //child: Text('กำลังรอข้อมูล'),
                );
              }
              var restaurantDetail = snapshot.data;
              final RestaurantNameController =
                  TextEditingController(text: restaurantDetail!.get('RestaurantName'));
              final RestaurantTypeController =
                  TextEditingController(text: restaurantDetail.get('RestaurantType'));
              final RestaurantAddressController =
                  TextEditingController(text: restaurantDetail.get('RestaurantAddress'));
              return Form(
                key: formKey,
                child: Center(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: RestaurantNameController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            hintText: "ชื่อร้านอาหาร",
                            hintStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            labelText: "กรุณนากรอกชื่อร้านอาหาร",
                            labelStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.red)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green)
                            ),
                            prefixIcon: Icon(Icons.person,
                            color: Color.fromRGBO(85, 15, 197, 1),size: 40,),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: RestaurantTypeController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            hintText: "ประเภทอาหาร",
                            hintStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            labelText: "กรุณากรอกประเภทอาหาร",
                            labelStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.red)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green)
                            ),
                            prefixIcon: Icon(Icons.date_range,
                            color: Color.fromRGBO(85, 15, 197, 1),size: 40,),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: RestaurantAddressController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            hintText: "ที่อยู่",
                            hintStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            labelText: "กรุณากรอกที่อยู่",
                            labelStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.red)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.green)
                            ),
                            prefixIcon: Icon(Icons.location_on,
                            color: Color.fromRGBO(85, 15, 197, 1),size: 40,),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(248, 223, 76, 161),minimumSize: Size(327,50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                          onPressed: () async {
                            //สร้างตัวแปรสำหรับเก็บข้อมูลจาก TextFormField
                            var RestaurantName = RestaurantNameController.text;
                            var RestaurantType = RestaurantTypeController.text;
                            var RestaurantAddress = RestaurantAddressController.text;

                            //แก้ไขข้อมูลใน DB
                            await _restaurantCollection.doc(restaurantIndex.toString()).set({
                              'RestaurantName': RestaurantName,
                              'RestaurantType': RestaurantType,
                              'RestaurantAddress': RestaurantAddress,
                            });

                            Navigator.pop(context);
                          },
                          child: Text('แก้ไขข้อมูล',style: GoogleFonts.kanit(fontSize: 25)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}