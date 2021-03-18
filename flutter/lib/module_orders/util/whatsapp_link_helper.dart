import 'dart:io';

class WhatsAppLinkHelper {
  static String getWhatsAppLink(String phone) {
    if (Platform.isAndroid) {
      return 'https://wa.me/$phone';
    } else {
      return 'whatsapp://send?phone=$phone';
    }
  }

  static String getMapsLink(double lat, double lon) {
    if (Platform.isAndroid) {
      return 'https://www.google.com/maps/dir/?api=1&destination=${lat},${lon}';
    } else {
      return 'comgooglemaps://www.google.com/maps/dir/?api=1&destination=${lat},${lon}';
    }
  }
}
