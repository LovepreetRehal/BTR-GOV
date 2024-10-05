


//CreateCropDetails


import 'dart:convert';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:btr_gov/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditCreateCropDetails extends StatefulWidget {

  String? landUuid;
  String? farmerUuid;
  EditCreateCropDetails(String? this.farmerUuid, this.landUuid);

  @override
  _EditCreateCropDetailsScreen createState() => _EditCreateCropDetailsScreen();
}

class _EditCreateCropDetailsScreen extends State<EditCreateCropDetails> {




  bool _click = false;
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
  String? _pattaNumber = '';
  String? _villageName = '';
  final TextEditingController _villageNameController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _plotAreaController = TextEditingController();
  final TextEditingController _pattaNumberController = TextEditingController();
  final TextEditingController _dagNumberController = TextEditingController();

  // Crop Data Variables
  String? _cropCode;
  String? _cropType;
  String? _season;
  int? _cropTypeId;
  int? _quantity;
  int? _numberOfPlantation;
  int? _seasonalPerennial;
  int? _cultivationYear;
  int? _harvestingYear;
  String? _cultivationMonth;
  String? _harvestingMonth;
  String? _landAreaUsage;
  String? _harvestQuantity;
  String? _varietyName;
  double? _productionCost;
  double? _returnAmount;
  String? _schemeReceived;
  String? _assistantAmount;

// Controllers for TextFields
  final TextEditingController _cropTypeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _numberOfPlantationController = TextEditingController();
  final TextEditingController _cultivationYearController = TextEditingController();
  final TextEditingController _harvestingYearController = TextEditingController();
  final TextEditingController _landAreaUsageController = TextEditingController();
  final TextEditingController _harvestQuantityController = TextEditingController();
  final TextEditingController _varietyNameController = TextEditingController();
  final TextEditingController _productionCostController = TextEditingController();
  final TextEditingController _returnAmountController = TextEditingController();
  final TextEditingController _schemeReceivedController = TextEditingController();
  final TextEditingController _assistantAmountController = TextEditingController();

  var _Alldata;


  getLandEditData() {
    ApiClient().getAssetsLandEdit(Utils.assetsLandEdit + widget.farmerUuid.toString()+"/"+widget.landUuid.toString(), true, "").then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        var land = data["data"]["lands"]; // Accessing the 'lands' object

        if (land != null) {
          setState(() {
            // Assign values from the land object
            _plotAreaController.text = land["plot_area_bigha"].toString();
            _selectedOwnerType = land["ownership_id"].toString(); // Assuming you want to set this
            _pattaNumberController.text = land["patta_number"].toString();
            _pattaNumber = land["patta_number"].toString();
            _dagNumberController.text = land["dag_number"].toString();
            _dagNumber = land["dag_number"].toString();

            // Access the address object and its fields
            if (land["address"] != null) {
              _villageNameController.text = land["address"]["line_1"].toString();
              _villageName = land["address"]["line_1"].toString();
              _addressLineController.text = land["address"]["line_1"].toString();
              _addressLine = land["address"]["line_1"].toString();
              _pincodeController.text = land["address"]["pincode"].toString();
              _pincode = land["address"]["pincode"].toString();
            }
            _click = false;

            // Set the plot area if available
            _plotArea = land["plot_area_bigha"].toString();
          });
        } else {
          // Handle case when 'land' is null
          _click = false;
          Utils.toast("No land data available.");
        }
      } else {
        // Handle other status codes
        _click = false;
        Utils.toast("Error: ${onValue.statusCode}");
      }


      setState(() {});
    });
  }


  getCropData() {
    ApiClient().getAssetsLandEdit(Utils.assetsCropGet + widget.farmerUuid.toString()+"/"+widget.landUuid.toString(), true, "").then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        var crop = data["data"]["editSoil"]; // Accessing the 'lands' object

        if (crop != null) {
          setState(() {
            // Assign values from the land object
            _cropCode = crop['crop_code'] ?? '';
            _cropTypeId = crop['crop_type_id'];
            _cropType = crop['crop_type'] ?? '';
            _quantity = crop['quantity'] ?? 0;
            _numberOfPlantation = crop['number_of_plantation'] ?? 0;
            _season = crop['season'] ?? '';
            _seasonalPerennial = crop['seasonal_perennial'];
            _cultivationYear = crop['cultivation_year'] ?? 0;
            _harvestingYear = crop['harvesting_year'] ?? 0;
            _cultivationMonth = crop['cultivation_month'] ?? '';
            _harvestingMonth = crop['harvesting_month'] ?? '';
            _landAreaUsage = crop['land_area_usage'] ?? '';
            _harvestQuantity = crop['harvest_quantity'] ?? '';
            _varietyName = crop['variety_name'] ?? '';
            _productionCost = crop['production_cost'].toDouble();
            _returnAmount = crop['return_amount'].toDouble();
            _schemeReceived = crop['scheme_received'] ?? '';
            _assistantAmount = crop['assistant_amount'] ?? '';

            // Populate the text controllers with the fetched data
            _cropTypeController.text = _cropType ?? '';
            _quantityController.text = _quantity?.toString() ?? '';
            _numberOfPlantationController.text = _numberOfPlantation?.toString() ?? '';
            _cultivationYearController.text = _cultivationYear?.toString() ?? '';
            _harvestingYearController.text = _harvestingYear?.toString() ?? '';
            _landAreaUsageController.text = _landAreaUsage ?? '';
            _harvestQuantityController.text = _harvestQuantity ?? '';
            _varietyNameController.text = _varietyName ?? '';
            _productionCostController.text = _productionCost?.toString() ?? '';
            _returnAmountController.text = _returnAmount?.toString() ?? '';
            _schemeReceivedController.text = _schemeReceived ?? '';
            _assistantAmountController.text = _assistantAmount ?? '';



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
        Utils.toast("Error: ${onValue.statusCode}");
      }


      setState(() {});
    });
  }


  Future<void> _EditLandDetail() async {

    if (_plotAreaController.text.trim().isEmpty) {
      print('Please enter Plot Area');
      Utils.toast('Please enter Plot Area');
      return;
    }

    setState(() {
      _click = true;
    });
    try {
      var param = {
        "addressStatus": "",
        "plot_area": _plotAreaController.text.toString(),
        "ownership_type": "OWT002",
        "type_of_land": "LT001",
        "country_code": "IN",
        "state_code": '18',
        "district_code": getcode(_Alldata['districts'], _selectedDistricts.toString()),
        "block_code": getcode(_Alldata['blocks'], _selectedBlocks.toString()),
        "vcdc_code": getcode(_Alldata['vcdcs'], _selectedVcdcs.toString()),
        "revenue_village_code": getcode(_Alldata['villages'], _selectedRevenueVillages.toString()),
        "address_line_1": _villageNameController.text.toString(),
        "address_line_2": _addressLineController.text.toString(),
        "pincode": _pincodeController.text.toString(),
        "patta_number": _pattaNumberController.text.toString(),
        "dag_number": _dagNumberController.text.toString(),
      };
      print('assetedit rehal->>>>   $param');
      ApiClient().addAssetsCreate(Utils.assetsUpdate+widget.landUuid.toString(), param, []).then((onValue) {
        if (onValue.statusCode == 200) {
          var data = json.decode(onValue.body);
          Utils.toast(data["message"].toString());
          Navigator.pop(context);

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


  String getcode(List list, String select) {
    var id = list.firstWhere((district) => district["name"] == select)["code"];
    return id.toString();
  }


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
          _district = List<Map<String, dynamic>>.from(responseData["data"]["districts"]);
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
    fetchCategoryWiseFarmerStats();
    getLandEditData();
    getCropData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Farmer Detail')),
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text('Edit Details'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        _pattaNumber = value;
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
                    _buildSectionTitle(context,'Create/Update Assets')

                  ])),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            _EditLandDetail();
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: Text('Are you sure you want to submit?'),
            //       // content: Text(''),
            //       actions: [
            //         TextButton(
            //           child: Text('Cancel'),
            //           onPressed: () {
            //             Navigator.of(context).pop(); // Close the dialog
            //           },
            //         ),
            //         TextButton(
            //           child: Text('OK'),
            //           onPressed: () {
            //             _EditLandDetail();
            //             Navigator.of(context).pop(); // Close the dialog
            //
            //             // Close the dialog
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
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
    ) ;

  }
}



