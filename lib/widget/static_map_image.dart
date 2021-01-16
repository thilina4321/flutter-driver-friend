const API_KEY = 'AIzaSyDmno8-8jbPOH50GcUiM0qvgM0Qum50Yvo';

class LocationHelper {
  static String generateGoogleImage({double lat, double long}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:D%7C$lat,$long&key=$API_KEY';
  }
}

// Future<void> getLocation() async {
//     try {
//       final locData = await Location().getLocation();
//       print(locData);
//       final img = LocationHelper.generateGoogleImage(
//           lat: locData.latitude, long: locData.longitude);
//       setState(() {
//         _mapImagePreview = img;
//       });
//     } catch (e) {
//       print('error');
//     }
//   }
