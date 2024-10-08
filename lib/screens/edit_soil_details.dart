//CreateSoilDetails

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/ApiClient.dart';
import '../retrofit/utils.dart';
import 'create_crop_details.dart';

class EditSoilDetails extends StatefulWidget {
  String? farmerID;
  String? landID;
  String? soilUuid;

  EditSoilDetails(String? this.farmerID, this.landID, String this.soilUuid);

  @override
  _EditSoilDetailsScreen createState() => _EditSoilDetailsScreen();
}

class _EditSoilDetailsScreen extends State<EditSoilDetails> {
  final List<String> _soilType = ['Wet', 'Sand', 'Red Soil', 'Alluvial', 'Piedmont', 'Hill', 'Lateritic'];
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
  String? _dateofCollection = ''; // State variable for storing the selected date
  var paramdic = {"": ""};
  List<dynamic> lands = [];

  final TextEditingController _nitrogenLevelController = TextEditingController();
  final TextEditingController _potassiumLevelController = TextEditingController();
  final TextEditingController _phosphorusLevelController = TextEditingController();
  final TextEditingController _phLevelController = TextEditingController();
  final TextEditingController _carbonController = TextEditingController();
  final TextEditingController _zincLevelController = TextEditingController();
  final TextEditingController _sulphurLevelController = TextEditingController();
  final TextEditingController _boronLevelController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _dateofCollectionController = TextEditingController();

  bool _click = false;

  Future<void> _CreateSoil() async {



    //   if (_accountHolderNameController.text.trim().isEmpty) {
    //     print('Please enter Account Holder Name');
    //     Utils.toast('Please enter Account Holder Name');
    //     return;
    //   }

    setState(() {
      _click = true;
    });
    try {
      var param = {
        // "soil_type": _soilType.first,
        "soil_type": "SC001",
        "nitrogen_level": _nitrogenLevelName.toString(),
        "land_area": "",
        "potassium_level": _potassiumLevel.toString(),
        "phosphorus_level": _phosphorusLevel.toString(),
        "micronutrient_level": "",
        "date_of_test": _selectedDate.toString(),
        "date_of_collection": _dateofCollection.toString(),
        "pH_level": _phosphorusLevel.toString(),
        "sulphur_level": _sulphurLevel.toString(),
        "boron_level": _boronLevel.toString(),
        "zinc_level": _zincLevel.toString(),
        "organic_carbon_level": _carbonLevel.toString(),
        "electric_conductivity_level": '',
      };

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
      print('rehal->>>>   $param');
      ApiClient().addAssetsSoil(
          Utils.assetsSoilEdit +widget.farmerID.toString()+"/"+widget.landID.toString()+"/"+widget.soilUuid.toString(),
          param,
          []).then((onValue) {
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


  getSoilData() {
    ApiClient().getAssetsLandEdit(Utils.assetsSoilGet + widget.farmerID.toString()+"/"+widget.landID.toString()+"/"+widget.soilUuid.toString(), true, "").then((onValue) {
      var data = json.decode(onValue.body);
      if (onValue.statusCode == 200) {
        var soil = data["data"]["editSoil"]; // Accessing the 'lands' object

        if (soil != null) {
          setState(() {
            // Assign values from the land object


            _nitrogenLevelName = soil['nitrogen_level'].toString();
            _potassiumLevel = soil['potassium_level'].toString();
            _phosphorusLevel = soil['phosphorus_level'].toString();
            _phLevel = soil['pH_level'].toString();
            _carbonLevel = soil['organic_carbon_level'].toString();
            _zincLevel = soil['zinc_level'].toString();
            _sulphurLevel = soil['sulphur_level'].toString();
            _boronLevel = soil['boron_level'].toString();
            _selectedDate = soil['date_of_test'].toString();
            _dateofCollection = soil['date_of_collection'].toString();


            _nitrogenLevelController.text = soil['nitrogen_level'].toString();
            _potassiumLevelController.text = soil['potassium_level'].toString();
            _phosphorusLevelController.text = soil['phosphorus_level'].toString();
            _phLevelController.text = soil['pH_level'].toString();
            _carbonController.text = soil['organic_carbon_level'].toString();
            _zincLevelController.text = soil['zinc_level'].toString();
            _sulphurLevelController.text = soil['sulphur_level'].toString();
            _boronLevelController.text = soil['boron_level'].toString();
            _selectedDate = soil['date_of_test'].toString();
            _dateofCollectionController.text = soil['date_of_collection'].toString();





            // "soil_type": "SC001",
            // "nitrogen_level": _nitrogenLevelName.toString(),
            // "land_area": "",
            // "potassium_level": _potassiumLevel.toString(),
            // "phosphorus_level": _phosphorusLevel.toString(),
            // "micronutrient_level": "",
            // "date_of_test": _selectedDate.toString(),
            // "date_of_collection": _dateofCollection.toString(),
            // "pH_level": _phosphorusLevel.toString(),
            // "sulphur_level": _sulphurLevel.toString(),
            // "boron_level": _boronLevel.toString(),
            // "zinc_level": _zincLevel.toString(),
            // "organic_carbon_level": _carbonLevel.toString(),
            // "electric_conductivity_level": '',

            _click = false;

          });
        } else {
          // Handle case when 'land' is null
          _click = false;
          Utils.toast("No land data available.");
        }
      } else {
        // Handle other status codes
        _click = false;
        Utils.toast("Error: ${data["errors"].toString()}");
      }


      setState(() {});
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSoilData();
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
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'SOIL DETAIL',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ]))),
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
                                      'Soil Type ✫:',
                                      _selectedSoilType,
                                      _soilType, (String? newValue) {
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
                                      _phosphorusLevelController, (value) {
                                    // Handle the changed text
                                    _phosphorusLevel = value;
                                    print('phosphorusLevel changed: $value');
                                  }),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'pH Level :',
                                      'Enter pH Level',
                                      _phLevelController, (value) {
                                    // Handle the changed text
                                    _phLevel = value;
                                    print('phosphorusLevel changed: $value');
                                  }),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Carbon Level :',
                                      'Enter organic carbon level',
                                      _carbonController, (value) {
                                    // Handle the changed text
                                    _carbonLevel = value;
                                    print('_carbonController changed: $value');
                                  }, maxLength: 6, isPhone: true),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Zinc Level :',
                                      'Enter Zinc Level',
                                      _zincLevelController, (value) {
                                    // Handle the changed text
                                    _zincLevel = value;
                                    print('_zincLevel changed: $value');
                                  }, maxLength: 6, isPhone: true),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Sulphur Level :',
                                      'Enter Sulphur Level',
                                      _sulphurLevelController, (value) {
                                    // Handle the changed text
                                    _sulphurLevel = value;
                                    print('Sulphur  changed: $value');
                                  }, maxLength: 6, isPhone: true),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Boron Level :',
                                      'Enter Boron Level',
                                      _boronLevelController, (value) {
                                    // Handle the changed text
                                    _boronLevel = value;
                                    print('_zincLevel changed: $value');
                                  }, maxLength: 6, isPhone: true),
                                  const SizedBox(height: 16),
                                  _buildDatePickerField(
                                    'Date of Text:',
                                    'dd-mm-yyyy',
                                    _dobController,
                                    // Pass the date controller to the date field
                                    (value) {
                                      // setState(() {
                                      _selectedDate = value ?? '';
                                      print('Selected DOB: $value');
                                      // }
                                      // );
                                    },
                                  ),  const SizedBox(height: 16),
                                  _buildDatePickerField1(
                                    'Date of Collect:',
                                    'dd-mm-yyyy',
                                    _dateofCollectionController,
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
                    _buildSectionTitle(context, 'Update Asset')
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
  // Method to build the date picker field
  Widget _buildDatePickerField1(
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
                  _dateofCollection = formattedDate;
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
            maxLength: maxLength,
            // Set max length if provided
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure you want to submit?'),
                  // content: Text(''),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        _CreateSoil();
                        _printFieldData();
                        Navigator.of(context).pop(); // Close the dialog

                        // Close the dialog
                      },
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.indigo[400],
            // Text color
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
    );
  }


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }


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
