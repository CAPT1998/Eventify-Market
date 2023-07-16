import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../ConstantModels/ProfileModel.dart';

class ProfileProvider with ChangeNotifier {
  late ProfileModel _profile;

  ProfileModel get profile => _profile;

  Future<void> fetchProfile() async {
    try {
      // Make an API call to fetch the profile data
      final response = await http.get(Uri.parse('https://example.com/profile'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(response.body);

        // Create a ProfileModel instance from the JSON data
        final profile = ProfileModel.fromJson(jsonData);

        // Update the profile and notify listeners
        _profile = profile;
        notifyListeners();
      } else {
        throw Exception('Failed to fetch profile data');
      }
    } catch (error) {
      throw Exception('An error occurred while fetching profile data: $error');
    }
  }
}
