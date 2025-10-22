import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/onboarding_theme.dart';

/// Permissions screen matching wireframe exactly
/// Allows user to grant Location, Camera, and Notifications permissions
class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  bool _locationEnabled = false;
  bool _cameraEnabled = false;
  bool _notificationsEnabled = false;

  final List<PermissionItem> _permissions = [
    PermissionItem(
      title: 'Location',
      description: '"Lorem ipsum dolor sit amet, consectetur adipiscing elit"',
      permission: Permission.location,
    ),
    PermissionItem(
      title: 'Camera',
      description: '"Lorem ipsum dolor sit amet, consectetur adipiscing elit"',
      permission: Permission.camera,
    ),
    PermissionItem(
      title: 'Notifications',
      description: '"Lorem ipsum dolor sit amet, consectetur adipiscing elit"',
      permission: Permission.notification,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final locationStatus = await Permission.location.status;
    final cameraStatus = await Permission.camera.status;
    final notificationStatus = await Permission.notification.status;

    setState(() {
      _locationEnabled = locationStatus.isGranted;
      _cameraEnabled = cameraStatus.isGranted;
      _notificationsEnabled = notificationStatus.isGranted;
    });
  }

  Future<void> _requestPermission(Permission permission, int index) async {
    final status = await permission.request();

    setState(() {
      if (index == 0) {
        _locationEnabled = status.isGranted;
      } else if (index == 1) {
        _cameraEnabled = status.isGranted;
      } else if (index == 2) {
        _notificationsEnabled = status.isGranted;
      }
    });
  }

  Future<void> _allowAll() async {
    // Request all permissions
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.notification.request();

    await _checkPermissions();

    // Navigate to next screen (login/register)
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/welcome');
    }
  }

  void _customizePermission() {
    // Just navigate with current permissions
    Navigator.of(context).pushReplacementNamed('/welcome');
  }

  void _skip() {
    // Skip permissions and navigate
    Navigator.of(context).pushReplacementNamed('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OnboardingTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skip button - Top right
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _skip,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    'skip',
                    style: TextStyle(
                      color: OnboardingTheme.skipButtonColor,
                      fontSize: OnboardingTheme.skipFontSize,
                      fontFamily: OnboardingTheme.fontFamily,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Icon placeholder
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: OnboardingTheme.horizontalPadding,
              ),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: OnboardingTheme.iconPlaceholderColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: OnboardingTheme.horizontalPadding,
              ),
              child: Text(
                'Allow access to\npersonalize\nyour experience.',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: OnboardingTheme.titleColor,
                  fontFamily: OnboardingTheme.fontFamily,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Permission items list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: OnboardingTheme.horizontalPadding,
                ),
                itemCount: _permissions.length,
                itemBuilder: (context, index) {
                  final permission = _permissions[index];
                  bool isEnabled = false;

                  if (index == 0) {
                    isEnabled = _locationEnabled;
                  } else if (index == 1) {
                    isEnabled = _cameraEnabled;
                  } else if (index == 2) {
                    isEnabled = _notificationsEnabled;
                  }

                  return _buildPermissionItem(
                    permission.title,
                    permission.description,
                    isEnabled,
                    () => _requestPermission(permission.permission, index),
                  );
                },
              ),
            ),
            // Buttons at bottom
            Padding(
              padding: EdgeInsets.all(OnboardingTheme.horizontalPadding),
              child: Column(
                children: [
                  // Allow All button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _allowAll,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: OnboardingTheme.primaryButtonColor,
                        foregroundColor: OnboardingTheme.primaryButtonTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Allow All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: OnboardingTheme.fontFamily,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Customize Permission button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: TextButton(
                      onPressed: _customizePermission,
                      style: TextButton.styleFrom(
                        foregroundColor: OnboardingTheme.secondaryButtonTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Customize Permission',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: OnboardingTheme.fontFamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionItem(
    String title,
    String description,
    bool isEnabled,
    VoidCallback onToggle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: OnboardingTheme.titleColor,
                  fontFamily: OnboardingTheme.fontFamily,
                ),
              ),
              // Custom switch
              GestureDetector(
                onTap: onToggle,
                child: Container(
                  width: 50,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? OnboardingTheme.switchActiveColor
                        : OnboardingTheme.switchInactiveColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment:
                        isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: OnboardingTheme.bodyFontSize,
              color: OnboardingTheme.descriptionColor,
              fontFamily: OnboardingTheme.fontFamily,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Permission item data model
class PermissionItem {
  final String title;
  final String description;
  final Permission permission;

  PermissionItem({
    required this.title,
    required this.description,
    required this.permission,
  });
}
