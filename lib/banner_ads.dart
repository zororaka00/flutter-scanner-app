import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerAdScreen extends StatefulWidget {
  const BannerAdScreen({Key? key}) : super(key: key);

  @override
  State<BannerAdScreen> createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  String imageUrl = '';
  String linkUrl = '';

  @override
  void initState() {
    super.initState();
    _loadAdData();
  }

  Future<void> _loadAdData() async {
    final response =
        await http.get(Uri.parse('https://www.rrndev.xyz/adscanner'));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        print(responseBody);
        imageUrl = responseBody['image'];
        linkUrl = responseBody['link'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty && linkUrl.isNotEmpty
        ? InkWell(
            onTap: () => _launchURL(Uri.parse(linkUrl)),
            child: Flexible(child: Image.network(imageUrl)),
          )
        : Container();
  }

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      MotionToast.error(
              title: const Text("Error"),
              description: const Text('Could not launch URL'),
              position: MotionToastPosition.top)
          .show(context);
    }
  }
}
