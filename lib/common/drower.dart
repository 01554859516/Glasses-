

// import 'package:flutter/material.dart';

// class Drawer extends StatelessWidget {
//   const Drawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Drawer(
//         child: Column(
//           children: [
//             const UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("images/Amr.png"),
//                   // fit: BoxFit.cover,
//                 ),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage("images/amr.jpg"),
//               ),
//               accountEmail: Text(
//                 "Amr mohamed@gmail.com",
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                 ),
//               ),
//               accountName: Text(
//                 "amrmohamed",
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text("Home"),
//               leading: Icon(Icons.home),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text("My products"),
//               leading: Icon(Icons.add_shopping_cart),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text("About"),
//               leading: Icon(Icons.help_center),
//               onTap: () {},
//             ),
//             ListTile(
//               title: Text("Logout"),
//               leading: Icon(Icons.exit_to_app),
//               onTap: () {},
//             ),
//           ],
//         ),
//       )
    
//   }
// }