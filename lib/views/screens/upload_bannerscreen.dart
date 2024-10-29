// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class UploadBannerscreen extends StatefulWidget {
// static const String routeName= '\UploadBannerscreen';

//   @override
//   State<UploadBannerscreen> createState() => _UploadBannerscreenState();
// }

// class _UploadBannerscreenState extends State<UploadBannerscreen> {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
// dynamic _image;

// String? FileName;

// pickImage() async {
//   FilePickerResult?
//    result= await FilePicker.platform.pickFiles(allowMultiple: false, 
//    type: FileType.image);
// if(result!=null){
//   setState(() {
//     _image= result.files.first.bytes;

//     FileName= result.files.first.name;
//   });
// }

// }
// _UploadBannerscreenState(dynamic image) async {
//   Reference ref =_storage.ref().child('Banners').child(FileName!);

//  UploadTask uploadTask= ref.putData(image);

//   TaskSnapshot snapshot = await uploadTask;
//  String downloadUrl= await snapshot.ref.getDownloadURL();
// //  return downloadUrl;
// }
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.topLeft,
//               padding: const EdgeInsets.all(10),
//               child: const Text(
//                 'Banners',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 36,
//                 ),
//               ),
//             ),
//             Divider(color: Colors.grey),
//             Row(children: [
//               Padding(
//                 padding: const EdgeInsets.all(14.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 140,
//                       width:140,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade500,
//                        border: Border.all(color: Colors.grey.shade800) ,
//                        borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: _image!= null?
//                        Image.memory(
//                         _image,
//                         fit:BoxFit.cover,)
//                         :Center(
//                         child: Text("Banners"),
//                       ),
//                     ),
//                  SizedBox(height:20),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
// shadowColor:Colors.yellow.shade900,
//                 ),
//                 onPressed: (){
//                   pickImage();
//                 },
//                      child: Text('Upload Image'))
//                   ],
//                 ),
//               ),
//               SizedBox(width: 30,),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
// shadowColor:Colors.yellow.shade900,
//                 ),
//                 onPressed: () {},
//                child: Text("Save"))
//             ],)
//           ],
//         ),
//         );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_vendor_admin/views/screens/sidebarscreens/widgets/banner_widgets.dart';

class UploadBannerscreen extends StatefulWidget {
  static const String routeName = '/UploadBannerscreen';

  @override
  State<UploadBannerscreen> createState() => _UploadBannerscreenState();
}

class _UploadBannerscreenState extends State<UploadBannerscreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
    final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  dynamic _image;
  String? fileName;

  // Method to pick an image from the device
  Future<void> pickImage() async {
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

  // Method to upload the image to Firebase Storage
  Future<void> uploadImage() async {
    if (_image != null && fileName != null) {
      Reference ref = _storage.ref().child('Banners').child(fileName!);
      UploadTask uploadTask = ref.putData(_image);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download URL: $downloadUrl"); // Log or use the download URL
    } else {
      print("No image selected");
    }
  }
uploadToFirebaseStore() async{
  EasyLoading.show();
  if(_image!=null){
   String imageUrl=await  _uploadBannersToStorage(_image);

   await _firestore.collection('banners').doc(fileName).set({
    'image': imageUrl,
   }).whenComplete((){
    EasyLoading.dismiss();
    setState(() {
      _image = null;
    });
   });
  }
}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey),
          ),
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
                              child: Text("Banners"),
                            ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.yellow.shade900,
                      ),
                      onPressed: pickImage,
                      child: Text('Upload Image'),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.yellow.shade900,
                ),
                onPressed: (){
                  uploadToFirebaseStore();
                },
                child: Text("Save"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(color:Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text('Banners', style:TextStyle(fontSize: 36,
              fontWeight: FontWeight.bold,),),
            ),
          ),
          BannerWidget(),
        ],
      ),
    );
  }
  
  _uploadBannersToStorage(image) {}
}
