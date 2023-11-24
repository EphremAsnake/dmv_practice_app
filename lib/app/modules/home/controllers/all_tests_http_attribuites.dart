import 'package:drivingexam/app/core/http_client/htttp_attrib_options.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';

class AllTestsHttpAttributes extends HttpClientAttributeOptions {
  AllTestsHttpAttributes()
      : super(
          baseUrl: Keys.baseurl,
          url: "/tests_urls/all_tests.json",
          connectionTimeout: 30,
          contentType: 'application/json',
          method: HttpMethod.GET,
          retries: 3,
          isAuthorizationRequired: false,
        );
}