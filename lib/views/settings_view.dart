import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronController;

  static const String _addressKey = 'customer_address';
  static const String _emailKey = 'customer_email';
  static const String _patronNumberKey = 'customer_patron_number';
  static const String _receiveNewsKey = 'customer_receive_news';

  static const String _defaultAddress =
      'Buckingham Building,\nLion Terrace,\nPortsmouth\nPO1 3HE';
  static const String _defaultEmail = 'alex@example.com';
  static const String _defaultPatronNumber = '1234';

  bool _receiveNews = true;
  bool _isLoading = true;
  String _confirmationMessage = '';
  UserSettings? _savedSettings;

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController(
      text: _defaultAddress,
    );

    _emailController = TextEditingController(
      text: _defaultEmail,
    );

    _patronController = TextEditingController(
      text: _defaultPatronNumber,
    );

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final address =
          await _preferences.getString(_addressKey);
      final email =
          await _preferences.getString(_emailKey);
      final patronNumber =
          await _preferences.getString(_patronNumberKey);
      final receiveNews =
          await _preferences.getBool(_receiveNewsKey);

      if (!mounted) return;

      setState(() {
        _addressController.text = address ?? _defaultAddress;
        _emailController.text = email ?? _defaultEmail;
        _patronController.text =
            patronNumber ?? _defaultPatronNumber;
        _receiveNews = receiveNews ?? true;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _confirmationMessage = 'Unable to load saved settings';
      });
    }
  }

  Future<void> _saveSettings() async {
    final settings = UserSettings(
      address: _addressController.text.trim(),
      email: _emailController.text.trim(),
      patronNumber: _patronController.text.trim(),
      receiveNews: _receiveNews,
    );

    try {
      await _preferences.setString(
        _addressKey,
        settings.address,
      );

      await _preferences.setString(
        _emailKey,
        settings.email,
      );

      await _preferences.setString(
        _patronNumberKey,
        settings.patronNumber,
      );

      await _preferences.setBool(
        _receiveNewsKey,
        settings.receiveNews,
      );

      if (!mounted) return;

      setState(() {
        _savedSettings = settings;
        _confirmationMessage = 'Settings saved successfully';
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _confirmationMessage = 'Unable to save settings';
      });
    }
  }

  void _cancelChanges() {
    final settings = _savedSettings;

    setState(() {
      _addressController.text =
          settings?.address ?? _defaultAddress;
      _emailController.text =
          settings?.email ?? _defaultEmail;
      _patronController.text =
          settings?.patronNumber ?? _defaultPatronNumber;
      _receiveNews = settings?.receiveNews ?? true;
      _confirmationMessage = '';
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _patronController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: cinemaSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: cinemaFontMuted),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: cinemaFontMuted),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: cinemaBrand, width: 2),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: cinemaFontMuted,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Settings'),
      ),
      drawer: const NavDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Settings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: cinemaFontWhite,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _buildLabel('Address'),
                  TextField(
                    controller: _addressController,
                    maxLines: 4,
                    decoration: _fieldDecoration().copyWith(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _addressController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildLabel('Email Address'),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _fieldDecoration(),
                  ),
                  const SizedBox(height: 24),
                  _buildLabel('Patron Number'),
                  TextField(
                    controller: _patronController,
                    keyboardType: TextInputType.number,
                    decoration: _fieldDecoration(),
                  ),
                  const SizedBox(height: 24),
                  _buildLabel('Preferences'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Receive news by email'),
                      Switch(
                        value: _receiveNews,
                        activeTrackColor: cinemaBrand,
                        onChanged: (value) {
                          setState(() {
                            _receiveNews = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _cancelChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cinemaSurface,
                            foregroundColor: cinemaFontWhite,
                            minimumSize:
                                const Size(double.infinity, 45),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text('CANCEL'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: PrimaryButton(
                          label: 'SAVE SETTINGS',
                          onPressed: _saveSettings,
                        ),
                      ),
                    ],
                  ),
                  if (_confirmationMessage.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      _confirmationMessage,
                      style: const TextStyle(
                        color: cinemaBrand,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}