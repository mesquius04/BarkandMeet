import 'dart:async';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
                              Navigator.of(context).pop();
                            },
        ),
        title: const Row(
          children: [
            Spacer(),
            Text('Configuració'),
            Spacer(flex: 2),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Notificacions'),
              value: true,
              onChanged: (bool value) {},
              activeColor: Colors.purple,
            ),
            SwitchListTile(
              title: const Text('Localització'),
              value: true,
              onChanged: (bool value) {},
              activeColor: Colors.purple,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.yellow[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bark & Meet Gold',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Subscrieix-te a Gold i disfruta de totes les avantatges que això comporta:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureRow(Icons.verified, 'Marca de verificat'),
                  _buildFeatureRow(Icons.priority_high, 'Prioritza els teus gossos'),
                  _buildFeatureRow(Icons.photo, 'Publica més fotos dels teus gossos preciosos'),
                  _buildFeatureRow(Icons.location_on, 'Mira on son els teus amics quan passegen el gos'),
                  _buildFeatureRow(Icons.group, 'Ajuda’ns a poder continuar desenvolupant l’app'),
                  const SizedBox(height: 10),
                  const Text(
                    'Passat a Gold per només*: 19,99€/mes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '*Després el primer any, després 34.99€/mes',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  const CountdownTimer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Altres',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildButton('Privacitat'),
            _buildButton('Suport'),
            _buildButton('Mètodes de pagament'),
            _buildButton('Comunitat'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Mudança para cinza claro
                foregroundColor: Colors.black,
              ),
              child: const Text('Tancar sessió'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Mudança para preto
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar perfil'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(width: 10),
        Flexible(child: Text(text)),
      ],
    );
  }

  Widget _buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(text),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _duration = const Duration(hours: 29, minutes: 5, seconds: 13);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration -= const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'La oferta termina en: ${_duration.inHours.toString().padLeft(2, '0')}h ${(_duration.inMinutes % 60).toString().padLeft(2, '0')}min ${(_duration.inSeconds % 60).toString().padLeft(2, '0')}s',
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}