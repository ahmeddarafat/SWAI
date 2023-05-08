import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  final String url;
  const ArticleWebView({super.key, required this.url});

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url){
          controller.runJavaScript("document.getElementsByTagName('header')[0].style.display='none'");
          controller.runJavaScript("document.getElementsByTagName('footer')[0].style.display='none'");

        }
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
