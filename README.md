# firebase_cloud_functions_mock

Dart firebase cloud functioin mock for testing

## Getting Started


# Install
Add to `pubspec.yaml`
```
firebase_cloud_functions_mock:
    git: git@github.com:technixo/firebase_cloud_functions_mock.git

```

-- USE

```
import 'package:firebase_cloud_functions_mock/firebase_cloud_functions_mock.dart';
final mockCloudFunction = new MockCloudFunctions();
mockCloudFunction.mockResult(
  functionName: 'getHelloword',
  json: '''{"helloword": "ok"}'''
);

//in repository
//make sure the CloudFunctions instance is replaced by the mocking one in the testing environment

bool isTest = true;
class HelloRepository{
  CloudFunctions cloudFunc;
  HelloRepository(): isTest ? mockCloudFunction : CloudFunctions(
  )

  HttpsCallableResult result = cloudFunc.getHttpsCallable(functionName: 'getHelloword')
      .call(<String, dynamic>{
  });
  print(result);
  //result should be Map<String, dynamic>{} {"helloword": "ok"}

}
```
