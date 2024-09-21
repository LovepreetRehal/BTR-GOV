


//CreateSoilDetails


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/ApiClient.dart';
import '../retrofit/utils.dart';
import 'create_crop_details.dart';

class CreateSoilDetails extends StatefulWidget {

  String? id;
  CreateSoilDetails([String? this.id]);

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


  bool _click = false;


  Future<void> _CreateSoil() async {
  //
  //   if (_firstNameController.text.trim().isEmpty) {
  //     print('Please enter First Name');
  //     Utils.toast('Please enter First Name');
  //     return;
  //   }
  //
  //   // if (_middleNameController.text.trim().isEmpty) {
  //   //   print('Please enter Middle Name');
  //   //   Utils.toast('Please enter Middle Name');
  //   //   return;
  //   // }
  //
  //   if (_lastNameController.text.trim().isEmpty) {
  //     print('Please enter Last Name');
  //     Utils.toast('Please enter Last Name');
  //     return;
  //   }
  //
  //   // if (_emailController.text.trim().isEmpty || !_isValidEmail(_emailController.text)) {
  //   //   print('Please enter a valid Email Address');
  //   //   Utils.toast('Please enter a valid Email Address');
  //   //   return;
  //   // }
  //
  //   if (_mobilenumberController.text.trim().isEmpty || !_isValidPhoneNumber(_mobilenumberController.text)) {
  //     print('Please enter a valid Mobile Number');
  //     Utils.toast('Please enter a valid Mobile Number');
  //     return;
  //   }
  //
  //   if (_aadharCardController.text.trim().isEmpty || !_isValidAadharNumber(_aadharCardController.text)) {
  //     print('Please enter a valid Aadhaar Number');
  //     Utils.toast('Please enter a valid Aadhaar Number');
  //     return;
  //   }
  //
  //   if (_dobController.text.trim().isEmpty) {
  //     print('Please enter Date of Birth');
  //     Utils.toast('Please enter Date of Birth');
  //     return;
  //   }
  //
  //   if (_addressLineController.text.trim().isEmpty) {
  //     print('Please enter Address Line 1');
  //     Utils.toast('Please enter Address Line 1');
  //     return;
  //   }
  //
  //   if (_pincodeController.text.trim().isEmpty || !RegExp(r'^\d{6}$').hasMatch(_pincodeController.text)) {
  //     print('Please enter a valid Pincode');
  //     Utils.toast('Please enter a valid Pincode');
  //     return;
  //   }
  //
  //   // if (_FamilyNameController.text.trim().isEmpty) {
  //   //   print('Please enter Family Name');
  //   //   Utils.toast('Please enter Family Name');
  //   //   return;
  //   // }
  //
  //   // if (_hornetController.text.trim().isEmpty) {
  //   //   print('Please enter Hornet Number');
  //   //   Utils.toast('Please enter Hornet Number');
  //   //   return;
  //   // }
  //   //
  //   // if (_villageNameController.text.trim().isEmpty) {
  //   //   print('Please enter Village Name');
  //   //   Utils.toast('Please enter Village Name');
  //   //   return;
  //   // }
  //   //
  //   // if (_panCardController.text.trim().isEmpty) {
  //   //   print('Please enter PAN Card Number');
  //   //   Utils.toast('Please enter PAN Card Number');
  //   //   return;
  //   // }
  //
  //   // if (_rationCardController.text.trim().isEmpty) {
  //   //   print('Please enter Ration Card Number');
  //   //   Utils.toast('Please enter Ration Card Number');
  //   //   return;
  //   // }
  //
  //   if (_voterCardController.text.trim().isEmpty) {
  //     print('Please enter Voter Card Number');
  //     Utils.toast('Please enter Voter Card Number');
  //     return;
  //   }
  //
  //   if (_maleMemberController.text.trim().isEmpty || !RegExp(r'^\d+$').hasMatch(_maleMemberController.text)) {
  //     print('Please enter a valid number of Male Members');
  //     Utils.toast('Please enter a valid number of Male Members');
  //     return;
  //   }
  //
  //   if (_feMaleMemberController.text.trim().isEmpty || !RegExp(r'^\d+$').hasMatch(_feMaleMemberController.text)) {
  //     print('Please enter a valid number of Female Members');
  //     Utils.toast('Please enter a valid number of Female Members');
  //     return;
  //   }
  //   //
  //   // if (_pmkishanController.text.trim().isEmpty) {
  //   //   print('Please enter PM Kishan Number');
  //   //   Utils.toast('Please enter PM Kishan Number');
  //   //   return;
  //   // }
  //
  //   if (_childrenNoController.text.trim().isEmpty || !RegExp(r'^\d+$').hasMatch(_childrenNoController.text)) {
  //     print('Please enter a valid number of Children');
  //     Utils.toast('Please enter a valid number of Children');
  //     return;
  //   }
  //
  //   if (_accountNoController.text.trim().isEmpty) {
  //     print('Please enter Account Number');
  //     Utils.toast('Please enter Account Number');
  //     return;
  //   }
  //
  //   if (_accountHolderNameController.text.trim().isEmpty) {
  //     print('Please enter Account Holder Name');
  //     Utils.toast('Please enter Account Holder Name');
  //     return;
  //   }
  //
  //   if (_ifscCodeController.text.trim().isEmpty) {
  //     print('Please enter IFSC Code');
  //     Utils.toast('Please enter IFSC Code');
  //     return;
  //   }
  //
  //   if (_bankNameController.text.trim().isEmpty) {
  //     print('Please enter Bank Name');
  //     Utils.toast('Please enter Bank Name');
  //     return;
  //   }
  //
  //   if (_passbookImage == null ||
  //       _aadharImage == null ||
  //       _voterIdImage == null ||
  //       _photoImage == null) {
  //     print('Please select both files');
  //     Utils.toast('Please select both files');
  //     return;
  //   }
  //
    setState(() {
      _click = true;
    });
    try {
      var param = {

        "soil_type": _soilType.first,
        "nitrogen_level": "sdfafs",
        "land_area": "",
        "potassium_level": _potassiumLevel.toString(),
        "phosphorus_level": _phosphorusLevel.toString(),
        "micronutrient_level": "",
        "date_of_test": "2024-09-20",
        "date_of_collection": "2024-09-17",
        "pH_level": "vsskmvsk",
        "sulphur_level": "dsmdsm",
        "boron_level": "dskkdsm",
        "zinc_level": "ldmdsm",
        "organic_carbon_level": "sdkvmdkms",
        "electric_conductivity_level": '',

      };


      print('rehal->>>>   $param');
      ApiClient().addAssetsSoil(Utils.addAssetsSoil+"/0cbb4fd7-a1de-4ff3-8bc1-5ecd54399d3a/f6414f59-ea3c-42e4-b0ae-a72bcf713c10", param, []).then((onValue) {
        if (onValue.statusCode == 200) {
          var data = json.decode(onValue.body);
          Utils.toast(data["message"].toString());

          print("Done ${onValue.body}");
        } else {
          var data = json.decode(onValue.body);
          Utils.toast(data["errors"].toString());
          print("Done ${onValue.body}");
        }
        setState(() {
          _click = false;
        });
      });
    } catch (e) {
      setState(() {
        _click = false;
      });
      Utils.toast(e.toString());
    }
  }

  apiCall(id) {
    ApiClient().deleteAssetsData(Utils.deleteAssetsDetail + id, true).then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success: ${data["message"] ?? "Data deleted successfully"}'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          // getdata();
          Navigator.pop(context);

        });
        print(data["data"]);
        _click = false;
      } else {
        var data = json.decode(onValue.body);

        _click = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success: ${data["message"] ?? "Data deleted successfully"}'),
            backgroundColor: Colors.green,
          ),
        );
      }
      setState(() {});
    });
  }


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
              // _CreateSoil();
              _printFieldData();
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCropDetails()),);
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


  void _printFieldData() {
    print('Soil Type: $_selectedSoilType');
    print('Nitrogen Level: $_nitrogenLevelName');
    print('Potassium Level: $_potassiumLevel');
    print('Phosphorus Level: $_phosphorusLevel');
    print('pH Level: $_phLevel');
    print('Carbon Level: $_carbonLevel');
    print('Zinc Level: $_zincLevel');
    print('Sulphur Level: $_sulphurLevel');
    print('Boron Level: $_boronLevel');
    print('Date of Birth: $_selectedDate');
}


  }
