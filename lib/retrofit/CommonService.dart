import 'dart:io';
import 'dart:math';

import 'package:btr_gov/model/FarmarDetailModel.dart';
import 'package:btr_gov/model/LoginResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/ForgotResponse.dart';

class CommonService {
  final String _baseUrl =
      'https://api.learnwithchoudhary.com/api'; // Replace with your API base URL

  Future<LoginResponse> login(
      String mobileNumber, String password, String department) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/admin/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': mobileNumber,
        'password': password,
        'department_code': department,
      }),
    );


    if (response.statusCode == 200) {
      print("login_response success: ${response.body}");
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      print("login_response error: ${response.toString()}");
      throw Exception('Failed to log in');
    }
  }

  Future<ForgotResponse> forgotPassword(String email, ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,

      }),
    );
    print("forgot_response common: ${response.body}");

    if (response.statusCode == 200) {
      print("forgot_response success: ${response.body}");
      return ForgotResponse.fromJson(jsonDecode(response.body));
    } else {
      print("forgot_response error: ${response.toString()}");
      throw Exception('Failed to log in');
    }
  }

  Future<FarmarDetailModel> getFarmerDetail() async {
    // final response = await http.get(Uri.parse('$_baseUrl/farmers/details/create'));
    //
    final response = await http.get(
      Uri.parse('$_baseUrl/farmers/details/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("getFarmerDetail common: ${response.body}");

    if (response.statusCode == 200) {
      print("getFarmerDetail success: ${response.body}");
      return FarmarDetailModel.fromJson(jsonDecode(response.body));
    } else {
      print("forgot_response error: ${response.toString()}");
      throw Exception('Failed to log in');
    }
  }


  Future<void> addFarmer(Map<String, String> farmerData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/add-farmer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(farmerData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add farmer');
    }
  }

  Future<List<Map<String, dynamic>>> getFarmers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/get-farmers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get farmers');
    }
  }


  // Method to post farmer data with file uploads
  Future<void> postFarmerData({
    required File photograph,
    required File aadharCardImage,
    required String familyName,
    required String monthlyIncome,
    required String firstName,
    required String middleName,
    required String lastName,
    required String addressLine1,
    required String addressLine2,
    required String pincode,
    required String countryCode,
    required String stateCode,
    required String districtCode,
    required String blockCode,
    required String vcdcCode,
    required String revenueVillageCode,
    required String dateOfBirth,
    required String genderCode,
    required String mobileNumber,
    required String alternateNumber,
    required String email,
    required String farmerCategoryCode,
    required String socialCategoryCode,
    required String educationCode,
    required String religionCode,
    required String occupationCode,
    required String aadharNumber,
    required String voterCardImage,
    required String relation,
    required String panNumber,
    required String rationCard,
    required String voterNumber,
    required String govtFarmerId,
    required String hortnetId,
    required String isHead,
    required String village,
    required String familyHeadId,
    required String salutationId,
    required String search,
    required String isBpl,
    required String maleMembers,
    required String femaleMembers,
    required String isPmKishanHolder,
    required String pmKishanNumber,
    required String isFinancialAssistantHolder,
    required String amount,
    required String receivedYear,
    required String schemeName,
    required String openPmNumber,
    required String accNum,
    required String accHolderName,
    required String ifscCode,
    required String bankName,
    required String bankBranchName,
    required String bankPassbook,
    required String metadataIsGovtjob,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/farmers/data'); // Replace with your API endpoint
      final request = http.MultipartRequest('POST', uri)
        ..fields['family_name'] = familyName
        ..fields['monthly_income'] = monthlyIncome
        ..fields['first_name'] = firstName
        ..fields['middle_name'] = middleName
        ..fields['last_name'] = lastName
        ..fields['address_line_1'] = addressLine1
        ..fields['address_line_2'] = addressLine2
        ..fields['pincode'] = pincode
        ..fields['country_code'] = countryCode
        ..fields['state_code'] = stateCode
        ..fields['district_code'] = districtCode
        ..fields['block_code'] = blockCode
        ..fields['vcdc_code'] = vcdcCode
        ..fields['revenue_village_code'] = revenueVillageCode
        ..fields['date_of_birth'] = dateOfBirth
        ..fields['gender_code'] = genderCode
        ..fields['mobile_number'] = mobileNumber
        ..fields['alternate_number'] = alternateNumber
        ..fields['email'] = email
        ..fields['farmer_category_code'] = farmerCategoryCode
        ..fields['social_category_code'] = socialCategoryCode
        ..fields['education_code'] = educationCode
        ..fields['religion_code'] = religionCode
        ..fields['occupation_code'] = occupationCode
        ..fields['aadhar_number'] = aadharNumber
        ..fields['voter_card_image'] = voterCardImage
        ..fields['relation'] = relation
        ..fields['pan_number'] = panNumber
        ..fields['ration_card'] = rationCard
        ..fields['voter_number'] = voterNumber
        ..fields['govt_farmer_id'] = govtFarmerId
        ..fields['hortnet_id'] = hortnetId
        ..fields['is_head'] = isHead
        ..fields['village'] = village
        ..fields['family_head_id'] = familyHeadId
        ..fields['salutation_id'] = salutationId
        ..fields['search'] = search
        ..fields['is_bpl'] = isBpl
        ..fields['male_members'] = maleMembers
        ..fields['female_members'] = femaleMembers
        ..fields['is_pm_kishan_holder'] = isPmKishanHolder
        ..fields['pm_kishan_number'] = pmKishanNumber
        ..fields['is_financial_assistant_holder'] = isFinancialAssistantHolder
        ..fields['amount'] = amount
        ..fields['received_year'] = receivedYear
        ..fields['scheme_name'] = schemeName
        ..fields['open_pm_number'] = openPmNumber
        ..fields['acc_num'] = accNum
        ..fields['acc_holder_name'] = accHolderName
        ..fields['ifsc_code'] = ifscCode
        ..fields['bank_name'] = bankName
        ..fields['bank_branch_name'] = bankBranchName
        ..fields['bank_passbook'] = bankPassbook
        ..fields['metadata[isGovtjob]'] = metadataIsGovtjob
        ..files.add(await http.MultipartFile.fromPath('photograph', photograph.path))
        ..files.add(await http.MultipartFile.fromPath('aadhar_card_image', aadharCardImage.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Data uploaded successfully');
      } else {
        print('Failed to upload data: ${response.statusCode}');
        throw Exception('Failed to upload data');
      }
    } catch (e) {
      print('Upload exception: $e');
      throw Exception('Failed to upload data');
    }
  }




}
