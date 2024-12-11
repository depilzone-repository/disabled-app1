import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreUtil{



  static launchWhatsapp() async {
    var contact = "+51980924651";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hola, necesito información";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hola, necesito información')}";

    try{
      if (!kIsWeb) {
        if(Platform.isIOS){
          // await launchUrl(Uri.parse(iosUrl));
          await launch(iosUrl);
        }
        else{
          // await launchUrl(Uri.parse(androidUrl));
          await launch(androidUrl);
        }
      }else{
        // await launchUrl(Uri.parse(iosUrl));
        await launch(iosUrl);
      }

    } on Exception{
      EasyLoading.showError('WhatsApp is not installed.');
    }
  }

}