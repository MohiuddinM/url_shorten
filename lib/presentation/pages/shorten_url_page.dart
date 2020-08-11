import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_shorten/core/services.dart';
import 'package:url_shorten/presentation/blocs/url_shorten_bloc.dart';
import 'package:url_shorten/presentation/blocs/url_shortening_state.dart';
import 'package:validators/validators.dart' as validator;

class ShortenUrlsPage extends StatefulWidget {
  @override
  _ShortenUrlsPageState createState() => _ShortenUrlsPageState();
}

class _ShortenUrlsPageState extends State<ShortenUrlsPage> {
  final formKey = GlobalKey<FormState>();
  final urlController = TextEditingController();

  bool autoValidate = false;

  String validateUrl(String url) {
    if (!validator.isURL(url)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  Widget buildCancelButton() {
    final bloc = services<UrlShortenBloc>();

    return RaisedButton(
      onPressed: () => bloc.cancel(),
      child: Text('Cancel'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget buildShortenButton({bool loading = false}) {
    final bloc = services<UrlShortenBloc>();

    const loadingIcon = SpinKitCircle(
      color: Colors.white,
      size: 30,
    );

    return RaisedButton(
      color: Colors.deepPurple,
      onPressed: () {
        if (formKey.currentState.validate()) {
          bloc.shorten(urlController.text, context);
        } else {
          setState(() => autoValidate = true);
        }
      },
      child: loading ? loadingIcon : Text('Shorten', style: TextStyle(color: Colors.white)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget buildShortUrlBox({String shortUrl, bool collapsed = true}) {
    final formWidth = MediaQuery.of(context).size.width - 48;

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        color: Colors.grey[300],
      ),
      duration: Duration(milliseconds: 400),
      curve: Curves.fastLinearToSlowEaseIn,
      width: formWidth - 64,
      height: collapsed ? 0 : 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox.shrink(),
          AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: collapsed ? 0 : 1,
            child: Text(shortUrl),
          ),
          Visibility(
            visible: !collapsed,
            child: IconButton(
              iconSize: 16,
              icon: Icon(Icons.content_copy),
              onPressed: () {
                FlutterClipboardManager.copyToClipBoard(shortUrl).then((result) {
                  final snackBar = SnackBar(content: Text('Copied to Clipboard'));
                  Scaffold.of(context).showSnackBar(snackBar);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formWidth = MediaQuery.of(context).size.width - 48;
    final bloc = services<UrlShortenBloc>();

    return Container(
      child: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: formKey,
                    autovalidate: autoValidate,
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 65,
                        width: formWidth - 16,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: TextFormField(
                            onChanged: (_) => bloc.reset(),
                            controller: urlController,
                            validator: validateUrl,
                            keyboardType: TextInputType.url,
                            maxLines: 1,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              labelText: 'URL',
                              icon: Icon(Icons.link, size: 20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<UrlShorteningState>(
                      initialData: UrlShorteningState.idle(),
                      stream: bloc.state,
                      builder: (context, snapshot) {
                        final state = snapshot?.data ?? UrlShorteningState.idle();
                        String shortUrl = '';
                        bool collapsed;

                        state.when(
                          idle: (_) {
                            collapsed = true;
                          },
                          loaded: (o) {
                            collapsed = false;
                            shortUrl = o.shortUrl.shortenedUrl;
                          },
                          loading: (_) {
                            collapsed = true;
                          },
                          failed: (msg) {
                            collapsed = false;
                            shortUrl = msg.message;
                          },
                        );

                        return Column(
                          children: <Widget>[
                            buildShortUrlBox(shortUrl: shortUrl, collapsed: collapsed),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  buildCancelButton(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  ),
                                  buildShortenButton(loading: state == UrlShorteningState.loading()),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
