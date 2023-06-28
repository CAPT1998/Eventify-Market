import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'dart:io' show Platform;

class AddressBottomSheetWidget extends StatefulWidget {
  @override
  _AddressBottomSheetWidgetState createState() =>
      _AddressBottomSheetWidgetState();
}

class _AddressBottomSheetWidgetState extends State<AddressBottomSheetWidget> {
  int _selectedAddressIndex = -1;
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSelectedAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Select Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  _clearAddresses();
                  setState(() {
                    _selectedAddressIndex = -1;
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          SizedBox(height: 16),
          FutureBuilder<List<String>>(
            future: _getSavedAddresses(),
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final addresses = snapshot.data ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  //   scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final address = addresses[index];
                    return ListTile(
                      leading: Radio<int>(
                        value: index,
                        groupValue: _selectedAddressIndex,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedAddressIndex = value!;
                          });
                          _selectAddress(address);
                        },
                      ),
                      title: Text(
                        address,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedAddressIndex = index;
                        });
                        _selectAddress(address);
                      },
                    );
                  },
                );
              }
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              addNewAddress();
              // Navigator.pop(context);
            },
            child: Text('Add New Address'),
          ),
        ],
      ),
    );
  }

  Future<void> _loadSelectedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectedAddress = prefs.getString('selectedAddress');
    if (selectedAddress != null) {
      int index = await _getAddressIndex(selectedAddress); // Await the result
      setState(() {
        _selectedAddressIndex = index;
      });
    }
  }

  Future<int> _getAddressIndex(String address) async {
    final addresses = await _getSavedAddresses();
    if (addresses != null) {
      for (int i = 0; i < addresses.length; i++) {
        if (addresses[i] == address) {
          return i;
        }
      }
    }
    return -1; // Address not found
  }

  void _clearAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('addresses');
  }

  void _selectAddress(String selectedAddress) async {
    int index = await _getAddressIndex(selectedAddress);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selectedAddress', selectedAddress); // Save the selected address
    setState(() {
      _selectedAddressIndex = index;
    });
  }

  Future<List<String>> _getSavedAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final addressesJson = prefs.getStringList('addresses');
    if (addressesJson != null) {
      return addressesJson;
    }
    return [];
  }

  void addNewAddress() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: Platform.isAndroid
              ? "AIzaSyB3AJ346V-wawHGxPZaeG5ZMndcXeVLCEU"
              : "AIzaSyB3AJ346V-wawHGxPZaeG5ZMndcXeVLCEU",
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          usePinPointingSearch: true,

          onPlacePicked: (result) async {
            print(result.formattedAddress);
            if (result != null) {
              final newAddress = result.formattedAddress;
              if (newAddress != null) {
                final additionalInfo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddressInputScreen(selectedAddress: newAddress),
                  ),
                );

                if (additionalInfo != null) {
                  final updatedAddress = ' $additionalInfo';

                  final addresses = await _getSavedAddresses();
                  addresses.add(updatedAddress);
                  await _saveAddresses(addresses);
                  setState(() {});
                }
              }
            }
            Navigator.of(context).pop();
          },
          initialPosition: LatLng(0.0, 0.0),
          useCurrentLocation: true,
          usePlaceDetailSearch: true,
          resizeToAvoidBottomInset:
              false, // only works in page mode, less flickery, remove if wrong offsets
        ),
      ),
    );
  }
}

Future<void> _saveAddresses(List<String> addresses) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('addresses', addresses);
}

class AddressInputScreen extends StatefulWidget {
  final String selectedAddress;

  AddressInputScreen({required this.selectedAddress});

  @override
  _AddressInputScreenState createState() => _AddressInputScreenState();
}

class _AddressInputScreenState extends State<AddressInputScreen> {
  late TextEditingController _controller;
  late String updatedAddress;
  late String apartmentOrBuilding;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.selectedAddress);
    updatedAddress = widget.selectedAddress;
    apartmentOrBuilding = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveAddress() {
    final additionalInfo = _controller.text.trim();
    updatedAddress = ' $additionalInfo $apartmentOrBuilding';

    // Perform your address saving logic here

    Navigator.of(context).pop(updatedAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selected Address:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  updatedAddress = value;
                });
              },
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  apartmentOrBuilding = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Apartment or Building',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Save Address'),
              onPressed: _saveAddress,
            ),
          ],
        ),
      ),
    );
  }
}
