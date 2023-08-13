import 'dart:math';
import 'package:flutter/material.dart';

class NaiveBayesCrypto extends StatefulWidget {
  const NaiveBayesCrypto({super.key});

  @override
  State<NaiveBayesCrypto> createState() => _NaiveBayesCryptoState();
}

class _NaiveBayesCryptoState extends State<NaiveBayesCrypto> {
  // Data rata-rata dan variansi untuk masing-masing kategori ("naik" dan "turun")
  final Map<String, Map<String, double>> meanAndVariance = {
    'naik': {
      'mean_harga': 8228006.0,
      'mean_volume': 2.3207688823E11,
      'variance_harga': 5.119882004480007E12,
      'variance_volume': 3.2536179183018943E26
    },
    'turun': {
      'mean_harga': -12256361.0,
      'mean_volume': 8.021725914817E12,
      'variance_harga': 2.232797792295E13,
      'variance_volume': 1.2755496100687433E27
    },
  };

  // Contoh sampel baru yang akan diprediksi
  final Map<String, dynamic> newSample = {
    'perubahan_harga': -4091394.0,
    'perubahan_volume': -3.98905167207051E14
  };
  String predictedClass = '';

  @override
  void initState() {
    super.initState();
    predictClass(); // Memulai proses prediksi saat inisialisasi
  }

  void predictClass() {
    Map<String, double> probabilities = {};

    // Menghitung probabilitas untuk setiap kategori
    meanAndVariance.forEach((label, meanVariance) {
      double probability = calculateProbability(
              newSample['perubahan_harga'] ?? 0.0,
              meanVariance['mean_harga'] ?? 0.0,
              meanVariance['variance_harga'] ?? 0.0) *
          calculateProbability(
              newSample['perubahan_volume'] ?? 0.0,
              meanVariance['mean_volume'] ?? 0.0,
              meanVariance['variance_volume'] ?? 0.0);
      probabilities[label] = probability;
    });

    // Memilih hasil prediksi dengan probabilitas tertinggi
    MapEntry<String, double> predictedEntry = probabilities.entries.reduce(
        (entry1, entry2) => entry1.value > entry2.value ? entry1 : entry2);
    predictedClass = predictedEntry.key;
  }

  // Menghitung probabilitas distribusi normal (Gaussian)
  double calculateProbability(double x, double mean, double variance) {
    double exponent = exp(-(pow(x - mean, 2) / (2 * variance)));
    return (1 / (sqrt(2 * pi * variance))) * exponent;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Prediksi Harga Crypto'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Prediksi Harga Crypto:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              // Menampilkan hasil prediksi dengan warna teks yang sesuai
              Text(
                predictedClass,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: predictedClass == 'naik'
                      ? Colors.green
                      : predictedClass == 'turun'
                          ? Colors.red
                          : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
