
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class VendorWidget extends StatelessWidget {
//   const VendorWidget({super.key});

// Widget vendorData(int? flex, Widget widget){

//   return Expanded(
//     flex:flex! , 
//     child: Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(color:Colors.grey)),
//       child:Padding(padding: const EdgeInsets.all(8),
//         child:widget ,
//       ),
    
//         ),
//     ),
//   );
// }


//   @override
//   Widget build(BuildContext context) {

// final Stream<QuerySnapshot> _vendorStream = FirebaseFirestore.instance
//     .collection('vendors')
//     .snapshots();

// // final Stream<QuerySnapshot> _vendorStream = 
// // FirebaseFirestore.instance.collection('vendors').snapshots();
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// return StreamBuilder<QuerySnapshot>(
//   stream: _vendorStream
//   , builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//     if(snapshot.hasError){
//       return Text('Something went wrong');
//     }
//     if(snapshot.connectionState == ConnectionState.waiting){
//       return Text('Loading');
//     }
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: snapshot.data!.docs.length,
//       itemBuilder: (context,index){
//         final vendorUserData = snapshot.data!.docs[index];
//         return Container(
//           child: Row(
//             children: [
//              vendorData(1, 
//           Container(
//             height: 50,
//             width: 50,
//             child: Image.network(vendorUserData['storeImage']),
//           ),
//           ),
//           vendorData(3,
//            Text('Winkler '),),
// vendorData(2,
// Text(
//   vendorUserData['cityValue'],
//   style:TextStyle(fontWeight: FontWeight.bold)
// ),
// ),
//           vendorData(2, 
//           Text(
//             vendorUserData['StateValue'],
//             style: TextStyle(fontWeight: FontWeight.bold),)
//             ),

//            vendorData(1, 
           
//            vendorUserData['approved'] == false
//            ?ElevatedButton(
//             onPressed: ()async{
// await _firestore.collection('vendors').doc(vendorUserData['vendorId']).update({
//   'approved':true,
// });
//             }, child: Text('Approved'))
//             :ElevatedButton(onPressed: ()async{
//               await _firestore.collection('vendors').doc(vendorUserData['vendorId']).update({
//   'approved':false,
// });
//             }, child:Text('Reject'))),
//            vendorData(1, ElevatedButton(onPressed: (){}, child: Text('View More'),),),
//         ],
//       ));
//       });

// return ListView.builder(
//   shrinkWrap: true,
//   itemCount: snapshot.data!.docs.length,
//   itemBuilder: (context, index) {
//     final vendorUserData = snapshot.data!.docs[index];

//     // Get the values for the fields, providing defaults if the field doesn't exist
//     final storeImage = vendorUserData['storeImage'] ?? 'https://via.placeholder.com/150';  // Default image URL
//      final bussinessName = vendorUserData['bussinessName'] ?? 'https://via.placeholder.com/150'; 
//      // Default image URL
//     final cityValue = vendorUserData['cityValue'] ?? 'Unknown City';  // Default text for city
//     final stateValue = vendorUserData['stateValue'] ?? 'Unknown State';  // Default text for state
//     final approved = vendorUserData['approved'] ?? false;  // Default value for approval status
//     final vendorId = vendorUserData['vendorId'] ?? '';  // Default value for vendor ID

//     return Container(
//       child: Row(
//         children: [
//           vendorData(
//             1,
//             Container(
//               height: 40,
//               width: 10,
//               child: Image.network(
//                 storeImage,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(Icons.broken_image);  // Handle image load error
//                 },
//               ),
//             ),
//           ),
//           vendorData(1,
//            Text(
//            bussinessName,
//            style: TextStyle(fontWeight: FontWeight.bold),
//            )),
//           vendorData(
//             1,
//             Text(
//               cityValue,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             Text(
//               stateValue,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             approved == false
//                 ? ElevatedButton(
//                     onPressed: () async {
//                       await _firestore.collection('vendors').doc(vendorId).update({
//                         'approved': true,
//                       });
//                     },
//                     child: Text('Approve'),
//                   )
//                 : ElevatedButton(
//                     onPressed: () async {
//                       await _firestore.collection('vendors').doc(vendorId).update({
//                         'approved': false,
//                       });
//                     },
//                     child: Text('Reject'),
//                   ),
//           ),
//           vendorData(
//             1,
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('View More'),
//             ),
//           ),
//         ],
//       ),
//     );
//   },
// );
// return ListView.builder(
//   shrinkWrap: true,
//   itemCount: snapshot.data!.docs.length,
//   itemBuilder: (context, index) {
//     final vendorUserData = snapshot.data!.docs[index];

//     // Get the values for the fields, providing defaults if the field doesn't exist
//     final storeImage = vendorUserData['storeImage'] ?? 'https://via.placeholder.com/150';  // Default image URL
//     final bussinessName = vendorUserData['bussinessName'] ?? 'Unknown Business';  // Default name
//     final cityValue = vendorUserData['cityValue'] ?? 'Unknown City';  // Default text for city
//     final stateValue = vendorUserData['stateValue'] ?? 'Unknown State';  // Default text for state
//     final approved = vendorUserData['approved'] ?? false;  // Default value for approval status
//     final vendorId = vendorUserData['vendorId'] ?? '';  // Default value for vendor ID

//     return Container(
//       child: Row(
//         children: [
//           vendorData(
//             1,
//             Container(
//               height: 40,
//               width: 40,
//               child: Image.network(
//                 storeImage,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(Icons.broken_image);  // Handle image load error
//                 },
//               ),
//             ),
//           ),
//           vendorData(
//             1,
//             Text(
//               bussinessName,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             Text(
//               cityValue,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             Text(
//               stateValue,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             approved == false
//                 ? ElevatedButton(
//                     onPressed: () async {
//                       await _firestore.collection('vendors').doc(vendorId).update({
//                         'approved': true,
//                       });
//                     },
//                     child: Text('Approve'),
//                   )
//                 : ElevatedButton(
//                     onPressed: () async {
//                       await _firestore.collection('vendors').doc(vendorId).delete();  // Delete vendor if rejected
//                     },
//                     child: Text('Reject'),
//                   ),
//           ),
//           vendorData(
//             1,
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('View More'),
//             ),
//           ),
//         ],
//       ),
//     );
//   },
// // );
// return ListView.builder(
//   shrinkWrap: true,
//   itemCount: snapshot.data!.docs.length,
//   itemBuilder: (context, index) {
//     final vendorUserData = snapshot.data!.docs[index];

//     // Get the values for the fields, providing defaults if the field doesn't exist
//     final storeImage = vendorUserData['storeImage'] ?? 'https://via.placeholder.com/150';  // Default image URL
//     final bussinessName = vendorUserData['bussinessName'] ?? 'Unknown Business';  // Default name
//     final cityValue = vendorUserData['cityValue'] ?? 'Unknown City';  // Default text for city
//     final stateValue = vendorUserData['stateValue'] ?? 'Unknown State';  // Default text for state
//     final approved = vendorUserData['approved'] ?? false;  // Default value for approval status
//     final vendorId = vendorUserData['vendorId'] ?? '';  // Default value for vendor ID

//     return Container(
//       child: Row(
//         children: [
//           vendorData(
//             1,
//             Container(
//               height: 40,
//               width: 40,
//               child: Image.network(
//                 storeImage,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(Icons.broken_image);  // Handle image load error
//                 },
//               ),
//             ),
//           ),
//           vendorData(
//             1,
//             Text(
//               bussinessName,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             Text(
//               cityValue,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             Text(
//               stateValue,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           vendorData(
//             1,
//             DropdownButton<String>(
//               value: approved ? 'Approve' : 'Reject',  // Default value based on approval status
//               items: ['Approve', 'Reject'].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) async {
//                 if (newValue == 'Approve') {
//                   await _firestore.collection('vendors').doc(vendorId).update({
//                     'approved': true,
//                   });
//                 // } else if (newValue == 'Reject') {
//                 //   await _firestore.collection('vendors').doc(vendorId).delete();  // Delete vendor if rejected
//                 if (newValue == 'Reject') {
//   print('Rejecting vendor with ID: $vendorId');
//   await _firestore.collection('vendors').doc(vendorId).delete().then((_) {
//     print('Vendor deleted successfully');
//   }).catchError((error) {
//     print('Failed to delete vendor: $error');
//   });
// }

                
//                 }
//               },
//             ),
//           ),
//           vendorData(
//             1,
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('View More'),
//             ),
//           ),
//         ],
//       ),
//     );
//   },
// );

//   },
// );
//   }
//   }

// class VendorWidget extends StatefulWidget {
//   const VendorWidget({super.key});

//   @override
//   _VendorWidgetState createState() => _VendorWidgetState();
// }

// class _VendorWidgetState extends State<VendorWidget> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Map to maintain the approval state for each vendor
//   Map<String, String> _approvalState = {};

//   Widget vendorData(int? flex, Widget widget) {
//     return Expanded(
//       flex: flex!,
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Container(
//           decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: widget,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('vendors').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading...');
//         }
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }

//         return ListView.builder(
//           shrinkWrap: true,
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             final vendorUserData = snapshot.data!.docs[index];

//             // Get the vendor details
//             final vendorId = vendorUserData.id; // Use the document ID
//             final storeImage = vendorUserData['storeImage'] ?? 'https://via.placeholder.com/150';
//             final businessName = vendorUserData['bussinessName'] ?? 'Unknown Business';
//             final cityValue = vendorUserData['cityValue'] ?? 'Unknown City';
//             final stateValue = vendorUserData['stateValue'] ?? 'Unknown State';

//             // Get the current approval state from the map or set default
//             final currentApproval = _approvalState[vendorId] ?? 'Reject';

//             return Container(
//               child: Row(
//                 children: [
//                   vendorData(
//                     1,
//                     Container(
//                       height: 40,
//                       width: 40,
//                       child: Image.network(
//                         storeImage,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Icon(Icons.broken_image);
//                         },
//                       ),
//                     ),
//                   ),
//                   vendorData(
//                     1,
//                     Text(
//                       businessName,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   vendorData(
//                     1,
//                     Text(
//                       cityValue,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   vendorData(
//                     1,
//                     Text(
//                       stateValue,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   vendorData(
//                     1,
//                     DropdownButton<String>(
//                       value: currentApproval, // Local state
//                       items: ['Approve', 'Reject'].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) async {
//                         if (newValue != null) {
//                           setState(() {
//                             _approvalState[vendorId] = newValue; 
//                           });

//                           if (newValue == 'Approve') {
//                             // Approve vendor in Firestore
//                             await _firestore.collection('vendors').doc(vendorId).update({
//                               'approved': true,
//                             });
//                             print('Vendor approved: $vendorId');
//                           } else if (newValue == 'Reject') {
//                             // Delete vendor from Firestore
//                             await _firestore.collection('vendors').doc(vendorId).delete();
//                             print('Vendor rejected and deleted: $vendorId');
//                           }
//                         }
//                       },
//                     ),
//                   ),
//                   vendorData(
//                     1,
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text('View More'),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  _VendorWidgetState createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Map to maintain the approval state for each vendor
  Map<String, String> _approvalState = {};

  Widget vendorData(int? flex, Widget widget) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('vendors').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final vendorUserData = snapshot.data!.docs[index];

            // Get the vendor details
            final vendorId = vendorUserData.id; // Use the document ID
            final storeImage = vendorUserData['storeImage'] ?? 'https://via.placeholder.com/150';
            final businessName = vendorUserData['bussinessName'] ?? 'Unknown Business';
            final cityValue = vendorUserData['cityValue'] ?? 'Unknown City';
            final stateValue = vendorUserData['stateValue'] ?? 'Unknown State';

            // Get the current approval state from the map or set default
            final currentApproval = _approvalState[vendorId] ?? 'Reject';

            return Container(
              child: Row(
                children: [
                  vendorData(
                    1,
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.network(
                        storeImage,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      ),
                    ),
                  ),
                  vendorData(
                    1,
                    Text(
                      businessName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  vendorData(
                    1,
                    Text(
                      cityValue,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  vendorData(
                    1,
                    Text(
                      stateValue,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  vendorData(
                    1,
                    DropdownButton<String>(
                      value: currentApproval, // Local state
                      items: ['Approve', 'Reject'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) async {
                        if (newValue != null) {
                          setState(() {
                            _approvalState[vendorId] = newValue; // Update local state
                          });

                          if (newValue == 'Approve') {
                            // Approve vendor in Firestore
                            await _firestore.collection('vendors').doc(vendorId).update({
                              'approved': true,
                            });
                            print('Vendor approved: $vendorId');
                          } else if (newValue == 'Reject') {
                            // Delete vendor from Firestore
                            await _firestore.collection('vendors').doc(vendorId).delete();
                            print('Vendor rejected and deleted: $vendorId');

                            // Optionally update the local state to reflect the deletion
                            setState(() {
                              // Remove the vendor from the list by updating the list index
                              snapshot.data!.docs.removeAt(index);
                            });
                          }
                        }
                      },
                    ),
                  ),
                  vendorData(
                    1,
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('View More'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
