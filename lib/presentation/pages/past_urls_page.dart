import 'package:flutter/material.dart';
import 'package:url_shorten/core/services.dart';
import 'package:url_shorten/presentation/blocs/url_shorten_bloc.dart';
import 'package:validators/validators.dart' as validator;


class PastUrlsPage extends StatefulWidget {
  @override
  _PastUrlsPageState createState() => _PastUrlsPageState();
}

class _PastUrlsPageState extends State<PastUrlsPage> {
  final formKey = GlobalKey<FormState>();
  final urlController = TextEditingController();

  bool autoValidate = false;

  String validateUrl(String url) {
    if (!validator.isURL(url)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formWidth = MediaQuery.of(context).size.width - 48;
    final bloc = services<UrlShortenBloc>();

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 64.0),
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
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 64,
                          width: formWidth - 16,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: TextFormField(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => bloc.cancel(),
                            child: Text('Cancel'),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                          ),
                          RaisedButton(
                            color: Colors.green[300],
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                bloc.shorten(urlController.text);
                              } else {
                                setState(() => autoValidate = true);
                              }
                            },
                            child: Text('Shorten'),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
