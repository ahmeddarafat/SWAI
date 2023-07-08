// demo

// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_solution2/resources/styles/app_colors.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class ArticleWebView extends StatefulWidget {
//   final String url;
//   const ArticleWebView({super.key, required this.url});

//   @override
//   State<ArticleWebView> createState() => _ArticleWebViewState();
// }

// class _ArticleWebViewState extends State<ArticleWebView> {
//   final Completer completer = Completer<WebViewController>();
//   late final WebViewController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             controller.runJavaScript(
//                 "document.getElementsByClassName('footer')[0].style.display ='none'");
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//     completer.complete(controller);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: FutureBuilder(
//           future: completer.future,
//           builder: (context, snapshot) {
//             log(snapshot.data.toString());
//             if (snapshot.hasData) {
//               return WebViewWidget(
//                 controller: snapshot.data!,
//               );
//             }else{
//             log("indicator");
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.darkBlue,
//               ),
//             );
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.small(
//         onPressed: () => Navigator.of(context).pop(),
//         backgroundColor: AppColors.darkBlue,
//         child: const Icon(Icons.arrow_back_ios_new),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
//     );
//   }
// }
