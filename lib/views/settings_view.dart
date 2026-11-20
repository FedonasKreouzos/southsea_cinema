import 'package:flutter/material.dart';
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
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronController;

  bool _receiveNews = true;
  String _confirmationMessage = '';
  UserSettings? _savedSettings;

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController(
      text: 'Buckingham Building,\nLion Terrace,\nPortsmouth\nPO1 3HE',
    );

    _emailController = TextEditingController(
      text: 'alex@example.com',
    );

    _patronController = TextEditingController(
      text: '1234',
    );
  }

  void _cancelChanges() {
    setState(() {
      _addressController.text =
          'Buckingham Building,\nLion Terrace,\nPortsmouth\nPO1 3HE';
      _emailController.text = 'alex@example.com';
      _patronController.text = '1234';
      _receiveNews = true;
      _confirmationMessage = '';
      _savedSettings = null;
    });
  }

  void _saveSettings() {
    final settings = UserSettings(
      address: _addressController.text.trim(),
      email: _emailController.text.trim(),
      patronNumber: _patronController.text.trim(),
      receiveNews: _receiveNews,
    );

    setState(() {
      _savedSettings = settings;
      _confirmationMessage = 'Settings saved successfully';
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
      body: SingleChildScrollView(
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
                      minimumSize: const Size(double.infinity, 45),
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
            if (_savedSettings != null &&
                _confirmationMessage.isNotEmpty) ...[
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