import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class BannerAdScreen extends StatefulWidget {
  const BannerAdScreen({Key? key}) : super(key: key);

  @override
  _BannerAdScreenState createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  String? _resultAd;

  @override
  void initState() {
    super.initState();
    _loadAdData();
  }

  Future<void> _loadAdData() async {
    final response =
        await http.get(Uri.parse('https://www.rrndev.xyz/adscanner'));
    if (response.statusCode == 200) {
      setState(() {
        String getBody = response.body;
        _resultAd = '<html><body>$getBody</body></html>';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _resultAd != null && _resultAd!.isNotEmpty
        ? Container(
            height: 50,
            child: WebView(
              initialUrl: Uri.dataFromString(_resultAd!, mimeType: 'text/html')
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
            ))
        : Container();
  }
}
