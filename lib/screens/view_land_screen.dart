import 'dart:convert';
import 'dart:io';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:btr_gov/screens/add_farmer_screen.dart';
import 'package:btr_gov/screens/assets_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ViewFarmerScreen extends StatefulWidget {
  final bool edit;
  final String? id;

  ViewFarmerScreen({required this.edit, this.id});

  @override
  _ViewFarmerState createState() => _ViewFarmerState();
}

class _ViewFarmerState extends State<ViewFarmerScreen> {
  String? _selectedSalutation = 'Mr';
  String? _selectedCountry = 'India';
  String? _selectedFarmerCategories = '';
  String? _selectedEducation = 'EDU_A';
  String? _selectedBplStatuses = 'Yes';
  String? _selectedPmKishans = 'Yes';
  String? _selectedOccupations = 'OCCUPATION_A';
  String? _selectedReligions = 'Hindu';
  String? _selectedSocialCategories = 'ST';
  String? _selectedState = 'Assam';
  String? _selectedDistricts;
  String? _selectedBlocks;
  String? _selectedIncome = 'Below 2000';
  String? _selectedVcdcs;
  String? _selectedRevenueVillages;

  bool loadlist = true;

  String? _selectedValue;

  File? _photoImage;
  File? _passbookImage;
  File? _aadharImage;
  File? _voterIdImage;

  String? _voterIdImageURL;
  String? _aadharImageURL;
  String? _passbookImageURL;
  String? _photoImageURL;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _FamilyNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _alternateNumberController = TextEditingController();
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
  final TextEditingController _accountHolderNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('Edit mode: ${widget.edit}');
    print('Farmer ID: ${widget.id}');
    if (widget.edit && widget.id != null) {
      getEditData(widget.id!);
    } else {
      loadlist = false;
      setState(() {});
    }
  }

  Future<void> getEditData(String id) async {
    try {
      final response = await ApiClient().getData(Utils.editDetail + "/$id", true, "");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data = data["data"][0];

        // Split the full name into parts
        List<String> nameParts = data['full_name'].split(' ');
        if (nameParts.isNotEmpty) {
          _firstNameController.text = nameParts[0];
        }
        if (nameParts.length > 2) {
          _middleNameController.text = nameParts.sublist(1, nameParts.length - 1).join(' ');
        }
        if (nameParts.length > 1) {
          _lastNameController.text = nameParts.last;
        }

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
        _maleMemberController.text = data['male_members']?.toString() ?? '';
        _feMaleMemberController.text = data['female_members']?.toString() ?? '';
        _pmkishanController.text = data['is_pm_kishan'] ?? '';
        _childrenNoController.text = data['total_member']?.toString() ?? '';
        _photoImageURL = data['photograph']?.toString();
        _aadharImageURL = data['aadhar_card_image']?.toString();
        _voterIdImageURL = data['voter_card_image']?.toString();
        _passbookImageURL = data['passbook_image']?.toString();

        loadlist = false;
        setState(() {});
      } else {
        loadlist = false;
        setState(() {});
      }
    } catch (e) {
      // Handle any errors here
      loadlist = false;
      setState(() {});
    }
  }

  Future<void> _pickImage(ImageSource source, String imageType) async {
    final XFile? image = await _picker.pickImage(source: source);
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
    String? url,
    required Function() onUpload,
  }) {
    // Define a placeholder image URL (can be a local asset or a network URL)
    const String placeholderImageUrl = 'https://via.placeholder.com/100';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Display title (commented out in the original code)
              // Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              // Display the image or placeholder
              if (imageFile != null)
                Image.file(
                  imageFile,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              else if (url != null && url.isNotEmpty)
                Image.network(
                  url,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // In case of error loading image from URL, show placeholder
                    return Image.network(
                      placeholderImageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    );
                  },
                )
              else
                Image.network(
                  placeholderImageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),

              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: onUpload,
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "$key:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value.isNotEmpty ? value : "-",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('View Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4,
                color: Color(0xFF2F365F),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/farmer.svg', // Path to your SVG icon
                        height: 24, // Adjust height as needed
                        width: 24, // Adjust width as needed
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Expanded( // Use Expanded to fill available width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'View Farmer',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


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
                      _buildKeyValueRow('Salutation', _selectedSalutation ?? 'Not Provided'),
                      _buildKeyValueRow('First Name', _firstNameController.text),
                      _buildKeyValueRow('Middle Name', _middleNameController.text),
                      _buildKeyValueRow('Last Name', _lastNameController.text),
                      _buildKeyValueRow('Family Name', _FamilyNameController.text ?? 'Not Provided'),
                      _buildKeyValueRow('Date of Birth', _dobController.text ?? 'Not Provided'),
                      _buildKeyValueRow('Mobile Number', _mobilenumberController.text ?? 'Not Provided'),
                      _buildKeyValueRow('Alternate Mobile Number', _alternateNumberController.text ?? 'Not Provided'),
                      _buildKeyValueRow('Email', _emailController.text ?? 'Not Provided'),
                      _buildKeyValueRow('Gender', _selectedValue ?? 'Not Provided'),
                      _buildKeyValueRow('Hornet Number (Max size: 10)', _hornetController.text ?? 'Not Provided'),
                      _buildKeyValueRow('Monthly Family Income', _selectedIncome ?? 'Not Provided'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text('Address Information',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
              const SizedBox(height: 16),
              Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildKeyValueRow('Country', _selectedCountry ?? 'N/A'),
                            _buildKeyValueRow('State', _selectedState ?? 'N/A'),
                            _buildKeyValueRow('District', _selectedDistricts ?? 'N/A'),
                            _buildKeyValueRow('Block', _selectedBlocks ?? 'N/A'),
                            _buildKeyValueRow('VCDC', _selectedVcdcs ?? 'N/A'),
                            _buildKeyValueRow('Revenue Village', _selectedRevenueVillages ?? 'N/A'),
                            _buildKeyValueRow('Village Name', _villageNameController.text.isNotEmpty ? _villageNameController.text : 'N/A'),
                            _buildKeyValueRow('Address Line', _addressLineController.text.isNotEmpty ? _addressLineController.text : 'N/A'),
                            _buildKeyValueRow('Pincode', _pincodeController.text.isNotEmpty ? _pincodeController.text : 'N/A'),
                            // _buildKeyValueRow( '', _selectedIncome!),
                          ]))),

              const SizedBox(height: 20),


              const Text('Social Information',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
              SizedBox(height: 16),
              Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),

                            _buildKeyValueRow( 'Farmer Category', ''),
                            _buildKeyValueRow( 'Social Category', _selectedSocialCategories!),
                            _buildKeyValueRow( 'Education', _selectedEducation!),
                            _buildKeyValueRow( 'Religion', _selectedReligions!),
                            _buildKeyValueRow( 'Occupation', _selectedOccupations!),
                            _buildKeyValueRow( 'Aadhaar Number', _aadharCardController.text),
                            _buildKeyValueRow( 'Pan card Number', _panCardController.text),
                            _buildKeyValueRow( 'Ration Card Number', _rationCardController.text),
                            _buildKeyValueRow( 'Voter Number', _voterCardController.text),

                          ]))),
              const SizedBox(height: 20),
              const Text('Family Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
              const SizedBox(height: 20),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16, top: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            _buildKeyValueRow( 'Male Members', _maleMemberController.text),
                            _buildKeyValueRow( 'Female Members', _feMaleMemberController.text),
                            _buildKeyValueRow( 'Do Farmer belong to BPL Category?', _selectedBplStatuses!),
                            _buildKeyValueRow( 'Is PM-Kishan Holder ?', _selectedPmKishans!),
                            _buildKeyValueRow( 'PM-Kishan Number', _pmkishanController.text),
                            _buildKeyValueRow( 'No of Children (Below 12 years)', _childrenNoController.text),

                          ]))),
              const SizedBox(height: 20),
              const Text('Account Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                const SizedBox(height: 20),
              Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                  color: Colors.white,
                  elevation: 4,
                child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(height: 16),
                _buildKeyValueRow( 'Account Number (Max size: 20)', _accountNoController.text),
                _buildKeyValueRow( 'Account Holder Name', _accountHolderNameController.text),
                _buildKeyValueRow( 'IFSC Code (Max size: 11)', _ifscCodeController.text),
                _buildKeyValueRow( 'Bank Name', _bankNameController.text),
                _buildKeyValueRow( 'Branch Name', _branchNameController.text!),
                ]))),
                 const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildImageUploadSection(
                          title: 'Photograph',
                          buttonText: 'Upload Photo',
                          imageFile: _photoImage,
                          url: _photoImageURL,
                          onUpload: () => _pickImage(ImageSource.camera, 'Image'),
                          ),
                        ),
                        Expanded(
                          child: _buildImageUploadSection(
                            title: 'Passbook Image',
                            buttonText: 'Upload Passbook',
                            imageFile: _passbookImage,
                            onUpload: () => _pickImage(ImageSource.camera, 'passbook'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(margin: const EdgeInsets.all(8.0), // Add margin to provide space
                            child: _buildImageUploadSection(
                              title: 'Upload Aadhaar Card',
                              buttonText: 'Browse Image',
                              imageFile: _aadharImage,
                              onUpload: () => _pickImage(ImageSource.camera,'aadhar'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(
                                8.0), // Add margin to provide space
                            child: _buildImageUploadSection(
                              title: 'Upload Voter ID Card',
                              buttonText: 'Browse Image',
                              imageFile: _voterIdImage,
                              onUpload: () => _pickImage(
                                  ImageSource.camera,
                                  'voterId'),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
