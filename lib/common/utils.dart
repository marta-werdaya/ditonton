import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class CheckCertificate {
  static CheckCertificate? _checkCertificate;

  CheckCertificate._instance() {
    _checkCertificate = this;
  }

  factory CheckCertificate() =>
      _checkCertificate ?? CheckCertificate._instance();

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/certificate.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    return securityContext;
  }

  Future<IOClient> getIoClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (cert, host, port) => false;

    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}
