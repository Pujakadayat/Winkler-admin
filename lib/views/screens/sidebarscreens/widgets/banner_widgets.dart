// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class BannerWidget extends StatelessWidget {
//   const BannerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//      final Stream<QuerySnapshot> _bannersStream = FirebaseFirestore.instance.collection('banners').snapshots();
//     return StreamBuilder<QuerySnapshot>(
//       stream: _bannersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(color:Colors.cyan),
//           );
//         }

//         return GridView.builder(
//           shrinkWrap: true,
//           itemCount: snapshot.data!.size,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 6,
//           mainAxisExtent: 8,
//           crossAxisSpacing: 8
//           ), 
//           itemBuilder:(context,index){
//             final bannerData = snapshot.data!.docs[index];
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 100,width: 100,
//                   child: 
//                   Image.network(bannerData['image'],),
//                   ),
              
//                 ],
//               ),
//             );

//           }
//           );
//       },
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class BannerWidget extends StatelessWidget {
//   const BannerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _bannersStream =
//         FirebaseFirestore.instance.collection('banners').snapshots();

//     return StreamBuilder<QuerySnapshot>(
//       stream: _bannersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(color: Colors.cyan),
//           );
//         }

//         return SingleChildScrollView( // Wrapping the entire grid in SingleChildScrollView
//           child: GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),  // Prevent GridView from scrolling independently
//             itemCount: snapshot.data!.size,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 6,
//               mainAxisExtent: 120,  // Set a height for each item in the grid
//               crossAxisSpacing: 8,
//             ),
//             itemBuilder: (context, index) {
//               final bannerData = snapshot.data!.docs[index];

//               return ListView( // Wrapping the content of each grid item in a ListView
//                 shrinkWrap: true, // Allow ListView to take only as much space as needed
//                 children: [
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: 100,
//                         width: 100,
//                         child: Image.network(
//                           bannerData['image'],
//                           fit: BoxFit.cover, // Ensure image fits properly in the box
//                           // errorBuilder: (context, error, stackTrace) {
//                           //   return Center(child: Icon(Icons.error)); // Show error if image fails to load
//                           // },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }


class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _bannersStream =
        FirebaseFirestore.instance.collection('banners').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _bannersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No banners available.'));
        }

        return SingleChildScrollView(
          child:
           GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisExtent: 120,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final bannerData = snapshot.data!.docs[index];

              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: 
                    Image.network(
                      bannerData['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.broken_image, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
