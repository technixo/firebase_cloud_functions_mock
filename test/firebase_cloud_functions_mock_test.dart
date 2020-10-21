import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_cloud_functions_mock/firebase_cloud_functions_mock.dart';

void main() {
  final cloudFunctionsMock = MockCloudFunctions();
  test('call cloud function without parameters', () async {
    cloudFunctionsMock.mockResult(functionName: 'helloWorld', json: '{"isValid": true}');
    final result = await cloudFunctionsMock.getHttpsCallable(functionName: 'helloWorld').call();
    expect(result.data['isValid'], equals(true));
  });
  test('call cloud function with parameters', () async {
    cloudFunctionsMock.mockResult(functionName: 'helloWorld', json: '{"type": "Type1"}', parameters: <String, dynamic>{
      'type': 'Type1'
    });
    cloudFunctionsMock.mockResult(functionName: 'helloWorld', json: '{"type": "Type2"}', parameters: <String, dynamic>{
      'type': 'Type2'
    });

    final resultType1 = await cloudFunctionsMock.getHttpsCallable(functionName: 'helloWorld').call(<String, dynamic>{
      'type': 'Type1'
    });
    expect(resultType1.data['type'], equals('Type1'));

    final resultType2 = await cloudFunctionsMock.getHttpsCallable(functionName: 'helloWorld').call(<String, dynamic>{
      'type': 'Type2'
    });
    expect(resultType2.data['type'], equals('Type2'));

  });
}
