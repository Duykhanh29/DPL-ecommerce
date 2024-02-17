import 'package:dpl_ecommerce/customs/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebViewScreen extends StatefulWidget {
  CommonWebViewScreen({super.key, this.name = "", required this.url});
  String name;
  String url;

  @override
  State<CommonWebViewScreen> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebViewScreen> {
  WebViewController _webViewController = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeWebView();
  }

  Future<void> initializeWebView() async {
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {},
          onPageFinished: (page) {
            _webViewController.runJavaScript(
                "document.querySelectorAll('*').forEach(function(el) { el.style.fontSize = '115%'; });");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(centerTitle: true, context: context, title: widget.name)
              .show(),
      body: buildBody(),
    );
  }

  buildBody() {
    return SizedBox.expand(
      child: Container(
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
