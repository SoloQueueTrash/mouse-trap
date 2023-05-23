import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Trap {
  String name;
  String ip;
  int port;

  Trap({required this.name, required this.ip, required this.port});

  factory Trap.fromJson(Map<String, dynamic> json) {
    return Trap(
      name: json['name'],
      ip: json['ip'],
      port: json['port'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'ip': ip,
        'port': port,
      };

  Future<TrapStatus> getStatus() async {
    var url = Uri.http('$ip:$port', '/status');
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return TrapStatus.unknown;
    }
    var json = jsonDecode(response.body);
    return TrapStatusExtension.fromString(json['status']);
  }

  Future<TrapStatus> open() async {
    var url = Uri.http('$ip:$port', '/open');
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return TrapStatus.unknown;
    }
    var json = jsonDecode(response.body);
    return TrapStatusExtension.fromString(json['status']);
  }

  Future<TrapStatus> close() async {
    var url = Uri.http('$ip:$port', '/close');
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return TrapStatus.unknown;
    }
    var json = jsonDecode(response.body);
    return TrapStatusExtension.fromString(json['status']);
  }

  Future<bool> takePicture() async {
    var url = Uri.http('$ip:$port', '/take_picture');
    var response = await http.get(url);
    return response.statusCode == 200;
  }

  Future<String?> getPicture() async {
    var url = Uri.http('$ip:$port', '/get_picture');
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return null;
    }
    var json = jsonDecode(response.body);
    return json['path'];
  }
}

enum TrapStatus {
  open,
  closed,
  error,
  unknown,
}

extension TrapStatusExtension on TrapStatus {
  static TrapStatus fromString(String status) {
    switch (status) {
      case 'open':
        return TrapStatus.open;
      case 'closed':
        return TrapStatus.closed;
      case 'error':
        return TrapStatus.error;
      default:
        return TrapStatus.unknown;
    }
  }

  String get name {
    switch (this) {
      case TrapStatus.open:
        return 'Open';
      case TrapStatus.closed:
        return 'Closed';
      case TrapStatus.error:
        return 'Error';
      default:
        return 'Unknown';
    }
  }

  IconData get icon {
    switch (this) {
      case TrapStatus.open:
        return Icons.lock_open;
      case TrapStatus.closed:
        return Icons.lock;
      case TrapStatus.error:
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Color get color {
    switch (this) {
      case TrapStatus.open:
        return Colors.green;
      case TrapStatus.closed:
        return Colors.red;
      case TrapStatus.error:
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
