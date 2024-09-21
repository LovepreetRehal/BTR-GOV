


//CreateCropDetails


import 'dart:convert';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:btr_gov/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateCropDetails extends StatefulWidget {

  String? uuid;
  CreateCropDetails(String? this.uuid);

  @override
  _CreateCropDetailsScreen createState() => _CreateCropDetailsScreen();
}

class _CreateCropDetailsScreen extends State<CreateCropDetails> {

  final List<String>  _cropType = ['Pulses','Oil seeds', 'Vegetable','Fruits','Spices', 'Plantation' ,'Medicinal Plants','Cereals'];
  final List<String>  _cropName = ['Lentil'];
  final List<String>  _seasonName = ['Summer','Winter','Autumn'];
  final List<String> _seasonalPerineal = ['Perennail (Plantation)','Biennial(Once in 2 years)','Annual (Once in a year)'];
  final List<String> _harvestingYear = [
    ...{'2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2023', '2024'}
  ].toList();  final List<String> _harvestingMonth = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  String? _selectedCropType = ''; // Set initial value to match the list
  String? _selectedSeasonName ; // Set initial value to match the list
  String? _selectedCropName ; // Set initial value to match the list
  String? _selectedSeasonalPerineal = ''; // Set initial value to match the list
  String? _cultivatedCropQuantity = ''; // Set initial value to match the list
  String? _selectedHarvestingYear = ''; // Set initial value to match the list
  String? _selectedHarvestingMonth = ''; // Set initial value to match the list
  String? _cultivationYear = ''; // Set initial value to match the list
  String? _cultivationMonth = ''; // Set initial value to match the list
  String? _productionCost = ''; // Set initial value to match the list

  String? _varietyName = '';
  String? _landAreaUsesLevel = '';
  String? _numberplantation = '';
  String? _schemeName = '';
  String? _assistantAmount = '';
  String? _returnAmount = '';
  String? _harvestedQuantity = '';
  String? _sulphurLevel = '';
  String? _boronLevel = '';
  String? _selectedDate = ''; // State variable for storing the selected date

  final TextEditingController _varietyNameController = TextEditingController();
  final TextEditingController _landAreaUsesController = TextEditingController();
  final TextEditingController _numberplantationController = TextEditingController();
  final TextEditingController _schemeNameController = TextEditingController();
  final TextEditingController _assistantAmountController = TextEditingController();
  final TextEditingController _returnAmountController = TextEditingController();
  final TextEditingController _harvestedQuantityController = TextEditingController();
  final TextEditingController _productionCostController = TextEditingController();
  final TextEditingController _cultivatedCropQuantityController = TextEditingController();

  bool _click = false;

  Future<void> _CreateCrop() async {
    setState(() {
      _click = true;
    });
    try {


    print('Crop Type: $_selectedCropType');
    print('Crop Name: $_selectedCropName');
    print('Variety Name: $_varietyName');
    print('Land Area Used: $_landAreaUsesLevel');
    print('Season Name: $_selectedSeasonName');
    print('Seasonal Perennial: $_selectedSeasonalPerineal');
    print('Crop Quantity Controller: $_cultivatedCropQuantity');
    print('No Plantiotion: $_numberplantation');
    print('Cultivation Year: $_cultivationYear');
    print('Cultivation Month: $_cultivationMonth');
    print('Production Cost: $_productionCost');
    print('Harvesting Year: $_selectedHarvestingYear');
    print('Harvesting Month: $_selectedHarvestingMonth');
    print('Harvested Quantity: $_harvestedQuantity');
    print('Return of Investment: $_returnAmount');
    print('Scheme Name: $_schemeName');
    print('Assistant Amount: $_assistantAmount');



      var param = {
          "scheme_received": "whyvfadf",
          "assistant_amount": "6655",
          "crop_type": "CT001",
          "quantity": "12",
          "crop_code": "CNP1",
          "season": "S001",
          "cultivation_year": "2011",
          "land_area_usage": _landAreaUsesLevel.toString(),
          "harvesting_year": _selectedHarvestingYear.toString(),
          "crop_name": _selectedCropName.toString(),
          "seasonal_perennial": _selectedSeasonalPerineal.toString(),
          "number_of_plantation": _numberplantation.toString(),
          "cultivation_month": "September",
          "harvesting_month": _selectedHarvestingMonth.toString(),
          "harvest_quantity": _harvestedQuantity.toString(),
          "variety_name": "cbcbvhdsbf",
          "production_cost": _schemeName.toString(),
          "return_amount": _assistantAmount.toString()

      };
      print('rehal->>>>   $param');
      ApiClient().addAssetsCrop(Utils.addAssetsCrop+"/0cbb4fd7-a1de-4ff3-8bc1-5ecd54399d3a/f6414f59-ea3c-42e4-b0ae-a72bcf713c10", param, []).then((onValue) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Farmer Detail')),
      //   backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text('Create Crop Details'),
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
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CROP DETAIL',
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
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Crop Type ✫:','--select--', _selectedCropType, _cropType,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedCropType = newValue;
                                        });
                                      }),

                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Crop name✫:','--select--', _selectedCropName, _cropName,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedCropName = newValue;
                                        });
                                      }),


                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Variety Name :',
                                    'Enter Variety Name',
                                    _varietyNameController,
                                        (value) {
                                          _varietyName = value;

                                      // Handle the changed text
                                      print('varietyNameController changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Land Area Uses (In Bigha) :',
                                    'Enter land area usages',
                                    _landAreaUsesController,
                                        (value) {
                                      // Handle the changed text
                                      _landAreaUsesLevel = value;
                                      print('Land area changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Season Name :','--select--', _selectedSeasonName, _seasonName,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedSeasonName = newValue;
                                        });
                                      }),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Seasonal Peritoneal :`','--select--', _selectedSeasonalPerineal ,_seasonalPerineal ,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedSeasonalPerineal = newValue;
                                        });
                                      }),

                                ]))),

                    const SizedBox(height: 36),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CULTIVATION DETAIL',
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
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Cultivated Crop Quantity (In KG) (Optional) :',
                                    'Enter Variety Name :',
                                    _cultivatedCropQuantityController,
                                        (value) {
                                          _cultivatedCropQuantity = value;

                                      // Handle the changed text
                                      print('varietyNameController changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Number of plantation (Optional)  :',
                                    'Enter Number of plantation ',
                                    _numberplantationController,
                                        (value) {
                                      // Handle the changed text
                                          _numberplantation = value;
                                      print('Land area changed: $value');
                                    },isPhone: true
                                  ),
                                  const SizedBox(height: 16),
                                  // _buildDropdown(
                                  //     'Cultivation Year :','--select--', _selectedHarvestingYear, _cultivationYear,
                                  //         (String? newValue) {
                                  //       setState(() {
                                  //         _selectedHarvestingYear = newValue;
                                  //       });
                                  //     }),
                                  // const SizedBox(height: 16),
                                  // _buildDropdown(
                                  //     'Cultivation Month :','--select--', _selectedHarvestingMonth, _cultivationMonth,
                                  //         (String? newValue) {
                                  //       setState(() {
                                  //         _selectedHarvestingMonth = newValue;
                                  //       });
                                  //     }),
                                  const SizedBox(height: 16),

                                  _buildTextField(
                                      'Production Cost in Rs :  :',
                                      'EnterProduction Cost ',
                                      _productionCostController,
                                          (value) {
                                        // Handle the changed text
                                            _productionCost = value;
                                        print('_productionCost changed: $value');
                                      },isPhone: true
                                  ),
                                ]))),

                    const SizedBox(height: 36),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'HARVESTING DETAIL',
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
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Harvesting Year :','--select--', _selectedHarvestingYear, _harvestingYear,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedHarvestingYear = newValue;
                                        });
                                      }),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Harvesting Month :','--select--', _selectedHarvestingMonth, _harvestingMonth,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedHarvestingMonth = newValue;
                                        });
                                      }),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Harvested Quantity (In KG/Total Items) (Optional) :',
                                    'Enter Quantity ',
                                    _harvestedQuantityController,
                                        (value) {
                                      _harvestedQuantity = value;

                                      // Handle the changed text
                                      print('varietyNameController changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Return of Investment in Rs. :',
                                      'Enter Return Amount',
                                      _returnAmountController,
                                          (value) {
                                        // Handle the changed text
                                        _returnAmount = value;
                                        print('Land area changed: $value');
                                      },isPhone: true
                                  ),

                                ]))),
                    const SizedBox(height: 36),
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'OTHER DETAIL',
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
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Scheme Received From Govt (if any) :',
                                    'Enter Scheme Name ',
                                    _schemeNameController,
                                        (value) {
                                      _schemeName = value;

                                      // Handle the changed text
                                      print('varietyNameController changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Assistant Amount (Financial Assistant) :',
                                      'Enter Assistant Amount',
                                      _assistantAmountController,
                                          (value) {
                                        // Handle the changed text
                                        _assistantAmount = value;
                                        print('assistantAmount changed: $value');
                                      },isPhone: true
                                  ),

                                ]))),

                    _buildSectionTitle(context,'Create/Update Assets')

                  ])),
        ));
  }

  Widget _buildDropdown(String label,String hint, String? selectedValue, dynamic items,
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
              hint: Row(
                children: [
                  // Your icon for the hint
                  Text(hint), // Your hint text
                ],
              ),
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
            _CreateCrop();

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
    ) ;

  }
}



