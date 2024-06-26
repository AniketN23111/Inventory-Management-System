import 'package:flutter/material.dart';
import 'package:image_store/ChooseDeviceCamera/choosecamerapage.dart';

class DevicePage extends StatelessWidget {
  final List<List<dynamic>> userData;

  const DevicePage(this.userData, {super.key});

  @override
  Widget build(BuildContext context) {
    String username = userData[0][0];
    String password = userData[0][1];
    String organizationName = userData[0][2];
    String brandName = userData[0][9];
    List<String> devices = [];

    for (int i = 0; i < userData.length; i++) {
      if (userData[i][0] == username &&
          userData[i][1] == password &&
          userData[i][13] == true) { // Check if the device is active
        devices.add('${userData[i][10]} - ${userData[i][11]}');
      }
    }
    devices.sort();
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                'Devices',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Color(0xFF1089D3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Organization Name: $organizationName',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Brand Name: $brandName',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Devices for $username:',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(devices[index]),
                    onTap: () {
                      // Navigate to ChooseCameraPage when a device is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseCameraPage(
                            userData: userData,
                            username: username,
                            brandName: brandName,
                            selectedDevice: devices[index].split(' - ')[0], // Pass the selected device
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
