import 'package:drivingexam/app/core/http_client/htttp_attrib_options.dart';
import 'package:drivingexam/app/utils/keys/keys.dart';

class StudySignsHttpAttributes extends HttpClientAttributeOptions {
  StudySignsHttpAttributes()
      : super(
          baseUrl: Keys.baseurl,
          url: "/signs_study/signs_study.json",
          connectionTimeout: 30,
          contentType: 'application/json',
          method: HttpMethod.GET,
          retries: 3,
          isAuthorizationRequired: false,
        );
}
