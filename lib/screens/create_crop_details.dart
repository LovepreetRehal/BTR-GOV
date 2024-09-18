


//CreateCropDetails


import 'package:btr_gov/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateCropDetails extends StatefulWidget {

  CreateCropDetails();

  @override
  _CreateCropDetailsScreen createState() => _CreateCropDetailsScreen();
}

class _CreateCropDetailsScreen extends State<CreateCropDetails> {

  final List<String>  _cropType = ['Pulses','Oil seeds', 'Vegetable','Fruits','Spices', 'Plantation' ,'Medicinal Plants','Cereals'];
  final List<String>  _cropName = ['Lentil'];
  final List<String>  _seasonName = ['Summer','Winter','Autumn'];
  final List<String> _seasonalPerineal = ['Perennail (Plantation)','Biennial(Once in 2 years)','Annual (Once in a year)'];
  String? _selectedCropType = '--selected--'; // Set initial value to match the list
  String? _selectedSeasonName = '--selected--'; // Set initial value to match the list
  String? _selectedCropName = '--selected--'; // Set initial value to match the list
  String? _selectedSeasonalPerineal = '--selected--'; // Set initial value to match the list

  String? _varietyName = '';
  String? _landAreaUsesLevel = '';
  String? _numberplantation = '';
  String? _phLevel = '';
  String? _carbonLevel = '';
  String? _zincLevel = '';
  String? _sulphurLevel = '';
  String? _boronLevel = '';
  String? _selectedDate = ''; // State variable for storing the selected date

  final TextEditingController _varietyNameController = TextEditingController();
  final TextEditingController _landAreaUsesController = TextEditingController();
  final TextEditingController _numberplantationController = TextEditingController();
  final TextEditingController _phLevelController = TextEditingController();
  final TextEditingController _carbonController = TextEditingController();
  final TextEditingController _zincLevelController = TextEditingController();
  final TextEditingController _sulphurLevelController = TextEditingController();
  final TextEditingController _boronLevelController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Farmer Detail')),
        backgroundColor: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  _buildDropdown(
                                      'Crop Type ✫:', _selectedCropType, _cropType,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedCropType = newValue;
                                        });
                                      }),

                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Crop name✫:', _selectedCropName, _cropName,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedCropName = newValue;
                                        });
                                      }),


                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Variety Name :',
                                    'Enter Variety Name :',
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
                                      'Season Name :', _selectedSeasonName, _seasonName,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedSeasonName = newValue;
                                        });
                                      }),
                                  const SizedBox(height: 16),
                                  _buildDropdown(
                                      'Seasonal Perineal :`', _selectedSeasonalPerineal ,_seasonalPerineal ,
                                          (String? newValue) {
                                        setState(() {
                                          _selectedSeasonName = newValue;
                                        });
                                      }),

                                ]))),
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
                                    'Cultivated Crop Quantity (In KG) (Optional) :',
                                    'Enter Variety Name :',
                                    _varietyNameController,
                                        (value) {
                                      _varietyName = value;

                                      // Handle the changed text
                                      print('varietyNameController changed: $value');
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    'Number of plantation (Optional) : :',
                                    'Enter Number of plantation :',
                                    _numberplantationController,
                                        (value) {
                                      // Handle the changed text
                                          _numberplantation = value;
                                      print('Land area changed: $value');
                                    },isPhone: true
                                  ),

                                ]))),

                    _buildSectionTitle(context,'Save')

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


  Widget _buildSectionTitle(BuildContext context, String title) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
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



