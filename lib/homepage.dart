import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list_delivery.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController=PageController();
  List<Widget>pages=[ListDelivery()];

  int selectIndex=0;
  void onPageChanged(int index){
    setState(() {
      selectIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 236, 236, 1),
      body: Column(children : [
        Container(
        height: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [Color.fromRGBO(85, 15, 197, 1),Color.fromRGBO(126, 54, 243, 1)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter),
        ),
        child:  Row(    
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
               
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10),
                  child: Text(
                    'Delivereeb\n',
                   style: GoogleFonts.kanit(fontSize: 35, color: Color.fromARGB(248, 255, 255, 255)),
                   ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,left: 10,right: 0),
                  child: Text('\n\nเดริเวอร์รีบ',
                  style: GoogleFonts.kanit(fontSize: 20, color: Color.fromARGB(255, 247, 247, 247)),
                  
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.search,color: Colors.white,size: 30,),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 50),
        child:  Text(
          'WELCOME!',
        style: GoogleFonts.kanit(fontSize: 40, color: Color.fromARGB(255, 24, 24, 24)),
         ), 
      ),
      Container(
        //margin: EdgeInsets.only(),
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/Logo1.png'),
          fit: BoxFit.fill),
          shape: BoxShape.circle,
        ),
      ),
      ],
    ),
      
    );
  }
}
//รหัสสี
//251, 226, 180, 1 เหลือง
//56, 10, 116, 1  ม่วง
//43, 43, 43, 1 เทา