import 'dart:convert';
import 'dart:io';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/FarmerSingleDetail.dart';
import '../retrofit/CommonService.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddFarmerScreen extends StatefulWidget {
  bool edit = false;
  String? id;
  AddFarmerScreen({required this.edit, this.id});

  @override
  _AddFarmerState createState() => _AddFarmerState();
}

class _AddFarmerState extends State<AddFarmerScreen> {
  String? _selectedSalutation = 'Mr';
  String? _selectedCountry = 'India'; // Set initial value to match the list
  String? _selectedFarmerCategories =
      'FARMER_CAT_1'; // Set initial value to match the list
  String? _selectedEducation = 'EDU_A'; // Set initial value to match the list
  String? _selectedBplStatuses = 'Yes'; // Set initial value to match the list
  String? _selectedPmKishans = 'Yes'; // Set initial value to match the list
  String? _selectedOccupations =
      'OCCUPATION_A'; // Set initial value to match the list
  String? _selectedReligions = 'Hindu'; // Set initial value to match the list
  String? _selectedSocialCategories =
      'ST'; // Set initial value to match the list
  String? _selectedState = ''; // Set initial value to match the list
  String? _selectedDistricts = 'Baksa'; // Set initial value to match the list
  String? _selectedBlocks = 'All'; // Set initial value to match the list
  String? _selectedIncome = 'Below 2000'; // Set initial value to match the list
  String? _selectedVcdcs = 'All'; // Set initial value to m
  String? _selectedRevenueVillages = 'All';
  String? _selectedDate = ''; // State variable for storing the selected date
  String? _familyName = 'test'; // State variable for storing the selected date
  String? _mobileNumber = ''; // State variable for storing the selected date
  String? _alternateMobileNumber = ''; // State variable for storing the selected date
  String? _emailAddress = ''; // State variable for storing the selected date
  String? _hornetNumber = '';
  String? _monthlyIncome='2000';
  String? _VillageName='';
  String? _addressLine='';
  String? _pincode='147021';
  String? _aadharNumber='';
  String? _panCardNumber='';
  String? _rationCardNumber='';
  String? _voterNumber='';
  String? _maleMember='';
  String? _accountNumber='';
  String? _accountHolderName='';
  String? _IFSCcode='';
  String? _BankName='';
  String? _BranchName='';
  String? _feMaleMember='';
  String? _pmKishansNumber='';
  String? _noOfChildNumber='';
  String? _firstName='demo';
  String? _lastName='estte';
  String? _middleName='test';

  var paramdic = {"": ""};

  Farmersingledetail? _Farmersingledetail;
  bool loadlist = true;


  bool _isLoading = false;
  final TextEditingController _dateController =
      TextEditingController(); // Controller for the date field

  String? _selectedValue = '--select--';
  final List<String> _selected = ['--select--', 'MALE', 'FEMALE', 'OTHER'];

  final List<String> _countryList = ['India'];
  final List<String> _farmerCategories = ['Farmer','Farm worker','Processor','Non-farmer'];
  final List<String> _education = ['Primary(1-5 class)','Upper Primary(6-8 class)','High School(9-10 class)','Higher Secondary(11-12 class)','Graduate','Post Graduation'];
  final List<String> _bplStatuses = ['Yes', 'No'];
  final List<String> _pmKishans = ['Yes', 'No'];
  final List<String> _occupations = ['OCCUPATION_A'];
  final List<String> _religions = ['Hindu', 'Christian', 'Muslim', 'Sikh', 'Buddhist', 'Jain', 'Other Religion',];
  final List<String> _socialCategories = ['ST', 'SC', 'OBC', 'GEN',];
  final List<String> _states = ['Assam'];
  final List<String> _districts = ['Baksa','Balaji','Barpeta','Chirang','Kokrajhar','Tamulpur','Udalguri'];
  final List<String> _blocks = ['BARAMA','BAKSA','DHAMDHAMA','GOBARDHANA(BTC)','GORESWAR','JALAH(BTC)','NAGRIJULI', 'TAMULPUR'];
  final List<String> _incomes = ['Below 2000', '2000 to 5000', '5000 to 8000', '8000 to 10,000', 'Above 10, 000',];
  final List<String> _salutation = ['Mr', 'Mrs', 'Late', 'Miss', 'Smt'];
  final List<String> _vcdcs = ['Barama', 'Debachara', 'Kaklabari', 'Kharuajan','Merkuchi','Puransripur'];
  final List<String> _revenueVillages = ['Barama', 'Nizjuluki', 'Khadamtola', 'Heramjar''Madhapur''Kaljar''Alagar''Mahoria'];

  File? _passbookImage;
  File? _aadharImage;
  File? _voterIdImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _CreateFarmer() async {
    if (_passbookImage == null ||
        _aadharImage == null ||
        _voterIdImage == null) {
      print('Please select both files');
      Utils.toast('Please select both files');
      return;
    }
    var param = {
      "family_name": _familyName.toString(),
      "monthly_income": _monthlyIncome.toString(),
      "first_name": _firstName.toString(),
      "middle_name": _middleName.toString(),
      "last_name": _lastName.toString(),
      "address_line_1": _addressLine.toString(),
      "address_line_2": _revenueVillages.toString(),
      "pincode": _pincode.toString(),
      "country_code": "IN",
      "state_code": _selectedState.toString(),
      "district_code": _selectedDistricts.toString(),
      "block_code": _selectedBlocks.toString(),
      "vcdc_code": _selectedVcdcs.toString(),
      "revenue_village_code": _revenueVillages.toString(),
      "date_of_birth": _dateController.toString(),
      "gender_code": _selectedValue.toString(),
      "photograph": "",
      "mobile_number": _mobileNumber.toString(),
      "alternate_number": _alternateMobileNumber.toString(),
      "email": _emailAddress.toString(),
      "farmer_category_code": _farmerCategories.toString(),
      "social_category_code": _socialCategories.toString(),
      "education_code": _selectedEducation.toString(),
      "religion_code": _selectedReligions.toString(),
      "occupation_code": _selectedOccupations.toString(),
      "aadhar_number": _aadharNumber.toString(),
      "aadhar_card_image": _aadharImage.toString(),
      "voter_card_image": _voterIdImage.toString(),
      "relation": _selectedReligions.toString(),
      "pan_number": _panCardNumber.toString(),
      "ration_card": _rationCardNumber.toString(),
      "voter_number": _voterNumber.toString(),
      "govt_farmer_id": "",
      "hortnet_id": "1111111111",
      "is_head": "",
      "village": _selectedRevenueVillages.toString(),
      "family_head_id": "",
      "salutation_id": "1",
      "search": "",
      "is_bpl": "0",
      "male_members": _maleMember.toString(),
      "female_members": _feMaleMember.toString(),
      "is_pm_kishan_holder": _pmKishans.toString(),
      "pm_kishan_number": _pmKishansNumber.toString(),
      "is_financial_assistant_holder": "",
      "amount": "100",
      "received_year": "2000",
      "scheme_name": "",
      "open_pm_number": "0",
      "acc_num": _accountNumber.toString(),
      "acc_holder_name": _accountHolderName.toString(),
      "ifsc_code": _IFSCcode.toString(),
      "bank_name": _BankName.toString(),
      "bank_branch_name": _BranchName.toString(),
      "bank_passbook": "",
      "metadata[isGovtjob]": "0"
    };

    print('rehal->>>>   $param');
    ApiClient().postMultipartData(Utils.store, param, [
      MultipartBody(
        'photograph',
        XFile(_passbookImage!.path),
      ),
      MultipartBody(
        'aadhar_card_image',
        XFile(_aadharImage!.path),
      ),
      MultipartBody(
        'voter_card_image',
        XFile(_voterIdImage!.path),
      ),
    ]).then((onValue) {
      if (onValue.statusCode == 201) {
        Utils.toast(onValue.body);
        print("Done ${onValue.body}");

      } else {
        Utils.toast(onValue.body);
        print("error ${onValue.body}");
      }
    });

    // try {
    //   final commonService = Provider.of<CommonService>(context, listen: false);

    //   await commonService.postFarmerData(
    //     photograph: _passbookImage!,
    //     aadharCardImage: _aadharImage!,
    //     familyName: 'fxgdfgdg',
    //     monthlyIncome: '1',
    //     firstName: 'Swsadadaran',
    //     middleName: 'cdf',
    //     lastName: 'Singh',
    //     addressLine1: 'etdhdhdhd',
    //     addressLine2: 'Patiala',
    //     pincode: '147001',
    //     countryCode: 'IN',
    //     stateCode: '18',
    //     districtCode: '25',
    //     blockCode: '15',
    //     vcdcCode: '316',
    //     revenueVillageCode: '',
    //     dateOfBirth: '1990-09-09',
    //     genderCode: 'GEN001',
    //     mobileNumber: '9876543210',
    //     alternateNumber: '',
    //     email: 'myemail@gmail.com',
    //     farmerCategoryCode: 'CAT001',
    //     socialCategoryCode: '04',
    //     educationCode: 'EDU001',
    //     religionCode: '04',
    //     occupationCode: 'OCC001',
    //     aadharNumber: '123412565845',
    //     voterCardImage: '',
    //     relation: '',
    //     panNumber: '1256987425',
    //     rationCard: '121212121212145',
    //     voterNumber: '5625365842',
    //     govtFarmerId: '',
    //     hortnetId: '1111111111',
    //     isHead: '',
    //     village: '',
    //     familyHeadId: '',
    //     salutationId: '1',
    //     search: '',
    //     isBpl: '0',
    //     maleMembers: '2',
    //     femaleMembers: '3',
    //     isPmKishanHolder: '0',
    //     pmKishanNumber: '',
    //     isFinancialAssistantHolder: '',
    //     amount: '',
    //     receivedYear: '',
    //     schemeName: '',
    //     openPmNumber: '0',
    //     accNum: '',
    //     accHolderName: '',
    //     ifscCode: '',
    //     bankName: '',
    //     bankBranchName: '',
    //     bankPassbook: '',
    //     metadataIsGovtjob: '0',
    //   );
    // } catch (e) {
    //   print('Error: $e');
    // }
  }

  getdata(bool edit, String? id) {
    ApiClient().getData(Utils.editDetail, true, paramdic).then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        _Farmersingledetail = Farmersingledetail.fromJson(data["data"]);
        print(data["data"]);
        loadlist = false;
      } else {
        loadlist = false;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    print('Edit mode: ${widget.edit}');
    print('Farmer ID: ${widget.id}');
    if(widget.edit == true){
      getdata(widget.edit, widget.id); // Fetch farmer details when screen is opened

    }
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
                                  '',
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
                                  '',
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
                                  '',
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
                                  '',
                                  (value) {
                                    _familyName = value ?? '';
                                    print('FamilyName changed: $value');
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildDatePickerField(
                                  'Date of Birth:',
                                  'Enter DOB',
                                  _dateController,
                                  // Pass the date controller to the date field
                                  (value) {
                                    setState(() {
                                      _selectedDate = value ?? '';
                                      print('Selected DOB: $value');
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                    'Mobile Number:', 'Enter Mobile Number', '',
                                    (value) {
                                      _mobileNumber = value ?? '';

                                      print('Mobile Number changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildTextField(
                                    'Alternate Mobile Number :',
                                    'Enter Alternate Mobile Number ',
                                    '', (value) {
                                  // Handle the changed text
                                  _alternateMobileNumber = value ?? '';

                                  print('Mobile Number changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Email:',
                                  'Enter Email Address',
                                  '',
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
                                    '', (value) {
                                  // Handle the changed text
                                  setState(() {
                                    _hornetNumber = value;

                                  });

                                  print('Hornet Number changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildTextField(
                                    'Monthly Family Income ✫ :', '', '',
                                    (value) {
                                  // Handle the changed text
                                      _monthlyIncome = value;

                                  print('MonthlyIncome changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Monthly Family IncomeZ:',
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
                                _buildDropdown(
                                    'District:', _selectedDistricts, _districts,
                                    (String? newValue) {
                                  setState(() {
                                    _selectedDistricts = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Block:', _selectedBlocks, _blocks,
                                    (String? newValue) {
                                  setState(() {
                                    _selectedBlocks = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildDropdown('VCDC :', _selectedVcdcs, _vcdcs,
                                    (String? newValue) {
                                  setState(() {
                                    _selectedVcdcs = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Revenue Village:',
                                    _selectedRevenueVillages,
                                    _revenueVillages, (String? newValue) {
                                  setState(() {
                                    _selectedRevenueVillages = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Village Name:',
                                  'Enter Village Name',
                                  '',
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
                                  '',
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
                                  '',
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
                                    'Farmer Category:',
                                    _selectedFarmerCategories,
                                    _farmerCategories, (String? newValue) {
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
                                _buildDropdown('Education:', _selectedEducation,
                                    _education, (String? newValue) {
                                  setState(() {
                                    _selectedEducation = newValue;
                                  });
                                }),
                                const SizedBox(height: 16),
                                _buildDropdown(
                                    'Religion:', _selectedReligions, _religions,
                                    (String? newValue) {
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
                                _buildTextField('Aadhaar Number (Max size:12):',
                                    'Enter  Aadhaar Number', '', (value) {
                                  // Handle the changed text
                                      _aadharNumber = value;

                                  print('Aadhaar number changed: $value');
                                }, isPhone: true),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Pan card Number (Max size:10):',
                                  'Enter Pan card Number (Max size:10):',
                                  '',
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
                                  '',
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
                                  '',
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
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                _buildTextField(
                                  'Male Members :',
                                  'Enter no. of Male Member',
                                  '',
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
                                  '',
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
                                  '',
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
                                  '',
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
                                  '',
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
                                  '',
                                      (value) {
                                    // Handle the changed text
                                    _accountHolderName = value;
                                    print('Email changed: $value');
                                  },
                                ),

                                const SizedBox(height: 16),
                                _buildTextField('IFSC Code (Max size: 11) :', 'Enter IFSC Code ', '',
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
                                  '',
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
                                  '',
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
                                      _buildImageUploadSection(
                                        title: 'Passbook Image',
                                        buttonText: 'Upload Passbook',
                                        imageFile: _passbookImage,
                                        onUpload: () =>
                                            _pickImage(ImageSource.camera, 'passbook'),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(8.0), // Add margin to provide space
                                              child: _buildImageUploadSection(
                                                title: 'Upload Aadhaar Card',
                                                buttonText: 'Browse Image',
                                                imageFile: _aadharImage,
                                                onUpload: () =>
                                                    _pickImage(ImageSource.camera, 'aadhar'),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8), // Add space between the containers
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(
                                                  8.0), // Add margin to provide space
                                              child: _buildImageUploadSection(
                                                title: 'Upload Voter ID Card',
                                                buttonText: 'Browse Image',
                                                imageFile: _voterIdImage,
                                                onUpload: () => _pickImage(
                                                    ImageSource.camera, 'voterId'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]
                          ),
                      ),


                  ),

                  const SizedBox(height: 16),
                  _buildSectionTitle("Save")
                ],
              )),
        ));
  }

  Widget _buildDropdown(String label, String? selectedValue, List<String> items,
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
            child: DropdownButton<String>(
              value: validatedSelectedValue,
              isExpanded: true,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
    String? initialValue,
    ValueChanged<String?> onChanged, {
    bool isPhone = false, // Add an optional parameter for phone input
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
            controller: TextEditingController(text: initialValue),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            // Use phone keyboard if isPhone is true
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
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _CreateFarmer();
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

  Future<void> _pickImage(ImageSource source, String imageType) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        switch (imageType) {
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
                Image.file(
                  imageFile,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              else
                const Icon(Icons.upload_file, size: 50, color: Colors.grey),
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
}
