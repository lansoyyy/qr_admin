import 'package:flutter/material.dart';

class DriverInfoDialog extends StatelessWidget {
  final String profilePicture;
  final String name;
  final String contactNumber;
  final String vehicleModel;
  final String vehicleColor;
  final String vehiclePlateNumber;

  const DriverInfoDialog({
    super.key,
    required this.profilePicture,
    required this.name,
    required this.contactNumber,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.vehiclePlateNumber,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Driver Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profilePicture),
            radius: 50,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(contactNumber),
          const SizedBox(height: 10),
          Text('Vehicle Model: $vehicleModel'),
          const SizedBox(height: 10),
          Text('Vehicle Color: $vehicleColor'),
          const SizedBox(height: 10),
          Text('Vehicle Plate Number: $vehiclePlateNumber'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
