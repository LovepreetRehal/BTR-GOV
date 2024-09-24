import 'dart:convert';
import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/model/SingleFarmerModel.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:btr_gov/screens/assets_deatil_screen.dart';
import 'package:flutter/material.dart';

class AssetsScreen extends StatefulWidget {
  AssetsScreen();

  @override
  _AssetsScreen createState() => _AssetsScreen();
}

class _AssetsScreen extends State<AssetsScreen> {
  Singlefarmermodel? _Allfarmar;
  bool loadlist = false; // This will manage the loading state
  String? _VillageName = '';
  var paramdic = {"": ""};
  TextEditingController _registrationIdController = TextEditingController();
  // Fetch the data from API
  void getdata() {
    setState(() {
      loadlist = true; // Set to true before starting the API call
    });

    ApiClient().getAssetsSearchData(Utils.assetsSearch, true, paramdic).then((onValue) {
      if (onValue.statusCode == 200) {
        var responseBody = onValue.body;
        print("Response Body: $responseBody");

        try {
          var data = json.decode(responseBody);
          print("Decoded JSON: $data");

          if (data is Map<String, dynamic> && data['data'] != null) {
            _Allfarmar = Singlefarmermodel.fromJson(data);
            print("Parsed Data: ${_Allfarmar?.toJson()}");
            Utils.toast(_Allfarmar!.message);

            // Navigate to the next screen after successful data fetch
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AssetsDeatilScreen(farmerData: _Allfarmar)),
            );
          } else {
            print("Error: 'data' is null or unexpected structure");
            Utils.toast(data['errors']);
          }
        } catch (e) {
          print("Error parsing data: $e");
        }
      } else {
        print("Error: ${onValue.statusCode}");
        Utils.toast('The registration id field is required.');
      }

      setState(() {
        loadlist = false; // Set to false after the data is loaded
      });
    }).catchError((error) {
      print("Error: $error");
      Utils.toast('The registration id field is required.');
      setState(() {
        loadlist = false; // Set to false even if there is an error
      });
    });
  }





  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFE6E8FF),
        // backgroundColor: Color(0xFF2F365F),
        title: Row(
          children: [
            Image.asset(
              'resources/image/BTRgov-logo.png', // Path to your logo
              height: 50, // Adjust height as needed
            ),
            SizedBox(width: 8), // Space between logo and title
            // Text(
            //   'Add Farmer',
            //   style: TextStyle(color: Colors.black), // Text color
            // ),
          ],
        ),
        centerTitle: false, // Center title is false since we are using Row

      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          _buildTextField1(
                            'Farmer Register ID',
                            'Enter farmer register id',
                            _registrationIdController,
                                (value) {
                              // Handle the changed text if needed
                              print('Farmer Register ID changed: $value');
                            },
                          ),

                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  String registrationId = _registrationIdController.text.trim();
                                  paramdic["registration_id"] = registrationId; // Update with actual ID
                                  // paramdic["registration_id"] = '724221590191084490'; // Update with actual ID
                                  loadlist = true; // Show the progress bar
                                  setState(() {});
                                  getdata(); // Fetch data

                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.indigo[400], // Text color
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Show loading spinner when data is loading
          if (loadlist)
            Container(
              color: Colors.black54, // Semi-transparent overlay
              child: Center(
                child: CircularProgressIndicator(), // Progress bar in the center
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField1(String label, String hint, TextEditingController controller, ValueChanged<String?> onChanged,) {
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
            controller: controller,
            style: const TextStyle(fontSize: 14),
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
