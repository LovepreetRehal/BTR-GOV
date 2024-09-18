


//CreateSoilDetails


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_crop_details.dart';

class CreateSoilDetails extends StatefulWidget {

  CreateSoilDetails();

  @override
  _CreateSoilDetailsScreen createState() => _CreateSoilDetailsScreen();
}

class _CreateSoilDetailsScreen extends State<CreateSoilDetails> {

  final List<String>  _soilType = ['Wet','Sand', 'Red Soil','Alluvial','Piedmont', 'Hill' ,'Lateritic'];
  String? _selectedSoilType = '--selected--'; // Set initial value to match the list

  String? _nitrogenLevelName = '';
  String? _potassiumLevel = '';
  String? _phosphorusLevel = '';
  String? _phLevel = '';
  String? _carbonLevel = '';
  String? _zincLevel = '';
  String? _sulphurLevel = '';
  String? _boronLevel = '';
  String? _selectedDate = ''; // State variable for storing the selected date

  final TextEditingController _nitrogenLevelController = TextEditingController();
  final TextEditingController _potassiumLevelController = TextEditingController();
  final TextEditingController _phosphorusLevelController = TextEditingController();
  final TextEditingController _phLevelController = TextEditingController();
  final TextEditingController _carbonController = TextEditingController();
  final TextEditingController _zincLevelController = TextEditingController();
  final TextEditingController _sulphurLevelController = TextEditingController();
  final TextEditingController _boronLevelController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Farmer Detail')),
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text('Create Soil Details'),
             leading: IconButton(
             icon: Icon(Icons.arrow_back), // Custom icon
              onPressed: () {
                // Custom behavior when the back button is pressed
              Navigator.pop(context);
              },),),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Soil Type ✫:', _selectedSoilType, _soilType,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedSoilType = newValue;
                                        });
                                      }),


                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Nitrogen Level:',
                                    'Enter Nitrogen Level',
                                    _nitrogenLevelController,
                                        (value) {
                                          _nitrogenLevelName = value;

                                      // Handle the changed text
                                      print('Email changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Potassium Level :',
                                    'Enter Potassium Level',
                                    _potassiumLevelController,
                                        (value) {
                                      // Handle the changed text
                                      _potassiumLevel = value;
                                      print('Email changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Phosphorus Level :',
                                      'Enter Phosphorus Level',
                                      _phosphorusLevelController,
                                          (value) {
                                        // Handle the changed text
                                        _phosphorusLevel = value;
                                        print('phosphorusLevel changed: $value');
                                      }
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'pH Level :',
                                      'Enter pH Level',
                                      _phLevelController,
                                          (value) {
                                        // Handle the changed text
                                        _phLevel = value;
                                        print('phosphorusLevel changed: $value');
                                      }
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Carbon Level :',
                                      'Enter organic carbon level',
                                      _carbonController,
                                          (value) {
                                        // Handle the changed text
                                        _carbonLevel = value;
                                        print('_carbonController changed: $value');
                                      },maxLength: 6,isPhone: true
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Zinc Level :',
                                      'Enter Zinc Level',
                                      _zincLevelController,
                                          (value) {
                                        // Handle the changed text
                                        _zincLevel = value;
                                        print('_zincLevel changed: $value');
                                      },maxLength: 6,isPhone: true
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Sulphur Level :',
                                      'Enter Sulphur Level',
                                      _sulphurLevelController,
                                          (value) {
                                        // Handle the changed text
                                        _sulphurLevel = value;
                                        print('Sulphur  changed: $value');
                                      },maxLength: 6,isPhone: true
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Boron Level :',
                                      'Enter Boron Level',
                                      _boronLevelController,
                                          (value) {
                                        // Handle the changed text
                                        _boronLevel = value;
                                        print('_zincLevel changed: $value');
                                      },maxLength: 6,isPhone: true
                                  ),
                                  const SizedBox(height: 16),
                                  _buildDatePickerField(
                                    'Date of Birth:',
                                    'Enter DOB',
                                    _dobController,
                                    // Pass the date controller to the date field
                                        (value) {
                                      // setState(() {
                                      _selectedDate = value ?? '';
                                      print('Selected DOB: $value');
                                      // }
                                      // );
                                    },
                                  ),

                                ]))),
                    const SizedBox(height: 36),
                    _buildSectionTitle(context,'Create/Update Asset')

                  ])),
        ));
  }


  // Method to build the date picker field
  Widget _buildDatePickerField(
      String label,
      String hint,
      TextEditingController controller, // Use a controller for the text field
      ValueChanged<String?> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
          ),
          child: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                String formattedDate =
                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                setState(() {
                  _selectedDate = formattedDate;
                  controller.text =
                      formattedDate; // Update the controller with the selected date
                });
                onChanged(formattedDate);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: controller,
                // Attach the controller to the text field
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildDropdown(String label, String? selectedValue, dynamic items,
      ValueChanged<String?> onChanged) {
    // Ensure that selectedValue is either null or matches one of the items
    String? validatedSelectedValue =
    items.contains(selectedValue) ? selectedValue : null;

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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: validatedSelectedValue,
              isExpanded: true,
              onChanged: (dynamic? newValue) {
                onChanged(newValue);
              },
              items: items.map<DropdownMenuItem<dynamic>>((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label,
      String hint,
      TextEditingController controller,
      ValueChanged<String?> onChanged, {
        bool isPhone = false,
        int? maxLength, // Optional parameter for maximum length
      }) {
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
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            maxLength: maxLength, // Set max length if provided
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }


  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCropDetails()),
              );
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
              child: Text(title),
          ),
        ],
      ) ;  }
}



