import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'Slot_Login.dart';
// import 'add_slot.dart';
// import 'package:flutter_firebase_series/screens/update_record.dart';

class Plantation extends StatefulWidget {
  const Plantation({Key? key}) : super(key: key);

  @override
  State<Plantation> createState() => _PlantationState();
}

class _PlantationState extends State<Plantation> {
  Query dbRef = FirebaseDatabase.instance.ref().child('AddNewSlot');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('AddNewSlot');

  Widget listItem({required Map student}) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int free_slot = 2;
    int full_slot = int.parse(student['total_slot']) - free_slot;
    var color = Colors.red.shade200;
    var bcolor = Colors.red;
    if (free_slot == 0) {
      color = Colors.red.shade200;
      bcolor = Colors.red;
    } else {
      color = Colors.green;
      bcolor = Colors.blue;
    }

    return Expanded(
      child: Row(
        children: [
          Container(
            height: 100,
            width: w * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green[300],
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            // height: 210,
            // color: Colors.green[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          student['slot_address'],
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Slot Details",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text("$add",style: TextStyle(fontSize: 18),),
                    // const Divider(
                    //   height: 20,
                    //   thickness: 2,
                    //   indent: 20,
                    //   endIndent: 20,
                    //   color: Colors.black,
                    // ),

                    // SizedBox(height: 15),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total : ",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.yellow),
                            ),
                            Text(
                              student['total_slot'],
                              style:
                                  TextStyle(fontSize: 17, color: Colors.yellow),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Free : $free_slot",
                          style: TextStyle(fontSize: 17, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Full : $full_slot",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ],
                ),
                Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 25, right: 8, bottom: 5),
                    child: (color == Colors.green)
                        ? ElevatedButton(
                            child: Text("Plant "),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Slot_Login()));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(bcolor)),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 7),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            height: 37,
                            width: 68,
                            child: Center(
                                child: Text(
                              "Close",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Free Slot"),
        actions: [
          Tooltip(
            message: 'Log Out',
            child: IconButton(
                onPressed: () {
                  AuthController.instance.logout();
                },
                icon: Icon(Icons.logout)),
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreen],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        elevation: 20,
        titleSpacing: 20,
      ),
      body: Container(
        color: Colors.green[200],
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map student = snapshot.value as Map;
            student['key'] = snapshot.key;

            return listItem(student: student);
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Add New Slot',
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Slot()));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:greener_v1/Citizen/Slot_Login.dart';
//
// class Plantation extends StatefulWidget {
//   const Plantation({Key? key}) : super(key: key);
//
//   @override
//   State<Plantation> createState() => _PlantationState();
// }
//
// class _PlantationState extends State<Plantation> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[200],
//       appBar: AppBar(
//         title: Text("Available Slot"),
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10,),
//             Container(
//               child: Row(
//                 children: [
//                   _Slot('Mota Varachha', 20, 7),
//                   _Slot('Nana Varachha', 20, 4),
//                 ],
//               ),
//             ),
//             SizedBox(height: 5,),
//             Container(
//               child: Row(
//                 children: [
//                   _Slot('Varachha', 43, 42),
//                   _Slot('Yogichowk', 4, 0),
//                 ],
//               ),
//             ),
//             SizedBox(height: 5,),
//             Container(
//               child: Row(
//                 children: [
//                   _Slot('Bardoli', 20, 0),
//                   _Slot('Amroli', 20, 4),
//                 ],
//               ),
//             ),
//             SizedBox(height: 5,),
//             Container(
//               child: Row(
//                 children: [
//                   _Slot('Katar Gam', 20, 0),
//                   _Slot('Vesu', 25, 12),
//                 ],
//               ),
//             ),
//             SizedBox(height: 5,),
//             Container(
//               child: Row(
//                 children: [
//                   _Slot('Puna Gam', 10, 10),
//                   _Slot('Mota Varachha', 32, 21),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _Slot(String add, int total_slot, int free_slot){
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     int full_slot = total_slot - free_slot;
//     var color = Colors.red.shade200;
//     var bcolor = Colors.red;
//     if(free_slot == 0) {
//       color = Colors.red.shade200;
//       bcolor = Colors.red;
//     } else {
//       color = Colors.green;
//       bcolor = Colors.blue;
//     }

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: color,
//       ),
//       margin:EdgeInsets.only(left: 10,top: 3.5,right: 2,bottom: 2.5) ,
//       padding: EdgeInsets.only(top: 7,left: 2,right: 2,bottom: 3),
//       height: 250,
//       width: w * 0.46,
//       // color: color,
//       child: Column(
//         children: [
//           Text("$add",style: TextStyle(fontSize: 18),),
//           const Divider(
//             height: 20,
//             thickness: 2,
//             indent: 20,
//             endIndent: 20,
//             color: Colors.black,
//           ),
//           SizedBox(height: 15),
//           Text("Total Slot : $total_slot",style: TextStyle(fontSize: 17,color: Colors.yellow),),
//           SizedBox(height: 8,),
//           Text("Free Slot : $free_slot",style: TextStyle(fontSize: 17,color: Colors.cyanAccent),),
//           SizedBox(height: 8,),
//           Text("Full Slot : $full_slot",style: TextStyle(fontSize: 17,color: Colors.red,)),
//             Container(
//             margin:EdgeInsets.only(left: 8,top: 25,right: 8,bottom:5) ,
//             child: (color == Colors.green) ?  ElevatedButton(
//               child: Text( "Plant "),
//               onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Slot_Login(area: add)));
//               },
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(bcolor)
//               ),
//             ) : Container(
//                   margin: EdgeInsets.only(top: 7),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(5)
//                   ),
//                   height: 37,
//                   width: 68,
//                   child: Center(child: Text("Close", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
//                 )
//           )
//         ],
//       ),
//     );
//   }
// }
