# Localizely SDK

[![pub package](https://img.shields.io/pub/v/localizely_sdk.svg)](https://pub.dev/packages/localizely_sdk)

### SDK setup

1. Update `pubspec.yaml` file:

<pre>
dependencies:
  ...
  <b>localizely_sdk: ^2.3.0</b>

flutter_intl:
  ...
  <b>localizely:
    ota_enabled: true</b> # Required for Over-the-air translation updates
</pre>

2. Trigger localization files generation by Flutter Intl IDE plugin or by [intl_utils](https://pub.dev/packages/intl_utils) library

3. Initialize Localizely SDK (e.g. `main.dart` file):

<pre>
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
<b>import 'package:localizely_sdk/localizely_sdk.dart';</b> // Import sdk package
import 'generated/l10n.dart';

void main() {
  <b>Localizely.init('&lt;SDK_TOKEN&gt;', '&lt;DISTRIBUTION_ID&gt;');</b> // Init sdk 
  <b>Localizely.setPreRelease(true);</b> // Add this only if you want to use prereleases
  <b>Localizely.setAppVersion('&lt;APP_VERSION&gt;');</b> // Add this only if you want to explicitly set the application version, or in cases when automatic detection is not possible (e.g. Flutter web apps)

  runApp(MaterialApp(
      onGenerateTitle: (context) => S.of(context).appTitle,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  State&lt;StatefulWidget&gt; createState() => _HomePageState();
}

class _HomePageState extends State&lt;HomePage&gt; {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    <b>Localizely.updateTranslations().then(</b> // Call 'updateTranslations' after localization delegates initialization
        <b>(response) => setState(() {
              _isLoading = false;
            }),
        onError: (error) => setState(() {
              _isLoading = false;
            }));</b>
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).pageHomeTitle)),
        body: Center(
            child: _isLoading ? CircularProgressIndicator() : Column(children: &lt;Widget&gt;[Text(S.of(context).welcome)])));
  }
}
</pre>

### More

Complete over-the-air documentation: [https://localizely.com/flutter-over-the-air/](https://localizely.com/flutter-over-the-air/)

Sample app with over-the-air translation updates: [https://github.com/localizely/flutter-ota-sample-app](https://github.com/localizely/flutter-ota-sample-app)
