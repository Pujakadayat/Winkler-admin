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
            crossAxisCount: 6,
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
        );
//         return GridView.builder(
//   shrinkWrap: true,
//   itemCount: snapshot.data!.docs.length,
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 3, // Decreased the crossAxisCount for better visibility
//     mainAxisExtent: 100, // Increased size of the grid items
//     crossAxisSpacing: 8,
//     mainAxisSpacing: 8,
//   ),
//   itemBuilder: (context, index) {
//     final categoryData = snapshot.data!.docs[index];

//     // Debugging: Print out the data
//     print('Category Data: ${categoryData.data()}');
//     print('Image URL: ${categoryData['image']}');

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             height: 200, // Ensure proper size
//             width: 200,  // Ensure proper size
//             child: Image.network(
//               categoryData['image'],
//               loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                 if (loadingProgress == null) {
//                   return child;
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       value: loadingProgress.expectedTotalBytes != null
//                           ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
//                           : null,
//                     ),
//                   );
//                 }
//               },
//               errorBuilder: (context, error, stackTrace) {
//                   print("Image load error: $error");
//                 return Icon(Icons.error);  // Display error icon if image fails
//               },
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(categoryData['categoryName']),
//         ],
//       ),
//     );
//   },
// );

      },
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// // class CategoryWidget extends StatelessWidget {
// //   const CategoryWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final Stream<QuerySnapshot> _categoriesStream =
// //         FirebaseFirestore.instance.collection('categories').snapshots();

// //     return StreamBuilder<QuerySnapshot>(
// //       stream: _categoriesStream,
// //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //         if (snapshot.hasError) {
// //           return Text('Something went wrong');
// //         }

// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Center(
// //             child: CircularProgressIndicator(color: Colors.cyan),
// //           );
// //         }

// //         return SingleChildScrollView(
// //           child: GridView.builder(
// //             shrinkWrap: true,
// //             itemCount: snapshot.data!.size,
// //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 6,
// //               mainAxisExtent:8,  // Increased to ensure enough space
// //               crossAxisSpacing: 8,
// //             ),
// //             itemBuilder: (context, index) {
// //               final categoryData = snapshot.data!.docs[index];

// //               return Column(
// //                 children: [
// //                   SizedBox(
// //                     height: 100,
// //                     width: 100,
// //                     child: Image.network(categoryData['image']),
// //                   ),
// //                   SizedBox(height: 8), // Adding space between image and text
// //                   Text(
// //                     categoryData['categoryName'],
// //                     textAlign: TextAlign.center, // Center align text
// //                     overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
// //                   ),
// //                 ],
// //               );
// //             },
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// // class CategoryWidget extends StatelessWidget {
// //   const CategoryWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // final Stream<QuerySnapshot> _categoriesStream =
// //     //     FirebaseFirestore.instance.collection('categories').snapshots();
// // final Stream<QuerySnapshot> _categoriesStream =
// //     FirebaseFirestore.instance.collection('categories').snapshots();

// //     return SafeArea(
// //       child: SingleChildScrollView(
// //         child: StreamBuilder<QuerySnapshot>(
// //           stream: _categoriesStream,
// //           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //             if (snapshot.hasError) {
// //               return Text('Something went wrong');
// //             }

// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return Center(
// //                 child: CircularProgressIndicator(color: Colors.cyan),
// //               );
// //             }

// //             return GridView.builder(
// //               shrinkWrap: true,
// //               physics: NeverScrollableScrollPhysics(),  // Prevent GridView from scrolling independently
// //               itemCount: snapshot.data!.size,
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 6,
// //                 mainAxisExtent: 120,  // Increased to ensure enough space
// //                 crossAxisSpacing: 8,
// //               ),
// //               itemBuilder: (context, index) {
// //                 final categoryData = snapshot.data!.docs[index];

// //                 return ListView( // Wrap Column in ListView to avoid overflow
// //                   shrinkWrap: true,  // Ensure ListView doesn't take too much space
// //                   children: [
// //                     Column(
// //                       children: [
// //                         SizedBox(
// //                           height: 100,
// //                           width: 100,
// //                           child: 
// //                           // Image.network(
// //                           //   categoryData['image'],
// //                           //   fit: BoxFit.cover,  // Ensure the image fits within the box
                           
// //                           // ),
// //                          Image.network(
// //   categoryData['image'],
// //   fit: BoxFit.cover,
// //   loadingBuilder: (context, child, loadingProgress) {
// //     if (loadingProgress == null) {
// //       return child;
// //     }
// //     return Center(
// //       child: CircularProgressIndicator(
// //         value: loadingProgress.expectedTotalBytes != null
// //             ? loadingProgress.cumulativeBytesLoaded /
// //                 (loadingProgress.expectedTotalBytes ?? 1)
// //             : null,
// //       ),
// //     );
// //   },
// //   errorBuilder: (context, error, stackTrace) {
// //     return Icon(Icons.error, color: Colors.red); // Fallback UI in case of error
// //   },
// // )


// //                         ),
// //                         SizedBox(height: 8), // Adding space between image and text
// //                         Text(
// //                           categoryData['categoryName'],
// //                           textAlign: TextAlign.center,  // Center align text
// //                           overflow: TextOverflow.ellipsis,  // Ensure text doesn't overflow
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }



// // class CategoryWidget extends StatelessWidget {
// //   const CategoryWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final Stream<QuerySnapshot> _categoriesStream =
// //         FirebaseFirestore.instance.collection('categories').snapshots();

// //     return SafeArea(
// //       child: SingleChildScrollView(
// //         child: StreamBuilder<QuerySnapshot>(
// //           stream: _categoriesStream,
// //           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //             if (snapshot.hasError) {
// //               return Text('Something went wrong');
// //             }

// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return Center(
// //                 child: CircularProgressIndicator(color: Colors.cyan),
// //               );
// //             }

// //             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //               return Center(child: Text("No categories found"));
// //             }

// //             return GridView.builder(
// //               shrinkWrap: true,
// //               physics: NeverScrollableScrollPhysics(),
// //               itemCount: snapshot.data!.docs.length,
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 6,
// //                 mainAxisExtent: 120,
// //                 crossAxisSpacing: 8,
// //               ),
// //               itemBuilder: (context, index) {
// //                 final categoryData = snapshot.data!.docs[index];

// //                 // Safeguard against missing fields
// //                 final imageUrl = categoryData.data().toString().contains('image')
// //                     ? categoryData['image']
// //                     : null;
// //                 final categoryName = categoryData.data().toString().contains('categoryName')
// //                     ? categoryData['categoryName']
// //                     : "Unknown";

// //                 return ListView(
// //                   shrinkWrap: true,
// //                   children: [
// //                     Column(
// //                       children: [
// //                         SizedBox(
// //                           height: 100,
// //                           width: 100,
// //                           child: imageUrl != null
// //                               ? Image.network(
// //                                   imageUrl,
// //                                   fit: BoxFit.cover,
// //                                   errorBuilder: (context, error, stackTrace) {
// //                                     return Icon(Icons.error, color: Colors.red);
// //                                   },
// //                                 )
// //                               : Icon(Icons.image_not_supported, size: 40),
// //                         ),
// //                         SizedBox(height: 8),
// //                         Text(
// //                           categoryName,
// //                           textAlign: TextAlign.center,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }


// class CategoryWidget extends StatelessWidget {
//   const CategoryWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _categoriesStream =
//         FirebaseFirestore.instance.collection('categories').snapshots();

//     return SafeArea(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: _categoriesStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(color: Colors.cyan),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text("No categories found"));
//           }

//           return GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: snapshot.data!.docs.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 6,
//               mainAxisExtent: 120,
//               crossAxisSpacing: 8,
//             ),
//             itemBuilder: (context, index) {
//               final categoryData = snapshot.data!.docs[index];
//               final imageUrl = categoryData['image'];
//               final categoryName = categoryData['categoryName'] ?? "Unknown";

//               return SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: imageUrl != null && imageUrl.isNotEmpty
//                           ? Image.network(
//                               imageUrl,
//                               fit: BoxFit.cover,
//                               loadingBuilder: (context, child, loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               },
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Icon(Icons.error, color: Colors.red);
//                               },
//                             )
//                           : Icon(Icons.image_not_supported, size: 40),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       categoryName,
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
