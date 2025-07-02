import 'dart:io';

import 'package:appfigurateflutter/appfigurateflutter.dart';
import 'package:appfigurateflutter_example/exampleconfiguration.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppfigurateLibrary.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    APLAddConfigurationUpdatedListener(configurationUpdated);
  }

  @override
  void dispose() {
    APLRemoveConfigurationUpdatedListener(configurationUpdated);
    super.dispose();
  }

  void configurationUpdated(String? action) {
    if (action != null) {
      print('Configuration updated by action $action');
    } else {
      print('Configuration updated');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var padding = media.padding.left == 0.0 ? 8.0 : media.padding.left;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Example ${APLVersion()}'),
      ),
      body:
      APLConfigurationLabel(child:
      ListView(
          padding: EdgeInsets.only(left: padding, right: padding),
          children: [
            ListTile(
              title: Text(Platform.isAndroid ? 'bool' : 'boolean'),
              subtitle:
              Text(ExampleConfiguration().boolean ? 'true' : 'false'),
            ),
            ListTile(
              title: const Text('string_Textfield'),
              subtitle: Text(ExampleConfiguration().string_Textfield),
            ),
            ListTile(
              title: const Text('string_RegexTextfield'),
              subtitle: Text(ExampleConfiguration().string_RegexTextfield),
            ),
            ListTile(
              title: const Text('string_List'),
              subtitle: Text(ExampleConfiguration().string_List),
            ),
            ListTile(
              title: const Text('string_Textfield_List'),
              subtitle: Text(ExampleConfiguration().string_Textfield_List),
            ),
            ListTile(
              title: const Text('string_RegexTextfield_List'),
              subtitle:
              Text(ExampleConfiguration().string_RegexTextfield_List),
            ),
            ListTile(
              title: const Text('encrypted_string_Textfield_List'),
              subtitle: Text(
                  ExampleConfiguration().encrypted_string_Textfield_List),
            ),
            ListTile(
              title: const Text('encrypted_string_RegexTextfield_List'),
              subtitle: Text(ExampleConfiguration()
                  .encrypted_string_RegexTextfield_List),
            ),
            ListTile(
              title: const Text('integer_Slider'),
              subtitle: Text('${ExampleConfiguration().integer_Slider}'),
            ),
            ListTile(
              title: const Text('integer_Textfield'),
              subtitle: Text('${ExampleConfiguration().integer_Textfield}'),
            ),
            ListTile(
              title: const Text('integer_RegexTextfield'),
              subtitle:
              Text('${ExampleConfiguration().integer_RegexTextfield}'),
            ),
            ListTile(
              title: const Text('integer_List'),
              subtitle: Text('${ExampleConfiguration().integer_List}'),
            ),
            ListTile(
              title: const Text('integer_Textfield_List'),
              subtitle:
              Text('${ExampleConfiguration().integer_Textfield_List}'),
            ),
            ListTile(
              title: const Text('integer_RegexTextfield_List'),
              subtitle: Text(
                  '${ExampleConfiguration().integer_RegexTextfield_List}'),
            ),
            ListTile(
              title: const Text('float_Slider'),
              subtitle: Text('${ExampleConfiguration().float_Slider}'),
            ),
            ListTile(
              title: const Text('float_Textfield'),
              subtitle: Text('${ExampleConfiguration().float_Textfield}'),
            ),
            ListTile(
              title: const Text('float_RegexTextfield'),
              subtitle:
              Text('${ExampleConfiguration().float_RegexTextfield}'),
            ),
            ListTile(
              title: const Text('float_List'),
              subtitle: Text('${ExampleConfiguration().float_List}'),
            ),
            ListTile(
              title: const Text('float_Textfield_List'),
              subtitle:
              Text('${ExampleConfiguration().float_Textfield_List}'),
            ),
            ListTile(
              title: const Text('float_RegexTextfield_List'),
              subtitle:
              Text('${ExampleConfiguration().float_RegexTextfield_List}'),
            ),
            ListTile(
              title: const Text('double_Slider'),
              subtitle: Text('${ExampleConfiguration().double_Slider}'),
            ),
            ListTile(
              title: const Text('double_Textfield'),
              subtitle: Text('${ExampleConfiguration().double_Textfield}'),
            ),
            ListTile(
              title: const Text('double_RegexTextfield'),
              subtitle:
              Text('${ExampleConfiguration().double_RegexTextfield}'),
            ),
            ListTile(
              title: const Text('double_List'),
              subtitle: Text('${ExampleConfiguration().double_List}'),
            ),
            ListTile(
              title: const Text('double_Textfield_List'),
              subtitle:
              Text('${ExampleConfiguration().double_Textfield_List}'),
            ),
            ListTile(
              title: const Text('double_RegexTextfield_List'),
              subtitle: Text(
                  '${ExampleConfiguration().double_RegexTextfield_List}'),
            ),
          ])
      ),
    );
  }

}
