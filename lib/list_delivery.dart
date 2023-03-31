import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_delivery.dart';
import 'add_delivery.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDelivery extends StatefulWidget {
  const ListDelivery({super.key});

  @override
  State<ListDelivery> createState() => _ListDeliveryState();
}

class _ListDeliveryState extends State<ListDelivery> {
  CollectionReference _deliveryCollection =
      FirebaseFirestore.instance.collection('deliveryData');

  @override
  Widget build(BuildContext context) {
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
        child:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: Text(
                  'Delivery',
                 style: GoogleFonts.kanit(fontSize: 40, color: Color.fromARGB(255, 255, 255, 255)),
                 ),
              ),
            ),
            Center(
              child: Text(
                'รายชื่อพนักงาน',
               style: GoogleFonts.kanit(fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
               ),
            ),
          ],
        ),),
          StreamBuilder(
            stream: _deliveryCollection.snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.only(top: 8),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length, //นับจำนวนข้อมูลทั้งหมด
                itemBuilder: ((context, index) {
                  var deliveryIndex = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          color: Colors.white, boxShadow: [BoxShadow(color: Color.fromARGB(255, 228, 228, 228),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(5, 5))],
                           ),
                      child: ListTile(
                          title: Row(
                          children: [
                          Text(deliveryIndex['DeliveryName'],style: GoogleFonts.kanit(fontSize: 20)),
                          Spacer(),
                          //-----------Edit--------------
                          GestureDetector(
                            child: Container(
                              child: Icon(Icons.edit),
                            ),
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return EditForm();
                                  }),
                                  settings:
                                      RouteSettings(arguments: deliveryIndex.reference.id),
                                ),
                              );
                            },
                          ),
                          //-----------Delete------------
                          GestureDetector(
                            child: Container(
                              child: Icon(Icons.delete, color: Color.fromRGBO(221, 54, 91, 1)),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: Text('ยืนยัน',style: GoogleFonts.kanit(color: Color.fromRGBO(106, 27, 154, 1))),
                                      content: Text('คุณต้องการลบข้อมูลหรือไม่',style: GoogleFonts.kanit()),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('ยกเลิก',style: GoogleFonts.kanit(color: Colors.black))),
                                        TextButton(
                                            onPressed: () async {
                                              await _deliveryCollection
                                                  .doc(deliveryIndex.reference.id)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text('ลบข้อมูล',style: GoogleFonts.kanit(color: Color.fromRGBO(204, 11, 75, 1)))),
                                      ],
                                    )),
                              );
                            },
                          ),
                                            ],
                                          ),
                          subtitle: Row(
                          children: [
                          Text(deliveryIndex['DeliveryAge'],style: GoogleFonts.kanit(fontSize: 15)),
                        ],
                      ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(85, 15, 197, 1),
        child: Icon(
          Icons.add,
          color: Color.fromARGB(248, 255, 255, 255),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddForm(),
              ));
        },
      ),
    );
  }
}
