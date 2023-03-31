import 'package:flutter/material.dart';
import 'list_restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({super.key});

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  final formKey = GlobalKey<FormState>();
  final RestaurantNameController = TextEditingController();
  final RestaurantTypeController = TextEditingController();
  final RestaurantAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference _restaurantCollection =
    FirebaseFirestore.instance.collection('restaurantData');
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
                  'Restaurant details',
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
          Container(
            margin: EdgeInsets.only(top: 0),
            child: Form(
              key: formKey,
              child: Center(     
                child: SafeArea(
                  child: Column(               
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        child: TextFormField(
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
                            color: Color.fromRGBO(85, 15, 197, 1),size: 35,),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'กรุณากรอกชื่อและนามสกุลของท่าน';
                              }
                            return null;
                            },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: TextFormField(
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
                            prefixIcon: Icon(Icons.fastfood_outlined,
                            color: Color.fromRGBO(85, 15, 197, 1),size: 35,),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'กรุณากรอกชื่อร้านอาหารของท่าน';
                              }
                            return null;
                            },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: TextFormField(
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
                            color: Color.fromRGBO(85, 15, 197, 1),size: 35,),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'กรุณากรอกที่อยู่ร้านอาหารของท่าน';
                              }
                            return null;
                            },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(248, 223, 76, 161),minimumSize: Size(327,50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                          onPressed: () {
                              if(formKey.currentState!.validate()) {
                                var RestaurantName = RestaurantNameController.text;
                                var RestaurantType = RestaurantTypeController.text;
                                var RestaurantAddress = RestaurantAddressController.text;
                                
                                _restaurantCollection
                                    .add({'RestaurantName': RestaurantName, 'RestaurantType': RestaurantType, 'RestaurantAddress': RestaurantAddress});
                                
                                formKey.currentState?.reset();
                                Navigator.pop(context);}
                                else {}
                              }, child: Text('Add restaurant', style: GoogleFonts.kanit(fontSize: 25)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}