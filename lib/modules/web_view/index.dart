import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../home/index.dart';
class MyWebView extends StatefulWidget{
  final String title;
  final String selectedUrl;

  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  _myWebViewState createState()=>_myWebViewState();
}
WebViewController controllerGlobal;
class _myWebViewState extends State<MyWebView> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();



  Future<bool> _exitApp(BuildContext context) async {
    //controllerGlobal.goBack();
    if (await controllerGlobal.canGoBack()) {
      print("onwill goback");
      controllerGlobal.goBack();
    } else {
      Scaffold.of(context).showSnackBar(
        const SnackBar(content: Text("No back history item")),
      );
      return Future.value(false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_exitApp(context),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              NavigationControls(_controller.future)
            ],
          ),

          body: WebView(
            initialUrl: widget.selectedUrl,
            javascriptMode: JavascriptMode.unrestricted,

            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          )),
    );
  }
}
class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        controllerGlobal = controller;

        return Row(
          children: <Widget>[
        IconButton(
        icon: const Icon(Icons.arrow_back_ios),
    onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    },
    ),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text("No back history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}