library firebase_cloud_functions_mock;

import 'package:cloud_functions/cloud_functions.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';

class MockCloudFunctions extends Mock implements CloudFunctions {
  Map<String, String> _jsonStore = <String, String>{};

  void mockResult({String functionName, String json}){
    _jsonStore[functionName] = json;
  }

  String getMockResult(String functionName){
    assert(_jsonStore[functionName] != null, 'No mock result for ${functionName}');
    return _jsonStore[functionName];
  }

  @override
  HttpsCallable getHttpsCallable({String functionName}) {
    return HttpsCallableMock._(this, functionName);
  }
}

class HttpsCallableMock extends Mock implements HttpsCallable {

  HttpsCallableMock._(this._cloudFunctions, this._functionName);

  final MockCloudFunctions _cloudFunctions;
  final String _functionName;


  @override
  Future<HttpsCallableResult> call([dynamic parameters]) {
    return Future.value(HttpsCallableResultMock._(json.decode(_cloudFunctions.getMockResult(_functionName))));
  }



  /// The timeout to use when calling the function. Defaults to 60 seconds.
  Duration timeout;
}

class HttpsCallableResultMock extends Mock implements HttpsCallableResult{
  HttpsCallableResultMock._(Map<String, dynamic> _data):
        data = _data;

  /// Returns the data that was returned from the Callable HTTPS trigger.
  final dynamic data;
}