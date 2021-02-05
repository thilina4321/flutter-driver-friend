import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageFromGalleryOrCamera {
  static Future getProfileImage(context, var picker) async {
    bool type;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  type = true;
                  Navigator.pop(context);
                },
                child: Text('Gallery'),
              ),
              FlatButton(
                onPressed: () {
                  type = false;
                  Navigator.pop(context);
                },
                child: Text('Camera'),
              ),
            ],
            content: Container(
              height: 60,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Which option your prefered',
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    var pickedFile;
    if (type) {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }

    return pickedFile;
  }
}

// Future saveImage(context, [String imageType = 'profile']) async {
//     var pickedFile;
//     try {
//       pickedFile =
//           await PickImageFromGalleryOrCamera.getProfileImage(context, picker);
//       setState(() {
//         if (pickedFile != null) {
//           if (imageType == 'profile') {
//             driver.profileImageUrl = File(pickedFile.path);
//           } else {
//             driver.vehicleImageUrl = File(pickedFile.path);
//           }
//         } else {
//           print('No image selected.');
//         }
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
