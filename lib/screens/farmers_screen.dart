import 'dart:convert';

import 'package:btr_gov/data/ApiClient.dart';
import 'package:btr_gov/model/Farmarlist.dart';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:btr_gov/screens/add_farmer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FarmersScreen extends StatefulWidget {
  const FarmersScreen({super.key});

  @override
  _FarmerScreenState createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmersScreen> {
  String? _selectedDistrict = 'All';
  String? _selectedBlock = 'All';
  String? _selectedVCDC = 'All';
  String? _selectedRevenueVillage = 'All';
  String? _selectedOccupations = 'All';

  final List<String> _districts = [
    'All',
    'District 1',
    'District 2',
    'District 3'
  ];
  final List<String> _blocks = ['All', 'Block 1', 'Block 2', 'Block 3'];
  final List<String> _vcdcs = ['All', 'VCDC 1', 'VCDC 2', 'VCDC 3'];
  final List<String> _revenueVillages = [
    'All',
    'Village 1',
    'Village 2',
    'Village 3'
  ];
  final List<String> _occupations = [
    'All',
    'Farmer',
    'Service',
    'Business',
    'Other'
  ];
  Farmarlist? _Allfarmar;
  bool loadlist = true;
  var paramdic = {"": ""};

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() {
    ApiClient().getData(Utils.lists, true, paramdic).then((onValue) {
      if (onValue.statusCode == 200) {
        var data = json.decode(onValue.body);
        _Allfarmar = Farmarlist.fromJson(data["data"]);
        print(data["data"]);
        loadlist = false;
      } else {
        loadlist = false;
      }
      setState(() {});
    });
  }

  apiCall(id) {
    ApiClient().deleteData(Utils.deleteDetail + id, true).then((onValue) {
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
          getdata();

        });
        print(data["data"]);
        loadlist = false;
      } else {
        var data = json.decode(onValue.body);

        loadlist = false;
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
        // appBar: AppBar(title: const Text('Add Farmer'),),
        backgroundColor:
            Colors.white, // Set the background color of the Scaffold
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SuperAdministrator',
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
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  _buildDropdown(
                                      'District', _selectedDistrict, _districts,
                                      (String? newValue) {
                                    setState(() {
                                      _selectedDistrict = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 8),
                                  _buildDropdown(
                                      'Block', _selectedBlock, _blocks,
                                      (String? newValue) {
                                    setState(() {
                                      _selectedBlock = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 8),
                                  _buildDropdown('VCDC', _selectedVCDC, _vcdcs,
                                      (String? newValue) {
                                    setState(() {
                                      _selectedVCDC = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 8),
                                  _buildDropdown(
                                      'Revenue Village',
                                      _selectedRevenueVillage,
                                      _revenueVillages, (String? newValue) {
                                    setState(() {
                                      _selectedRevenueVillage = newValue;
                                    });
                                  }),
                                  const SizedBox(height: 8),
                                  _buildDropdown(
                                      'Education',
                                      _selectedRevenueVillage,
                                      _revenueVillages, (String? newValue) {
                                    setState(() {
                                      _selectedRevenueVillage = newValue;
                                    });
                                  }),
                                ]))),

                    SizedBox(height: 36),

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
                                  // const SizedBox(height: 24),
                                  // const Center(
                                  //   child: Text(
                                  //     'Go to Farmer Assets',
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Occupations',
                                      _selectedOccupations,
                                      _occupations, (String? newValue) {
                                    setState(() {
                                      _selectedOccupations = newValue;
                                    });
                                  }),

                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          paramdic["occupation_id"] = "1";
                                          loadlist = true;
                                          setState(() {});
                                          getdata();
                                          print('Button Pressed');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.indigo[400],
                                          // Text color
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 8.0),
                                          // px-5 py-2
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                6.0), // Border radius similar to rounded-md
                                          ),
                                          textStyle: const TextStyle(
                                            fontWeight:
                                                FontWeight.bold, // Font weight
                                            fontSize:
                                                16, // Adjust font size as needed
                                          ),
                                        ).copyWith(),
                                        child: const Text('Filter'),
                                      ),
                                    ],
                                  ),
                                  //const SizedBox(height: 16),
                                ]))),
                    SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'All Farmer List',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    loadlist
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemCount: _Allfarmar!.familyLists.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = _Allfarmar!.familyLists.data[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 6),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey.shade500),
                                ),
                                child: Column(
                                  children: [
                                    _buildDetailRow(
                                        data["full_name"], data["state"]),
                                    Divider(
                                      height: 6.0,
                                      color: Colors.grey.shade300,
                                    ),
                                    _buildDetailRow("Registration No",
                                        data["registration_id"]),
                                    SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildRow("District", data["district"]),
                                        _buildRow("Block", data["block"]),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildRow("VCDC", data["vcdc"]),
                                        _buildRow("Village", data["vill_1"]),
                                      ],
                                    ),
                                    // InkWell(
                                    //     onTap: () {
                                    //       Navigator.of(context)
                                    //           .push(MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             AddFarmerScreen(
                                    //           edit: true,
                                    //           id: data["farmer_uuid"],
                                    //         ),
                                    //       ));
                                    //     },
                                    //     child: Icon(
                                    //       Icons.edit,
                                    //     ))
                                    Row(
                                      children: [
                                        // Edit button
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddFarmerScreen(
                                                  edit: true,
                                                  id: data["uuid"],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                        // Edit text field

                                        // Delete button
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            setState(() {
                                              apiCall(
                                                data["uuid"],
                                              );
                                            });
                                            // Handle delete action here
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })
                    // _buildDetailRow('FIRST NAME:', 'DAIMALI'),
                    // _buildDetailRow('MIDDLE NAME:', 'NA'),
                    // _buildDetailRow('LAST NAME:', 'BASUMATARY'),
                    // _buildDetailRow('DATE OF BIRTH:', '01-01-1975'),
                    // _buildDetailRow('AGE:', '49 Yrs'),
                    // _buildDetailRow('GENDER:', 'Female'),
                    // _buildDetailRow('MOBILE NUMBER:', '8010104961'),
                    // _buildDetailRow('ALT. NUMBER:', 'NA'),
                    // _buildDetailRow('EMAIL:', 'NA'),
                    // _buildDetailRow('FARMER CATEGORY:', 'Farmer'),
                    // _buildDetailRow('CASTE:', 'ST'),
                    // _buildDetailRow('EDUCATION:', 'High School (9-10 class)'),
                    // _buildDetailRow('RELIGION:', 'Other Religion'),
                    // _buildDetailRow('OCCUPATION:', 'Farmer'),
                    // _buildDetailRow('STATUS:', ''),
                    // const SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         const Icon(Icons.person),
                    //         const SizedBox(width: 8),
                    //         const Text('Is Family Head ?'),
                    //         const SizedBox(width: 8),
                    //         ElevatedButton(
                    //           onPressed: () {},
                    //           style: ElevatedButton.styleFrom(
                    //             backgroundColor: Colors.green,
                    //           ),
                    //           child: const Text('Yes'),
                    //         ),
                    //       ],
                    //     ),
                    //     // ElevatedButton(
                    //     //   onPressed: () {},
                    //     //   child: const Text('View family members'),
                    //     // ),
                    //
                    //   ],
                    // ),
                  ])),
        ));
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

  Widget _buildDropdown(String label, String? selectedValue, List<String> items,
      ValueChanged<String?> onChanged) {
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
          width: double
              .infinity, // Make the container take the full width of its parent
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded:
                  true, // Make the dropdown take the full width of its container
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
}
