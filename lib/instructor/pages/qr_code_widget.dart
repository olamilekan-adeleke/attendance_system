import 'package:flutter/material.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget(this.imageLink);

  final String imageLink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Bar Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.network(
          imageLink,
          height: 100,
          width: 100,
          fit: BoxFit.fill,
          errorBuilder: (_, __, ___) => Placeholder(),
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
