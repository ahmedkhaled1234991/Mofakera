import 'package:share/share.dart';

class ShareFunction {
  Future<void> shareLink(String link) async {
    Share.share(link);
  }
}
