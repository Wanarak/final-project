import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_delivery.dart';
import 'list_delivery.dart';
import 'package:google_fonts/google_fonts.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final formKey = GlobalKey<FormState>();
  final DeliveryNameController = TextEditingController();
  final DeliveryAgeController = TextEditingController();
  final DeliveryAddressController = TextEditingController();

  CollectionReference _deliveryCollection =
      FirebaseFirestore.instance.collection('deliveryData');

  @override
  Widget build(BuildContext context) {
    final deliveryIndex = ModalRoute.of(context)!.settings.arguments;
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
            stream: _deliveryCollection.doc(deliveryIndex.toString()).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                  //child: Text('กำลังรอข้อมูล'),
                );
              }
              var deliveryDetail = snapshot.data;
              final DeliveryNameController =
                  TextEditingController(text: deliveryDetail!.get('DeliveryName'));
              final DeliveryAgeController =
                  TextEditingController(text: deliveryDetail.get('DeliveryAge'));
              final DeliveryAddressController =
                  TextEditingController(text: deliveryDetail.get('DeliveryAddress'));
              return Form(
                key: formKey,
                child: Center(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
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
                            color: Color.fromRGBO(85, 15, 197, 1),size: 40,),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: DeliveryAgeController,
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
                            color: Color.fromRGBO(85, 15, 197, 1),size: 40,),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
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
                            color: Color.fromRGBO(85, 15, 197, 1),size: 40,),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(248, 223, 76, 161),minimumSize: Size(327,50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)))),
                          onPressed: () async {
                            //สร้างตัวแปรสำหรับเก็บข้อมูลจาก TextFormField
                            var DeliveryName = DeliveryNameController.text;
                            var DeliveryAge = DeliveryAgeController.text;
                            var DeliveryAddress = DeliveryAddressController.text;

                            //แก้ไขข้อมูลใน DB
                            await _deliveryCollection.doc(deliveryIndex.toString()).set({
                              'DeliveryName': DeliveryName,
                              'DeliveryAge': DeliveryAge,
                              'DeliveryAddress': DeliveryAddress,
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
