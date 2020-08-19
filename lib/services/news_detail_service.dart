import 'package:url_launcher/url_launcher.dart';

// Yeah, boilerplate...
class NewsDetailService {
  openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
