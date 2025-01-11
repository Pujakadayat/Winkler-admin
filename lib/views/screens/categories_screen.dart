// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:multi_vendor_admin/views/screens/sidebarscreens/widgets/category_widget.dart';

// class CategoriesScreen extends StatefulWidget {
// static const String routeName= '\CategoriesScreen';

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseFirestore _firestore =  FirebaseFirestore.instance;

// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//  dynamic _image;

//   String? fileName;
//   late String categoryName;

//   // Method to pick an image from the device
//   Future<void> pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//     );

//     if (result != null) {
//       setState(() {
//         _image = result.files.first.bytes;
//         fileName = result.files.first.name;
//       });
//     }
//   }

// _uploadCategoryBannerToStorage(dynamic image) async{
//   Reference ref = _storage.ref().child("category images").child(fileName!);
//   UploadTask uploadTask = ref.putData(image);
// TaskSnapshot snapshot =  await uploadTask;
// String downloadUrl = await snapshot.ref.getDownloadURL();
// return downloadUrl;
// }

// uploadCategory() async{
//   EasyLoading.show();
// if(_formKey.currentState!.validate()){
// String imageUrl = await _uploadCategoryBannerToStorage(_image);

// await _firestore.collection('categories').doc(fileName).set({
//   'image' :imageUrl,
//   'categoryName': categoryName
// }).whenComplete((){
//   EasyLoading.dismiss();
//   setState(() {
//     _image= null;
//     _formKey.currentState!.reset();
//   });
// });
// }else{
//   print('O Bad Guy');
// }
// }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child:  Form(
//           key: _formKey,
//           child: Column(
//           children: [
//             Container(
//               alignment: Alignment.topLeft,
//               padding: const EdgeInsets.all(10),
//               child: const Text(
//                 'Categories',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 36,
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(14.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 140,
//                         width: 140,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade500,
//                           border: Border.all(color: Colors.grey.shade800),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child:
//                            _image != null
//                           ? Image.memory(
//                               _image,
//                               fit: BoxFit.cover,
//                             )
//                           : Center(
//                               child: Text("Category"),
//                             ),
//                     ),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shadowColor: Colors.yellow.shade900,
//                         ),
          
//                         onPressed: () {
//                           pickImage();
//                           },
//                         child: Text('Upload Image'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   child: SizedBox(
//                     width:180,
//                     child: TextFormField(
//                       onChanged: (value){
//                         categoryName = value;
//                       },
//                       validator: (value){
//                         if(value!.isEmpty){
//                           return "Please category Name Must not be empty";
//                         }else{
//                           return null;
//                         }
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Enter Category Name',
//                         hintText: "Enter Category name",
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 30),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shadowColor: Colors.yellow.shade900,
//                   ),
//                   onPressed: (){
//           uploadCategory();
//                   },
//                   child: Text("Save"),
//                 ),
//               ],
//             ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Divider(color:Colors.grey,),
// ),
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Container(
//     alignment: Alignment.topLeft,
//     child:
//    Text("Categories",
//    style:TextStyle(
//     fontSize: 36,
//      fontWeight:FontWeight.bold) ,),),
// ),
// CategoryWidget(),

//           ],
//                 ),
//         ),
//         );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_vendor_admin/views/screens/sidebarscreens/widgets/category_widget.dart';

// class CategoriesScreen extends StatefulWidget {
//   static const String routeName = '\CategoriesScreen';

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   dynamic _image;
//   String? fileName;
//   late String categoryName;

//   // Method to pick an image from the device
//  _pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//     );

//     if (result != null) {
//       setState(() {
//         _image = result.files.first.bytes;
//         fileName = result.files.first.name;
//       });
//     }
//   }

//   Future<String> _uploadCategoryBannerToStorage(dynamic image) async {
//     Reference ref = _storage.ref().child("categoryImages").child(fileName!);
//     UploadTask uploadTask = ref.putData(image);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

//   Future<void> uploadCategory() async {
//     EasyLoading.show();
//     if (_formKey.currentState!.validate()) {
//       String imageUrl = await _uploadCategoryBannerToStorage(_image);

//       await _firestore.collection('categories').doc(fileName).set({
//         'image': imageUrl,
//         'categoryName': categoryName,
//       }).whenComplete(() {
//         EasyLoading.dismiss();
//         setState(() {
//           _image = null;
//           _formKey.currentState!.reset();
//         });
//       });
//     } else {
//       print('Validation failed');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(8.0),
//       children: [
//         Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 36,
//                   ),
//                 ),
//               ),
//               Divider(color: Colors.grey),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 140,
//                           width: 140,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade500,
//                             border: Border.all(color: Colors.grey.shade800),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: _image != null
//                               ? Image.memory(
//                                   _image,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Center(
//                                   child: Text("Category"),
//                                 ),
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shadowColor: Colors.yellow.shade900,
//                           ),
//                           onPressed: (){
//                             _pickImage();
//                           },
//                           child: Text('Upload Image'),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Flexible(
//                     child: SizedBox(
//                       width: 180,
//                       child: TextFormField(
//                         onChanged: (value) {
//                           categoryName = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Category name must not be empty";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Enter Category Name',
//                           hintText: "Enter category name",
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 30),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shadowColor: Colors.blueGrey,
//                     ),
//                     onPressed:(){
//                        uploadCategory();
//                     },
//                     child: Text("Save"),
//                   ),
//                 ],
//               ),

//               Divider(
//                 color:Colors.grey,
//               ),
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Divider(color: Colors.grey),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Text(
//               //     "Categories",
//               //     style: TextStyle(
//               //       fontSize: 36,
//               //       fontWeight: FontWeight.bold,
//               //     ),
//               //   ),
//                //),
//               CategoryWidget(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//  }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// class CategoriesScreen extends StatefulWidget {
//   static const String routeName = '\CategoriesScreen';

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   dynamic _image;
//   String? fileName;
//   late String categoryName;

//   // Method to pick an image from the device
//   _pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//     );

//     if (result != null) {
//       setState(() {
//         _image = result.files.first.bytes;
//         fileName = result.files.first.name;
//       });
//     }
//   }

//   Future<String> _uploadCategoryBannerToStorage(dynamic image) async {
//     Reference ref = _storage.ref().child("categoryImages").child(fileName!);
//     UploadTask uploadTask = ref.putData(image);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

//   Future<void> uploadCategory() async {
//     EasyLoading.show();
//     if (_formKey.currentState!.validate()) {
//       String imageUrl = await _uploadCategoryBannerToStorage(_image);
//       print('Uploaded image URL: $imageUrl'); // Debugging line

//       await _firestore.collection('categories').doc(fileName).set({
//         'image': imageUrl,
//         'categoryName': categoryName,
//       }).whenComplete(() {
//         EasyLoading.dismiss();
//         setState(() {
//           _image = null;
//           _formKey.currentState!.reset();
//         });
//       });
//     } else {
//       print('Validation failed');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(8.0),
//       children: [
//         Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 padding: const EdgeInsets.all(10),
//                 child: const Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 36,
//                   ),
//                 ),
//               ),
//               Divider(color: Colors.grey),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 140,
//                           width: 140,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade500,
//                             border: Border.all(color: Colors.grey.shade800),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: _image != null
//                               ? Image.memory(
//                                   _image,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Center(
//                                   child: Text("Category"),
//                                 ),
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shadowColor: Colors.yellow.shade900,
//                           ),
//                           onPressed: () {
//                             _pickImage();
//                           },
//                           child: Text('Upload Image'),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Flexible(
//                     child: SizedBox(
//                       width: 180,
//                       child: TextFormField(
//                         onChanged: (value) {
//                           categoryName = value;
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Category name must not be empty";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Enter Category Name',
//                           hintText: "Enter category name",
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 30),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shadowColor: Colors.blueGrey,
//                     ),
//                     onPressed: () {
//                       uploadCategory();
//                     },
//                     child: Text("Save"),
//                   ),
//                 ],
//               ),
//               Divider(color: Colors.grey),
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               CategoryWidget(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic _image;
  String? fileName;
  late String categoryName;
  bool _isLoading = false;

  // Method to pick an image from the device
  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  Future<String> _uploadCategoryBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child("categoryImages").child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadCategory() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      String imageUrl = await _uploadCategoryBannerToStorage(_image);
      print('Uploaded image URL: $imageUrl'); // Debugging line

      await _firestore.collection('categories').doc(fileName).set({
        'image': imageUrl,
        'categoryName': categoryName,
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
          _image = null;
          _formKey.currentState!.reset();
        });
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
              ),
              Divider(color: Colors.grey),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            border: Border.all(color: Colors.grey.shade800),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _image != null
                              ? Image.memory(
                                  _image,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Text("Category"),
                                ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.yellow.shade900,
                          ),
                          onPressed: () {
                            _pickImage();
                          },
                          child: Text('Upload Image'),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 180,
                      child: TextFormField(
                        onChanged: (value) {
                          categoryName = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Category name must not be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Category Name',
                          hintText: "Enter category name",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blueGrey,
                    ),
                    onPressed: () {
                      uploadCategory();
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CategoryWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:multi_vendor_admin/views/screens/sidebarscreens/widgets/category_widget.dart';

// class CategoriesScreen extends StatefulWidget {
//   static const String routeName = '\CategoriesScreen';

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   dynamic _image;
//   String? fileName;
//   late String categoryName;

//   // Method to pick an image from the device
//   Future<void> pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//     );

//     if (result != null) {
//       setState(() {
//         _image = result.files.first.bytes;
//         fileName = result.files.first.name;
//       });
//     }
//   }

//   Future<String> _uploadCategoryBannerToStorage(dynamic image) async {
//     Reference ref = _storage.ref().child("category images").child(fileName!);
//     UploadTask uploadTask = ref.putData(image);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

//   Future<void> uploadCategory() async {
//     EasyLoading.show();
//     if (_formKey.currentState!.validate()) {
//       String imageUrl = await _uploadCategoryBannerToStorage(_image);

//       await _firestore.collection('categories').doc(fileName).set({
//         'image': imageUrl,
//         'categoryName': categoryName,
//       }).whenComplete(() {
//         EasyLoading.dismiss();
//         setState(() {
//           _image = null;
//           _formKey.currentState!.reset();
//         });
//       });
//     } else {
//       print('Validation failed');
//     }
//   }

// @override
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     child: Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               alignment: Alignment.topLeft,
//               padding: const EdgeInsets.all(10),
//               child: const Text(
//                 'Categories',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 36,
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(14.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 140,
//                         width: 140,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade500,
//                           border: Border.all(color: Colors.grey.shade800),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: _image != null
//                             ? Image.memory(
//                                 _image,
//                                 fit: BoxFit.cover,
//                               )
//                             : Center(
//                                 child: Text("Category"),
//                               ),
//                       ),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shadowColor: Colors.yellow.shade900,
//                         ),
//                         onPressed: pickImage,
//                         child: Text('Upload Image'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   child: SizedBox(
//                     width: 180,
//                     child: TextFormField(
//                       onChanged: (value) {
//                         categoryName = value;
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Category name must not be empty";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Enter Category Name',
//                         hintText: "Enter category name",
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 30),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shadowColor: Colors.yellow.shade900,
//                   ),
//                   onPressed: uploadCategory,
//                   child: Text("Save"),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Divider(color: Colors.grey),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Categories",
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             CategoryWidget(),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// }
