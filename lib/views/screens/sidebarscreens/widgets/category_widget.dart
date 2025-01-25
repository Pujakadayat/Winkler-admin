import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class CategoryWidget extends StatelessWidget {
//   const CategoryWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//      final Stream<QuerySnapshot> _categoriesStream = FirebaseFirestore.instance.collection('categories').snapshots();
//     return StreamBuilder<QuerySnapshot>(
//       stream: _categoriesStream,
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
//             final categoryData = snapshot.data!.docs[index];
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 100,width: 100,child:
//                    Image.network(categoryData['image'],),
//                   ),
//                   Text(categoryData['categoryName'],),
//                 ],
//               ),
//             );

//           }
//           );
//       },
//     );
//   }
// }

// class CategoryWidget extends StatelessWidget {
//   const CategoryWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _categoriesStream = FirebaseFirestore.instance.collection('categories').snapshots();

//     return StreamBuilder<QuerySnapshot>(
//       stream: _categoriesStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(color: Colors.cyan),
//           );
//         }

//         if (snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No categories available.'));
//         }

//         return GridView.builder(
//           shrinkWrap: true,
//           itemCount: snapshot.data!.docs.length,  // Use length instead of size
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 6,
//             mainAxisExtent: 8,
//             crossAxisSpacing: 8,
//           ),
//           itemBuilder: (context, index) {
//             final categoryData = snapshot.data!.docs[index];

//             // Debugging: print image URL
//             print('Image URL: ${categoryData['image']}');

//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 100,
//                     width: 100,
//                     child: Image.network(
//                       categoryData['image'],
//                       errorBuilder: (context, error, stackTrace) {
//                         return Icon(Icons.error);  // Display error icon if image fails
//                       },
//                     ),
//                   ),
//                   Text(categoryData['categoryName']),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream = FirebaseFirestore.instance.collection('categories').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No categories available.'));
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final categoryData = snapshot.data!.docs[index];

            // Debugging: Print out the data
            print('Category Data: ${categoryData.data()}');
            print('Image URL: ${categoryData['image']}');

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150, // Ensure proper size
                    width: 150,  // Ensure proper size
                    child: Image.network(
                      categoryData['image'],
                       loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
                      errorBuilder: (context, error, stackTrace) {
                          print("Image load error: $error");
                        return Icon(Icons.error);  // Display error icon if image fails
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(categoryData['categoryName']),
                ],
              ),
            );
          },
        );      },
    );
  }
}

