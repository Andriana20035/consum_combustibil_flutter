import 'package:flutter/material.dart';

void main() {
  runApp(const FuelApp());
}

class FuelApp extends StatelessWidget {
  const FuelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator consum combustibil',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16866A),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F8F6),
      ),
      home: const FuelPage(),
    );
  }
}

class FuelPage extends StatefulWidget {
  const FuelPage({super.key});

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {

  final TextEditingController distantaController = TextEditingController();
  final TextEditingController combustibilController = TextEditingController();

  double? rezultat;
  String? eroare;

  void calculeazaConsum() {

    double? distanta = double.tryParse(
      distantaController.text.trim().replaceAll(',', '.'),
    );

    double? combustibil = double.tryParse(
      combustibilController.text.trim().replaceAll(',', '.'),
    );

    if (distanta == null ||
        combustibil == null ||
        distanta <= 0 ||
        combustibil <= 0) {

      setState(() {
        eroare = 'Introdu valori numerice mai mari decat zero!';//verificam daca datele sunt corecte
        rezultat = null;
      });

      return;
    }

    setState(() {
      rezultat = (combustibil / distanta) * 100;
      eroare = null;
    });

    FocusScope.of(context).unfocus();
  }

  void stergeDatele() {
    distantaController.clear();
    combustibilController.clear();

    setState(() {
      rezultat = null;
      eroare = null;
    });
  }

  @override
  void dispose() {
    distantaController.dispose();
    combustibilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const verde = Color(0xFF16866A);

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Fuel Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: verde,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFFD9F3E8),
              child: Icon(
                Icons.local_gas_station,
                size: 44,
                color: verde,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Calculeaza consumul',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Afla consumul mediu al automobilului tau',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 32),

            Card(
              elevation: 2,
              color: Colors.white,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [

                    const Text(
                      'Datele calatoriei',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    TextField(
                      controller: distantaController,
                      keyboardType:
                      const TextInputType.numberWithOptions(
                        decimal: true,
                      ),

                      decoration: const InputDecoration(
                        labelText: 'Distanta parcursa',
                        hintText: 'Ex: 450',
                        prefixIcon: Icon(Icons.route),
                        suffixText: 'km',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: combustibilController,
                      keyboardType:
                      const TextInputType.numberWithOptions(
                        decimal: true,
                      ),

                      decoration: const InputDecoration(
                        labelText: 'Combustibil consumat',
                        hintText: 'Ex: 32',
                        prefixIcon: Icon(Icons.local_gas_station),
                        suffixText: 'L',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton.icon(
                      onPressed: calculeazaConsum,

                      icon: const Icon(Icons.calculate),

                      label: const Text(
                        'CALCULEAZA CONSUMUL',
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: verde,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(18),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextButton(
                      onPressed: stergeDatele,
                      child: const Text('Sterge datele'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (eroare != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  eroare!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            if (rezultat != null)
              Container(
                padding: const EdgeInsets.all(28),

                decoration: BoxDecoration(
                  color: const Color(0xFFD9F3E8),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [

                    const Icon(
                      Icons.check_circle,
                      color: verde,
                      size: 40,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'CONSUM MEDIU',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: verde,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '${rezultat!.toStringAsFixed(2)} L/100 km',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: verde,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Consumul mediu al automobilului tau',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            const Text(
              'Formula: (Litri consumati / Distanta) x 100',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

          ],
        ),
      ),
    );
  }
}