import 'dart:convert';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/model/SingleFarmerModel.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:btr_gov/screens/create_crop_details.dart';
import 'package:btr_gov/screens/create_soil_details.dart';
import 'package:flutter/material.dart';




class AssetsDeatilScreen extends StatefulWidget {
  final Singlefarmermodel? farmerData;

  AssetsDeatilScreen({Key? key, this.farmerData});

  @override
  _Singlefarmermodel createState() => _Singlefarmermodel();
}

class _Singlefarmermodel extends State<AssetsDeatilScreen> {

  final List<String> _countryList = ['India'];
  final List<String> _ownershipType = ['Leased','Owned','Shared Cropping'];
  final List<String> _LandType = ['Agriculture','Waste Land','PGR/VGR','Forest Land'];
  final List<String> _states = ['Assam'];
  List<Map<String, dynamic>> _district = [];
  List<Map<String, dynamic>> _block = [];
  List<Map<String, dynamic>> _vcdcs = [];
  List<Map<String, dynamic>> _revenueVillages = [];




  String? _selectedCountry = 'India'; // Set initial value to match the list
  String? _selectedOwnerType = '--selected--'; // Set initial value to match the list
  String? _selectedLandType = '--selected--'; // Set initial value to match the list
  String? _selectedState = 'Assam'; // Set initial value to match the list
  String? _selectedDistricts; // Set initial value to match the list
  String? _selectedBlocks; // Set initial value to match the list
  String? _selectedVcdcs; // Set initial value to m
  String? _selectedRevenueVillages;
  String? _dagNumber;
  String? _addressLine = '';
  String? _pincode = '147021';
  String? _plotArea = '';
  String? _villageName = '';
  final TextEditingController _villageNameController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _plotAreaController = TextEditingController();
  final TextEditingController _pattaNumberController = TextEditingController();
  final TextEditingController _dagNumberController = TextEditingController();

  var _Alldata;

  bool loadlist = true;

  Singlefarmermodel? farmerData ;
  var paramdic = {"": ""};


  void fetchCategoryWiseFarmerStats() async {
    final Map<String, String> queryParams = {'': ''};
    ApiClient().getData(Utils.dashboard, true, queryParams,).then((onValue) {
      if (onValue.statusCode == 200) {
        setState(() {
          final responseData = json.decode(onValue.body);

          _Alldata = responseData["data"];
          // _farmerCategories = List<Map<String, dynamic>>.from(
          //     responseData["data"]["categoryWiseFarmerStats"]);
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

    });
  }




  @override
  void initState() {
    super.initState();
     farmerData = widget.farmerData;

    fetchCategoryWiseFarmerStats();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('Farmer Detail')),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Create Land Details'),
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

                    const SizedBox(height: 36),

              Container(
                margin: EdgeInsets.only(bottom: 6),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade500),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Registration No', farmerData!.data.farmer.registrationId),
                    Divider(
                      height: 6.0,
                      color: Colors.grey.shade300,
                    ),
                    _buildDetailRow("Name", farmerData!.data.farmer.firstName),
                    _buildDetailRow("Mobile Number No", farmerData!.data.farmer.mobileNumber),
                    _buildDetailRow("Email", farmerData!.data.farmer.email),
                    _buildDetailRow("Status", farmerData!.data.farmer.status),
                    _buildDetailRow("Govt Farmer Id", farmerData!.data.farmer.govtFarmerId),
                    SizedBox(height: 6),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     _buildRow("District", data["district"]),
                    //     _buildRow("Block", data["block"]),
                    //   ],
                    // ),
                    // SizedBox(height: 6),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     _buildRow("VCDC", data["vcdc"]),
                    //     _buildRow("Village", data["vill_1"]),
                    //   ],
                    // ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        // Edit button

                        ElevatedButton(
                          onPressed: () {
                            // Action for Crops button
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CreateCropDetails()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black), // Black border
                          ),
                          child: Text(
                            'Crops',
                            style: TextStyle(color: Colors.black), // Black text
                          ),
                        ),
                        SizedBox(width: 16),

                        ElevatedButton(

                          onPressed: () {
                            // Action for View button
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black),
                            backgroundColor: Colors.white// Black border
                          ),
                          child: Text(
                            'View',
                            style: TextStyle(color: Colors.black), // Black text
                          ),
                        ),
                        SizedBox(width: 16),

                        ElevatedButton(
                          onPressed: () {
                            // Action for Soil button

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CreateSoilDetails()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black), // Black border
                          ),
                          child: Text(
                            'Soil',
                            style: TextStyle(color: Colors.black), // Black text
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 36),
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
                                  _buildTextField(
                                    'Plot Area (In Bigha) ✫:',
                                    'Enter Plot Area',
                                    _plotAreaController,
                                        (value) {
                                      // Handle the changed text
                                      _plotArea = value;
                                      print('FirstName changed: $value');
                                    },
                                  ),

                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Ownership Type :', _selectedOwnerType, _ownershipType,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedOwnerType = newValue;
                                        });
                                      }),
                                  _buildDropdown(
                                      'Type of Land :', _selectedLandType, _LandType,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedLandType = newValue;
                                        });
                                      }),


                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Patta Number (Max size: 20) :',
                                    'Enter Patta Number ',
                                    _pattaNumberController,
                                        (value) {
                                      // Handle the changed text
                                      _plotArea = value;
                                      print('FirstName changed: $value');
                                    },
                                    maxLength: 20
                                  ),

                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Dag Number (Max size: 20) :',
                                    'Enter Dag Number  ',
                                    _dagNumberController,
                                        (value) {
                                      // Handle the changed text
                                      _dagNumber = value;
                                      print('FirstName changed: $value');
                                    },
                                    maxLength: 20
                                  ),

                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Country ✫:', _selectedCountry, _countryList,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedCountry = newValue;
                                        });
                                      }),

                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'State ✫:', _selectedState, _states,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedState = newValue;
                                        });
                                      }),
                                  const SizedBox(height: 16),
                                  _buildDropdown_second(
                                      'District ✫:', _selectedDistricts, _district,
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
                                      'Block ✫:', _selectedBlocks, _block,
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
                                      'VCDC ✫:', _selectedVcdcs, _vcdcs,
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
                                      _villageName = value;

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
                                      'Pincode ✫:',
                                      'Enter PinCode',
                                      _pincodeController,
                                          (value) {
                                        // Handle the changed text
                                        _pincode = value;
                                        print('Email changed: $value');
                                      },maxLength: 6,isPhone: true
                                  ),
                                ]))),
                    const SizedBox(height: 36),
                    _buildSectionTitle("Save"),
                    const  SizedBox(height: 20),



              ])),
        ));
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateSoilDetails()),
                );

                print('Button Pressed');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.indigo[400],
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
          ),
        ],
      ),
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

  Widget _buildTextField1(
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

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label + ":",
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }



}
