import 'dart:io';

class WhatsAppLinkHelper {
  static String getWhatsAppLink(String phone) {
    if (Platform.isAndroid) {
      return 'https://wa.me/$phone/?text=${Uri.parse('السلام عليكم')}';
    } else {
      return 'https://api.whatsapp.com/send?phone=$phone=${Uri.parse('السلام عليكم')}';
    }
  }

  static String getMapsLink(double lat, double lon) {
    if (Platform.isAndroid) {
      return 'https://www.google.com/maps/dir/?api=1&destination=${lat},${lon}';
    } else {
      return 'https://www.google.com/maps/dir/?api=1&destination=${lat},${lon}';
    }
  }
}
