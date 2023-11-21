import 'package:drivingexam/app/core/http_client/htttp_attrib_options.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';

class UsStatesHttpAttributes extends HttpClientAttributeOptions {
  UsStatesHttpAttributes()
      : super(
          baseUrl: Keys.baseurl,
          url: "/us_states/us_states.json",
          connectionTimeout: 30,
          contentType: 'application/json',
          method: HttpMethod.GET,
          retries: 3,
          isAuthorizationRequired: false,
        );
}