import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plate_recognizer/utils/omni_button.dart';

import 'data/services/file_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {ResultScreen.id: (context) => const ResultScreen()},
      home: const MyHomePage(title: 'Plate Recognizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final picker = ImagePicker();
  final FileService fileService = FileService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: size.width,
        child: loading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text('Analysing...')],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  OmniButton(
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    onPressed: () {
                      try {
                        picker
                            .pickImage(
                          source: ImageSource.camera,
                          imageQuality: 50,
                        )
                            .then((image) async {
                          try {
                            if (image != null) {
                              setState(() {
                                loading = true;
                              });
                              final path = image.path;
                              final byte = await File(path).readAsBytes();
                              var res = await fileService
                                  .uploadFile(byte, image.name, filePath: path);

                              if (res != null) {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pushNamed(context, ResultScreen.id,
                                    arguments: {
                                      'number': res.number,
                                      'url': res.url,
                                      'path': res.path,
                                    });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('success'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            setState(() {
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                content: Text(e.toString()),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        }).catchError((err) {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              content: Text(err.message),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        });
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            content: Text(e.toString()),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      } finally {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    text: 'Take picture',
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  OmniButton(
                    padding: const EdgeInsets.all(8),
                    width: 150,
                    onPressed: () {
                      try {
                        picker
                            .pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        )
                            .then((image) async {
                          try {
                            if (image != null) {
                              setState(() {
                                loading = true;
                              });
                              final path = image.path;
                              final byte = await File(path).readAsBytes();
                              var res = await fileService
                                  .uploadFile(byte, image.name, filePath: path);

                              if (res != null) {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pushNamed(context, ResultScreen.id,
                                    arguments: {
                                      'number': res.number,
                                      'url': res.url,
                                      'path': res.path,
                                    });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('success'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            setState(() {
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                content: Text(e.toString()),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        }).catchError((err) {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              content: Text(err.message),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        });
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            content: Text(e.toString()),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      } finally {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    text: 'Import from gallery',
                  )
                ],
              ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});
  static String id = '/result';
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Result'),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.file(File(args['path'] ?? '')),
            const Text(
              'Processed image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.network(args['url'] ?? ''),
            const Text(
              'Cropped image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Number',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(args['number'] ?? ''),
          ],
        ),
      ),
    );
  }
}
