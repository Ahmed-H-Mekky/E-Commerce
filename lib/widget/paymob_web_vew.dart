import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatefulWidget {
  final String paymentKey;

  const PaymobWebView({super.key, required this.paymentKey});

  @override
  State<PaymobWebView> createState() => _PaymobWebViewState();
}

class _PaymobWebViewState extends State<PaymobWebView> {
  late final WebViewController _controller;
  bool _isLoading = true; // مؤشر تحميل

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            //  عند نجاح الدفع
            if (request.url.contains("https://myapp.com/payment_done")) {
              Navigator.pop(context, true);
              return NavigationDecision.prevent;
            }

            //  عند فشل الدفع
            if (request.url.contains("https://myapp.com/payment_failed")) {
              Navigator.pop(context, false);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/970924?payment_token=${widget.paymentKey}',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إتمام الدفع"),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            ),
        ],
      ),
    );
  }
}
