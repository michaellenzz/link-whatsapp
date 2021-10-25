import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Link WhatsApp',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home());
  }
}

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  var phone = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de link WhatsApp'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Gere um link para você iniciar uma conversa no WhatsApp sem a necessidade de adicionar o número ao seus contatos.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Número de telefone',
                  hintText: 'Ex: (12) 3 4567-8910'),
              inputFormatters: [phone],
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                child: const Text(
                  'Iniciar conversa',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  _launchURL(
                      'https://api.whatsapp.com/send?phone=55${phone.getUnmaskedText().replaceAll('+', '')}');
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Erro ao abrir o link';
}
