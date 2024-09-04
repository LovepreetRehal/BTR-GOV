import 'package:flutter/material.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('Farmer Detail')),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 36),
                    Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 4,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  const Center(
                                    child: Text(
                                      'Go to Farmer Assets',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    '',
                                    'Enter farmer register id',
                                    '',
                                    (value) {
                                      // Handle the changed text
                                      print('FirstName changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle button press
                                          print('Button Pressed');
                                        },

                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white, backgroundColor: Colors.indigo[400], // Text color
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0), // px-5 py-2
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0), // Border radius similar to rounded-md
                                          ),
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold, // Font weight
                                            fontSize: 16, // Adjust font size as needed
                                          ),
                                        ).copyWith(
                                        ),
                                        child: const Text('Submit'),

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ]))),
                  ])),
        ));
  }

  Widget _buildTextField(
      String label,
      String hint,
      String? initialValue,
      ValueChanged<String?> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: TextEditingController(text: initialValue),
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
