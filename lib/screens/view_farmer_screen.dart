import 'dart:convert';
import 'dart:io';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/model/Farmersingledetail.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ViewFarmerScreen extends StatefulWidget {
  bool edit = false;
  String? id;
  ViewFarmerScreen({required this.edit, this.id});

  @override
  _AddFarmerState createState() => _AddFarmerState();
}

class _AddFarmerState extends State<ViewFarmerScreen> {
  String? _selectedSalutation = 'Mr';
  String? _selectedCountry = 'India'; // Set initial value to match the list
  String? _selectedFarmerCategories; // Set initial value to match the list
  String? _selectedEducation = 'EDU_A'; // Set initial value to match the list
  String? _selectedBplStatuses = 'Yes'; // Set initial value to match the list
  String? _selectedPmKishans = 'Yes'; // Set initial value to match the list
  String? _selectedOccupations =
      'OCCUPATION_A'; // Set initial value to match the list
  String? _selectedReligions = 'Hindu'; // Set initial value to match the list
  String? _selectedSocialCategories =
      'ST'; // Set initial value to match the list
  String? _selectedState = 'Assam'; // Set initial value to match the list
  String? _selectedDistricts; // Set initial value to match the list
  String? _selectedBlocks; // Set initial value to match the list
  String? _selectedIncome = 'Below 2000'; // Set initial value to match the list
  String? _selectedVcdcs; // Set initial value to m
  String? _selectedRevenueVillages;
  String? _selectedDate = ''; // State variable for storing the selected date
  String? _familyName = 'test'; // State variable for storing the selected date
  String? _mobileNumber = ''; // State variable for storing the selected date
  String? _alternateMobileNumber =
      ''; // State variable for storing the selected date
  String? _emailAddress = ''; // State variable for storing the selected date
  String? _hornetNumber = '';
  String? _monthlyIncome = '2000';
  String? _VillageName = '';
  String? _addressLine = '';
  String? _pincode = '147021';
  String? _aadharNumber = '';
  String? _panCardNumber = '';
  String? _rationCardNumber = '';
  String? _voterNumber = '';
  String? _maleMember = '';
  String? _accountNumber = '';
  String? _accountHolderName = '';
  String? _IFSCcode = '';
  String? _BankName = '';
  String? _BranchName = '';
  String? _feMaleMember = '';
  String? _pmKishansNumber = '';
  String? _noOfChildNumber = '';
  String? _firstName = 'demo';
  String? _lastName = 'estte';
  String? _middleName = 'test';

  var paramdic = {"": ""};

  Farmersingledetail? _Farmersingledetail;
  bool loadlist = true;

  bool _isLoading = false;
  final TextEditingController _dateController =
  TextEditingController(); // Controller for the date field

  String? _selectedValue;
  final List<String> _selected = ['MALE', 'FEMALE', 'OTHER'];

  final List<String> _countryList = ['India'];

  final List<String> _education = [
    'Primary(1-5 class)',
    'Upper Primary(6-8 class)',
    'High School(9-10 class)',
    'Higher Secondary(11-12 class)',
    'Graduate',
    'Post Graduation'
  ];
  final List<String> _bplStatuses = ['Yes', 'No'];
  final List<String> _pmKishans = ['Yes', 'No'];
  final List<String> _occupations = ['Farmer', "Service", "Buiness", 'Other'];
  final List<String> _religions = [
    'Hindu',
    'Christian',
    'Muslim',
    'Sikh',
    'Buddhist',
    'Jain',
    'Other Religion',
  ];
  final List<String> _socialCategories = [
    'ST',
    'SC',
    'OBC',
    'GEN',
  ];
  final List<String> _states = ['Assam'];

  final List<String> _incomes = [
    'Below 2000',
    '2000 to 5000',
    '5000 to 8000',
    '8000 to 10,000',
    'Above 10, 000',
  ];
  final List<String> _salutation = ['Mr', 'Mrs', 'Late', 'Miss', 'Smt'];

  var _Alldata;
  List<Map<String, dynamic>> _district = [];
  List<Map<String, dynamic>> _block = [];
  List<Map<String, dynamic>> _vcdcs = [];
  List<Map<String, dynamic>> _revenueVillages = [];
  List<Map<String, dynamic>> _farmerCategories = [];

  File? _photoImage;
  File? _passbookImage;
  File? _aadharImage;
  File? _voterIdImage;


 String? _voterIdImageURL;
 String? _aadharImageURL;
 String? _passbookImageURL;
 String? _photoImageURL;

  Map<String, dynamic>? DashboardCategory;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _FamilyNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _alternateNumberController =
  TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _hornetController = TextEditingController();
  final TextEditingController _villageNameController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _aadharCardController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final TextEditingController _rationCardController = TextEditingController();
  final TextEditingController _voterCardController = TextEditingController();
  final TextEditingController _maleMemberController = TextEditingController();
  final TextEditingController _feMaleMemberController = TextEditingController();
  final TextEditingController _pmkishanController = TextEditingController();
  final TextEditingController _childrenNoController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _accountHolderNameController =
  TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();


  bool _click = false;



  Future<void> _EditFarmer() async {
    setState(() {
      _click = true;
    });
    var param = {
      "family_name": _familyName.toString(),
      "monthly_income": (_incomes.indexWhere(
              (e) => e.toString() == _monthlyIncome.toString()) +
          1)
          .toString(),
      "first_name": _firstName.toString(),
      "pincode": _pincode.toString(),
      "district_code":
      getcode(_Alldata['districts'], _selectedDistricts.toString()),
      "block_code": getcode(_Alldata['blocks'], _selectedBlocks.toString()),
      "vcdc_code": getcode(_Alldata['vcdcs'], _selectedVcdcs.toString()),
      "revenue_village_code":
      getcode(_Alldata['villages'], _selectedRevenueVillages.toString()),
      "date_of_birth": _selectedDate.toString(),
      "gender_code": 'GEN00' +
          (_selected.indexWhere(
                  (e) => e.toString() == _selectedValue.toString()) +
              1)
              .toString(),
      "mobile_number": _mobileNumber.toString(),
      "alternate_number": _alternateMobileNumber.toString(),
      "email": _emailAddress.toString(),
      "village": _selectedRevenueVillages.toString(),
      "male_members": _maleMember.toString(),
      "female_members": _feMaleMember.toString(),
      "is_pm_kishan_holder": _pmKishans.toString(),
      "pm_kishan_number": _pmKishansNumber.toString(),
    };

    print('rehal->>>>   $param');
    ApiClient().postMultipartData(
        Utils.store + "/${widget.id}", param, []).then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        Utils.toast(data["message"].toString());
        print("Done ${onValue.body}");
      } else {
        var data = json.decode(onValue.body);
        Utils.toast(data["message"].toString());
        print("Done ${onValue.body}");
      }
      setState(() {
        _click = false;
      });
    });
  }

  String getcode(List list, String select) {
    var id = list.firstWhere((district) => district["name"] == select)["code"];
    return id.toString();
  }

  getEditData(bool edit, String? id) {
    ApiClient().getData(Utils.editDetail + "/$id", true, "").then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        print(data["data"]);
        data = data["data"][0];

        // Split the full name into parts
        List<String> nameParts = data['full_name'].split(' ');
        // Assign values based on the number of parts
        if (nameParts.isNotEmpty) {
          _firstNameController.text = nameParts[0]; // First part is the first name
        }
        if (nameParts.length > 2) {
          // If there are more than two parts, treat all middle parts as middle name
          _middleNameController.text = nameParts.sublist(1, nameParts.length - 1).join(' ');
        }
        if (nameParts.length > 1) {
          _lastNameController.text = nameParts.last; // Last part is the last name
        }
        // _firstNameController.text = data['full_name'] ?? '';

        _dobController.text = data['date_of_birth'] ?? '';
        _mobilenumberController.text = data['mobile_number'] ?? '';
        _selectedValue = data['gender'] ?? '';
        _selectedDistricts = data['address']['district'] ?? '';
        _selectedBlocks = data['address']['block'] ?? '';
        _selectedVcdcs = data['address']['vcdc'] ?? '';
        _selectedRevenueVillages = data['address']['revenue_village'] ?? '';
        _alternateNumberController.text = data['alternate_number'] ?? '';
        _emailController.text = data['email'] ?? '';
        _hornetController.text = data['horticulture_id'] ?? '';
        _villageNameController.text = data['address']['revenue_village'] ?? '';
        _addressLineController.text = data['address']['address_line_1'] ?? '';
        _pincodeController.text = data['address']['pincode'] ?? '';
        _aadharCardController.text = data['aadhar_without_musk'] ?? '';
        _panCardController.text = data['pan_number'] ?? '';
        _maleMemberController.text = data['male_members'].toString() ?? '';
        _feMaleMemberController.text = data['female_members'].toString() ?? '';
        _pmkishanController.text = data['is_pm_kishan'] ?? '';
        _childrenNoController.text = data['total_member'].toString() ?? '';
        _photoImageURL = data['photograph'].toString() ?? '';
        _aadharImageURL = data['aadhar_card_image'].toString() ?? '';
        _voterIdImageURL = data['voter_card_image'].toString() ?? '';

        loadlist = false;
      } else {
        loadlist = false;
      }
      setState(() {});
    });
  }

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
      // if (widget.edit == true) {
        getEditData(widget.edit,
            widget.id); // Fetch farmer details when screen is opened
      // }
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
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                                _buildDropdown(
                                    'Salutation',
                                    _selectedSalutation,
                                    _salutation, (String? newValue) {
                                  setState(() {
                                    _selectedSalutation = newValue;
                                  });
                                }),
                                const SizedBox(height: 8),
                                _buildTextField(
                                  'First Name:',
                                  'Enter First Name',
                                  _firstNameController,
                                      (value) {
                                    // Handle the changed text
                                    _firstName = value;
                                    print('FirstName changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Middle Name:',
                                  'Enter Middle Name',
                                  _middleNameController,
                                      (value) {
                                    // Handle the changed text
                                    _middleName = value;
                                    print('MiddleName changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Last Name:',
                                  'Enter Last Name',
                                  _lastNameController,
                                      (value) {
                                    // Handle the changed text
                                    _lastName = value;
                                    print('LastName changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Family Name:',
                                  'Enter Family Name',
                                  _FamilyNameController,
                                      (value) {
                                    _familyName = value ?? '';
                                    print('FamilyName changed: $value');
                                  },
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
                                const SizedBox(height: 16),
                                _buildTextField(
                                    'Mobile Number:',
                                    'Enter Mobile Number',
                                    _mobilenumberController, (value) {
                                  _mobileNumber = value ?? '';

                                  print('Mobile Number changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildTextField(
                                    'Alternate Mobile Number :',
                                    'Enter Alternate Mobile Number ',
                                    _alternateNumberController, (value) {
                                  // Handle the changed text
                                  _alternateMobileNumber = value ?? '';

                                  print('Mobile Number changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Email:',
                                  'Enter Email Address',
                                  _emailController,
                                      (value) {
                                    // Handle the changed text
                                    _emailAddress = value ?? '';

                                    print('Email changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Gender:', _selectedValue, _selected,
                                        (String? newValue) {
                                      setState(() {
                                        _selectedValue = newValue;
                                      });
                                    }),
                                const SizedBox(height: 16),
                                _buildTextField(
                                    'Hornet Number (Max size: 10) :',
                                    'Enter Hornet Number',
                                    _hornetController, (value) {
                                  // Handle the changed text
                                  setState(() {
                                    _hornetNumber = value;
                                  });

                                  print('Hornet Number changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Monthly Family Income ✫ :',
                                    _selectedIncome,
                                    _incomes, (String? newValue) {
                                  setState(() {
                                    _selectedIncome = newValue;
                                  });
                                }),
                              ]))),
                  const SizedBox(height: 36),
                  const Text(
                    'Address Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                                  'Pincode::',
                                  'Enter PinCode',
                                  _pincodeController,
                                      (value) {
                                    // Handle the changed text
                                    _pincode = value;
                                    print('Email changed: $value');
                                  },
                                ),
                              ]))),
                 const SizedBox(height: 36),
                    const Text(
                      'Social Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                SizedBox(height: 16),
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
                                  _buildDropdown_second(
                                      'Farmer Category:',
                                      _selectedFarmerCategories,
                                      _farmerCategories, (dynamic? newValue) {
                                    setState(() {
                                      _selectedFarmerCategories = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Social Category:',
                                      _selectedSocialCategories,
                                      _socialCategories, (String? newValue) {
                                    setState(() {
                                      _selectedSocialCategories = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Education:',
                                      _selectedEducation,
                                      _education, (String? newValue) {
                                    setState(() {
                                      _selectedEducation = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Religion:',
                                      _selectedReligions,
                                      _religions, (String? newValue) {
                                    setState(() {
                                      _selectedReligions = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Occupation :',
                                      _selectedOccupations,
                                      _occupations, (String? newValue) {
                                    setState(() {
                                      _selectedOccupations = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                      'Aadhaar Number (Max size:12):',
                                      'Enter  Aadhaar Number',
                                      _aadharCardController, (value) {
                                    _aadharNumber = value;

                                    print('Aadhaar number changed: $value');
                                  }, isPhone: true),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Pan card Number (Max size:10):',
                                    'Enter Pan card Number (Max size:10):',
                                    _panCardController,
                                        (value) {
                                      // Handle the changed text
                                      _panCardNumber = value;
                                      print('Email changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Ration Card Number (Max Size:15):',
                                    'Enter Ration Number',
                                    _rationCardController,
                                        (value) {
                                      // Handle the changed text
                                      _rationCardNumber = value;

                                      print('Cardnumber changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Voter Number (Max Size:10):',
                                    'Enter Voter Number',
                                    _voterCardController,
                                        (value) {
                                      // Handle the changed text
                                      _voterNumber = value;
                                      print('Email changed: $value');
                                    },
                                  ),
                                ]))),
                  const SizedBox(height: 36),
                  const Text(
                    'Family Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16, top: 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Male Members :',
                                  'Enter no. of Male Member',
                                  _maleMemberController,
                                      (value) {
                                    // Handle the changed text
                                    _maleMember = value;
                                    print('male member changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Female Members :',
                                  'Enter no.of Female',
                                  _feMaleMemberController,
                                      (value) {
                                    // Handle the changed text
                                    _feMaleMember = value;
                                    print('Email changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Do Farmer belong to BPL Category?:',
                                    _selectedBplStatuses,
                                    _bplStatuses, (String? newValue) {
                                  setState(() {
                                    _selectedBplStatuses = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Is PM-Kishan Holder ?:',
                                    _selectedPmKishans,
                                    _pmKishans, (String? newValue) {
                                  setState(() {
                                    _selectedPmKishans = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'PM-Kishan Number:',
                                  'Enter PM-Kishan Number',
                                  _pmkishanController,
                                      (value) {
                                    // Handle the changed text
                                    _pmKishansNumber = value;

                                    print('Email changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'No of Children (Below 12 years):',
                                  'Enter no of children',
                                  _childrenNoController,
                                      (value) {
                                    // Handle the changed text
                                    _noOfChildNumber = value;
                                    print('Email changed: $value');
                                  },
                                ),
                              ]))),
                  const SizedBox(height: 16),
                  const SizedBox(height: 36),
                     const Text(
                      'Account Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                                'Account Number (Max size: 20) :',
                                'Enter Account Number',
                                _accountNoController,
                                    (value) {
                                  // Handle the changed text
                                  _accountNumber = value;
                                  print('male member changed: $value');
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                'Account Holder Name :',
                                'Enter Account Holder Name ',
                                _accountHolderNameController,
                                    (value) {
                                  // Handle the changed text
                                  _accountHolderName = value;
                                  print('Email changed: $value');
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                'IFSC Code (Max size: 11) :',
                                'Enter IFSC Code ',
                                _ifscCodeController,
                                    (value) {
                                  // Handle the changed text
                                  _IFSCcode = value;
                                  print('Email changed: $value');
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                'Bank Name :',
                                'Bank Name ',
                                _bankNameController,
                                    (value) {
                                  // Handle the changed text
                                  _BankName = value;

                                  print('Email changed: $value');
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                'Branch Name :',
                                'Branch Name',
                                _branchNameController,
                                    (value) {
                                  // Handle the changed text
                                  _BranchName = value;
                                  print('Email changed: $value');
                                },
                              ),
                              const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildImageUploadSection(
                                              title: 'User Personal Image',
                                              buttonText: 'Upload user Image',
                                              imageFile: _photoImage,
                                              onUpload: () => _pickImage(
                                                  ImageSource.camera, 'Image'),
                                              url: _photoImageURL,
                                            ),
                                          ),
                                          Expanded(
                                            child: _buildImageUploadSection(
                                              title: 'Passbook Image',
                                              buttonText: 'Upload Passbook',
                                              imageFile: _passbookImage,                                               onUpload: () => _pickImage(
                                                  ImageSource.camera,
                                                  'passbook'),
                                              url: _passbookImageURL,

                                            ),

                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(
                                                  8.0), // Add margin to provide space
                                              child: _buildImageUploadSection(
                                                title: 'Upload Aadhaar Card',
                                                buttonText: 'Browse Image',
                                                imageFile: _aadharImage,
                                                onUpload: () => _pickImage(
                                                    ImageSource.camera,
                                                    'aadhar'),
                                                url: _aadharImageURL,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              width:
                                              8), // Add space between the containers
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(
                                                  8.0), // Add margin to provide space
                                              child: _buildImageUploadSection(
                                                title: 'Upload Voter ID Card',
                                                buttonText: 'Browse Image',
                                                imageFile: _voterIdImage,
                                                onUpload: () => _pickImage(ImageSource.camera, 'voterId'),
                                                url: _voterIdImageURL,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                            ]),
                      ),
                    ),
                  const SizedBox(height: 16),
                  // _buildSectionTitle("Save")
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
                ), onChanged: onChanged,

              ),
            ),
          ),
        ),
      ],
    );
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
                if (_click) return; // Prevent multiple presses
                if (widget.edit == true) {
                  _EditFarmer();
                } else {
                  // _CreateFarmer();
                }
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
              child: _click
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  :  Text(title),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, String imageType) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        switch (imageType) {
          case 'Image':
            _photoImage = File(image.path);
            break;
          case 'passbook':
            _passbookImage = File(image.path);
            break;
          case 'aadhar':
            _aadharImage = File(image.path);
            break;
          case 'voterId':
            _voterIdImage = File(image.path);
            break;
        }
      });
    }
  }

  Widget _buildImageUploadSection({
    required String title,
    required String buttonText,
    File? imageFile,
    required String? url,
    required Function() onUpload,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              if (imageFile != null)
                Image.file(imageFile, height: 100, width: 100, fit: BoxFit.cover,)
              else
                if(url != null)
                  Image.network(url!,height: 100,width: 100,fit: BoxFit.cover)
              else
                  const Icon(Icons.upload_file, size: 50, color: Colors.grey),


                // const Icon(Icons.upload_file, size: 50, color: Colors.grey),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onUpload,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
//  Future<String> downloadandsave(String uri)async{
//    final Directory directory = await getApplicationDocumentsDirectory();
//    final String filePath = '${directory.path}/shop';
//    final http.Response response = await http.get(Uri.parse(uri));
//    final File file = File(filePath);
//    await file.writeAsBytes(response.bodyBytes);
//    return filePath;
//  }


  bool _isValidEmail(String email) {
    // Simple email validation
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegExp.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // Simple phone number validation (example: 10 digits)
    final phoneRegExp = RegExp(r'^\d{10}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  bool _isValidAadharNumber(String aadharNumber) {
    // Aadhar number validation (example: 12 digits)
    final aadharRegExp = RegExp(r'^\d{12}$');
    return aadharRegExp.hasMatch(aadharNumber);
  }
}
