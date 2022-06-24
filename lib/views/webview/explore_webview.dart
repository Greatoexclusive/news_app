import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import 'package:news_app/utils/text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExploreWebview extends StatefulWidget {
  const ExploreWebview({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<ExploreWebview> createState() => _ExploreWebviewState();
}

class _ExploreWebviewState extends State<ExploreWebview> {
  late WebViewController controller;
  double progress = 0;
  bool onError = false;
  bool isLoading = true;
  String status = "";
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Expanded(
                child: WebView(
                  onProgress: (progress) {
                    setState(
                      () {
                        this.progress = progress / 100;
                      },
                    );
                  },
                  onWebViewCreated: ((controller) {
                    this.controller = controller;
                  }),
                  onPageStarted: (url) {
                    isLoading = true;
                    status = "";
                    setState(() {});
                  },
                  onPageFinished: (url) async {
                    isLoading = false;
                    if (status != "error") {
                      onError = false;
                      status = "";
                    }
                    setState(() {});
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.url,
                  onWebResourceError: (WebResourceError error) {
                    setState(
                      () {
                        onError = true;
                        status = "error";
                      },
                    );
                  },
                ),
              ),
              LinearProgressIndicator(
                value: progress,
                color: kPrimaryColor,
                backgroundColor: Colors.white,
              ),
              Visibility(
                visible: isLoading,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow,
                  ),
                ),
              ),
              Visibility(
                visible: onError,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: AppText.heading(
                          isLoading
                              ? "Reconnecting..."
                              : "Oops, something went wrong!",
                          height: 1,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          isLoading
                              ? "assets/processing.png"
                              : "assets/noconnection.png",
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: AppText.captionMedium(
                          isLoading
                              ? "Please wait"
                              : "Please check your internet connection and retry",
                          height: 1,
                          color: kPrimaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          isLoading = true;
                          Future.delayed(Duration(milliseconds: 500), () async {
                            await controller.reload();
                            onError == false;
                          });
                          setState(() {});

                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          width: MediaQuery.of(context).size.width - 60,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    color: Colors.grey,
                                    offset: Offset(0, 5))
                              ],
                              borderRadius: BorderRadius.circular(5),
                              color: kPrimaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText.captionMedium(
                                isLoading ? "Retrying . . . " : "Retry",
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              isLoading
                                  ? const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.refresh_rounded,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
