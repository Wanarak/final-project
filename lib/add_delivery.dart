import 'package:flutter/material.dart';
import 'list_delivery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final formKey = GlobalKey<FormState>();
  final DeliveryNameController = TextEditingController();
  final DeliveryAgeController = TextEditingController();
  final DeliveryAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference _deliveryCollection =
    FirebaseFirestore.instance.collection('deliveryData');
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
                  'Delivery details',
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
                          controller: DeliveryNameController,
                          maxLength: 30,
                          decoration: InputDecoration(
                            hintText: "ชื่อ-นามสกุล",
                            hintStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            labelText: "กรุณนากรอกชื่อ-นามสกุล",
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
                          controller: DeliveryAgeController,
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          decoration: InputDecoration(
                            hintText: "อายุ",
                            hintStyle: GoogleFonts.kanit(color: Color.fromARGB(248, 223, 76, 161)),
                            labelText: "กรุณากรอกอายุ",
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
                            color: Color.fromRGBO(85, 15, 197, 1),size: 35,),
                          ),
                          validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกอายุของท่าน';
                          }
                          if (double.parse(value) <= 18) {
                            return 'กรุณาใส่อายุมากกว่า 18 ปี';
                          }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: TextFormField(
                          controller: DeliveryAddressController,
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
                              return 'กรุณากรอกชื่อและนามสกุลของท่าน';
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
                                var DeliveryName = DeliveryNameController.text;
                                var DeliveryAge = DeliveryAgeController.text;
                                var DeliveryAddress = DeliveryAddressController.text;
                                
                                _deliveryCollection
                                    .add({'DeliveryName': DeliveryName, 'DeliveryAge': DeliveryAge, 'DeliveryAddress': DeliveryAddress});
                                
                                formKey.currentState?.reset();
                                Navigator.pop(context);}
                                else {}
                              }, child: Text('Add delivery', style: GoogleFonts.kanit(fontSize: 25)),
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
