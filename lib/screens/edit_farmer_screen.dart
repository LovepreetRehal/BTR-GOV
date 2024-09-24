import 'dart:convert';
import 'dart:io';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/model/Farmersingledetail.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';


class EditFarmerScreen extends StatefulWidget {
  bool edit = false;
  String? id;
  EditFarmerScreen({required this.edit, this.id});

  @override
  _EditFarmerState createState() => _EditFarmerState();
}

class _EditFarmerState extends State<EditFarmerScreen> {
  String? _selectedCountry = 'India';
  String? _selectedState = 'Assam';
  String? _selectedDistricts;
  String? _selectedBlocks;
  String? _selectedVcdcs;
  String? _selectedRevenueVillages;
  String? _VillageName = '';
  String? _addressLine = '';
  String? _pincode = '147021';

  var paramdic = {"": ""};
  bool loadlist = true;

  bool _isLoading = false;

  final List<String> _countryList = ['India'];
  final List<String> _states = ['Assam'];

  var _Alldata;
  List<Map<String, dynamic>> _district = [];
  List<Map<String, dynamic>> _block = [];
  List<Map<String, dynamic>> _vcdcs = [];
  List<Map<String, dynamic>> _revenueVillages = [];
  List<Map<String, dynamic>> _farmerCategories = [];


  Map<String, dynamic>? DashboardCategory;

  final TextEditingController _villageNameController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();


  bool hasGovtJob = false; // Checkbox state
  TextEditingController govJobHolderController = TextEditingController();

  bool _click = false;

  String getcode(List list, String select) {
    try {
      var id = list.firstWhere((district) => district["name"] == select,
        orElse: () => null, // Fallback if no match is found
      );

      if (id == null) {
        throw Exception('No matching district found.');
      }

      return id["code"].toString();
    } catch (e) {
      print('Error: $e');
      return 'Not Found'; // Return a default or fallback value if needed
    }
  }

  //this is for geting name

  getEditData(bool edit, String? id) {
    loadlist = true;
    ApiClient().getData(Utils.editDetail + "$id", true, "").then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        print(data["data"]);
        data = data["data"]["editFarmer"];
        _selectedDistricts = data['district'] ?? '';
        _selectedBlocks = data['block'] ?? '';
        _selectedVcdcs = data['vcdc'] ?? '';
        _selectedRevenueVillages = data['revenueVillage'] ?? '';

        // Update dependent dropdown lists based on selected values
        _block = _district.firstWhere((district) => district["name"] == _selectedDistricts)["blocks"];
        _vcdcs = _block.firstWhere((block) => block["name"] == _selectedBlocks)["vcdcs"];
        _revenueVillages = _vcdcs.firstWhere((vcdc) => vcdc["name"] == _selectedVcdcs)["revenueVillages"];

        loadlist = false;
      } else {
        loadlist = false;
      }
      setState(() {});
    });
  }


  // //this is for geting id
  // getEditData(bool edit, String? id) {
  //   if (!edit || id == null) return;
  //   loadlist = true;
  //
  //   ApiClient().getData(Utils.editDetail + "$id", true, "").then((onValue) {
  //     if (onValue.statusCode == 200) {
  //       var data = json.decode(onValue.body);
  //       data = data["data"]["editFarmer"];
  //
  //       // Assuming data contains the IDs
  //       int districtId = data['district'];
  //       int blockId = data['block'];
  //       int vcdcId = data['vcdc'];
  //       int revenueVillageId = data['revenueVillage'];
  //
  //       // Map the ID to the corresponding name in the dropdown lists
  //       setState(() {
  //         _selectedDistricts = _district.firstWhere((district) => district["id"] == districtId)["name"];
  //         _selectedBlocks = _block.firstWhere((block) => block["id"] == blockId)["name"];
  //         _selectedVcdcs = _vcdcs.firstWhere((vcdc) => vcdc["id"] == vcdcId)["name"];
  //         _selectedRevenueVillages = _revenueVillages.firstWhere((village) => village["id"] == revenueVillageId)["name"];
  //
  //         // Update dependent dropdown lists based on selected values
  //         _block = _district.firstWhere((district) => district["id"] == districtId)["blocks"];
  //         _vcdcs = _block.firstWhere((block) => block["id"] == blockId)["vcdcs"];
  //         _revenueVillages = _vcdcs.firstWhere((vcdc) => vcdc["id"] == vcdcId)["revenueVillages"];
  //       });
  //     }
  //     loadlist = false;
  //     setState(() {});  // Ensure the UI is updated after setting the data
  //   });
  // }



  void fetchCategoryWiseFarmerStats() async {
    final Map<String, String> queryParams = {'': ''};
    ApiClient()
        .getData(
      Utils.dashboard,
      true,
      queryParams,
    )
        .then((onValue) {
      if (onValue.statusCode == 200) {
        setState(() {
          final responseData = json.decode(onValue.body);

          _Alldata = responseData["data"];
          _farmerCategories = List<Map<String, dynamic>>.from(
              responseData["data"]["categoryWiseFarmerStats"]);
          ;
          _district = List<Map<String, dynamic>>.from(
              responseData["data"]["districts"]);
          setState(() {});
          // final farmerStatsResponse =
          //     FarmerStatsResponse.fromJson(responseData);
          // _categoryWiseFarmerStats =
          //     farmerStatsResponse.data.categoryWiseFarmerStats;
          // _landTypeWiseLandStats =
          //     farmerStatsResponse.data.landTypeWiseLandStats;
          // _district = farmerStatsResponse.data.districts;
          // _block = farmerStatsResponse.data.blocks;
          // _vcdc = farmerStatsResponse.data.vcdcs;
          // _villages = farmerStatsResponse.data.villages;
        });
      } else {
        // Handle the error case
        print('Error: ${onValue.body}');
      }
      if (widget.edit == true) {
        getEditData(widget.edit, widget.id); // Fetch farmer details when screen is opened
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print('Edit mode: ${widget.edit}');
    print('Farmer ID: ${widget.id}');
    fetchCategoryWiseFarmerStats();
  }

  void getEditdata() {
    if (widget.edit == false) {
      return;
    }
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
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  const SizedBox(height: 36),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/address_inf.svg', // Path to your SVG icon
                        height: 24, // Adjust height as needed
                        width: 24, // Adjust width as needed
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      const Text(
                        'Address Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      elevation: 4,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Country:', _selectedCountry, _countryList,
                                        (String? newValue) {
                                      setState(() {
                                        _selectedCountry = newValue;
                                      });
                                    }),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'State:', _selectedState, _states,
                                        (String? newValue) {
                                      setState(() {
                                        _selectedState = newValue;
                                      });
                                    }),
                                const SizedBox(height: 16),
                                _buildDropdown_second(
                                    'District:', _selectedDistricts, _district,
                                        (dynamic? newValue) {
                                      print(newValue);
                                      var list = _district.firstWhere((district) =>
                                      district["name"] == newValue)["blocks"];
                                      var list2 =
                                      List<Map<String, dynamic>>.from(list);
                                      _selectedBlocks = null;
                                      _block.clear();
                                      _block.addAll(list2);
                                      setState(() {
                                        _selectedDistricts = newValue;
                                      });
                                    }),
                                const SizedBox(height: 16),
                                _buildDropdown_second(
                                    'Block:', _selectedBlocks, _block,
                                        (dynamic? newValue) {
                                      print(newValue);
                                      var list = _Alldata["blocks"].firstWhere(
                                              (district) =>
                                          district["name"] ==
                                              newValue)["vcdcs"];
                                      _selectedVcdcs = null;
                                      _vcdcs.clear();
                                      _vcdcs.addAll(
                                          List<Map<String, dynamic>>.from(list));
                                      setState(() {
                                        _selectedBlocks = newValue;
                                      });
                                    }),
                                const SizedBox(height: 16),
                                _buildDropdown_second(
                                    'VCDC :', _selectedVcdcs, _vcdcs,
                                        (dynamic? newValue) {
                                      var list = _Alldata["vcdcs"].firstWhere(
                                              (district) =>
                                          district["name"] ==
                                              newValue)["revenueVillages"];
                                      _selectedRevenueVillages = null;
                                      _revenueVillages.clear();
                                      _revenueVillages.addAll(
                                          List<Map<String, dynamic>>.from(list));
                                      setState(() {
                                        _selectedVcdcs = newValue;
                                      });
                                    }),
                                const SizedBox(height: 16),
                                _buildDropdown_second(
                                    'Revenue Village:',
                                    _selectedRevenueVillages,
                                    _revenueVillages, (dynamic? newValue) {
                                  setState(() {
                                    _selectedRevenueVillages = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Village Name:',
                                  'Enter Village Name',
                                  _villageNameController,
                                      (value) {
                                    _VillageName = value;

                                    // Handle the changed text
                                    print('Email changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Address Line:',
                                  'Enter Address Line',
                                  _addressLineController,
                                      (value) {
                                    // Handle the changed text
                                    _addressLine = value;
                                    print('Email changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Pincode:',
                                  'Enter PinCode',
                                  _pincodeController,
                                      (value) {
                                    // Handle the changed text
                                    _pincode = value;
                                    print('Email changed: $value');
                                  },maxLength: 6,isPhone: true
                                ),
                              ]))),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context,"Submit")
                ],
              )),
        ));
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

  Widget _buildDropdown_second(String label, String? selectedValue,
      List<Map<String, dynamic>> items, ValueChanged<dynamic?> onChanged) {
    // Ensure that selectedValue is either null or matches one of the items
    // String? validatedSelectedValue =
    //     items.contains(selectedValue) ? selectedValue : null;

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
              hint: Text('Select value'),
              value: selectedValue ?? null,
              isExpanded: true,
              onChanged: (dynamic? newValue) {
                onChanged(newValue);
              },
              items: items.map((dynamic item) {
                return DropdownMenuItem<String>(
                  value: item["name"],
                  child: Text(item["name"]),
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
                        Navigator.of(context).pop(); // Close the dialog
                        if (_click) return; // Prevent multiple presses
                        if (widget.edit == true) {
                          print("click==_EditFarmer");
                          // _EditFarmer();
                        } else {
                          print("click==_CreateFarmer");
                          // _CreateFarmer();
                        }
                      },
                    ),
                  ],
                );
              },
            );
            print('Button Pressed');
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
