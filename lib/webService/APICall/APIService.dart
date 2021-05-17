import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teamup/module/AddAccomplishmentModel.dart';
import 'package:teamup/module/AddEducationModel.dart';
import 'package:teamup/module/AddExperienceModel.dart';
import 'package:teamup/module/AddFounderModel.dart';
import 'package:teamup/module/AddHackathonModel.dart';
import 'package:teamup/module/AddMemberModel.dart';
import 'package:teamup/module/AllAccomplishmentModel.dart';
import 'package:teamup/module/AllEducationModel.dart';
import 'package:teamup/module/AllEventListModel.dart';
import 'package:teamup/module/AllExperienceModel.dart';
import 'package:teamup/module/AllFoundersModel.dart';
import 'package:teamup/module/AllHackathonModel.dart';
import 'package:teamup/module/AllMemberListModel.dart';
import 'package:teamup/module/ApproveProjectModel.dart';
import 'package:teamup/module/ChangePersonalDetailsModel.dart';
import 'package:teamup/module/CityModel.dart';
import 'package:teamup/module/CloseAccountModel.dart';
import 'package:teamup/module/CollegeModel.dart';
import 'package:teamup/module/CountryModel.dart';
import 'package:teamup/module/CreateTeamModel.dart';
import 'package:teamup/module/EventDetailsModel.dart';
import 'package:teamup/module/FAQModel.dart';
import 'package:teamup/module/FeedbackModel.dart';
import 'package:teamup/module/ForgetPasswordModel.dart';
import 'package:teamup/module/FounderDetailsModel.dart';
import 'package:teamup/module/GenerateCertificateModel.dart';
import 'package:teamup/module/GetAccomplishmentDetailModel.dart';
import 'package:teamup/module/GetEducationalDetailsModel.dart';
import 'package:teamup/module/GetExperienceDetailModel.dart';
import 'package:teamup/module/GetFeedbackModel.dart';
import 'package:teamup/module/GetHackathonDetailsModel.dart';
import 'package:teamup/module/GetPersonDetailsModel.dart';
import 'package:teamup/module/GetProjectDetailsModel.dart';
import 'package:teamup/module/HackathonProblemStatementDetailsModel.dart';
import 'package:teamup/module/HackathonTeamDetailsModel.dart';
import 'package:teamup/module/HackathonTeamListModel.dart';
import 'package:teamup/module/LeaveProjectModel.dart';
import 'package:teamup/module/LegelsModel.dart';
import 'package:teamup/module/LoginRequestModel.dart';
import 'package:teamup/module/MyHackathonListModel.dart';
import 'package:teamup/module/MyNetworkModel.dart';
import 'package:teamup/module/MyProjectDetailsModel.dart';
import 'package:teamup/module/MyProjectListModel.dart';
import 'package:teamup/module/OAddProjectModel.dart';
import 'package:teamup/module/OnGoingProjectModel.dart';
import 'package:teamup/module/OrganizationChangeLogoModel.dart';
import 'package:teamup/module/OrganizationProfileModel.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelFirst.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelSecond.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelThird.dart';
import 'package:teamup/module/OrganizationTypeModel.dart';
import 'package:teamup/module/PersonAboutMeModel.dart';
import 'package:teamup/module/PersonProfileDetailsModel.dart';
import 'package:teamup/module/PostAdModel.dart';
import 'package:teamup/module/PostEventModel.dart';
import 'package:teamup/module/RejectProjectModel.dart';
import 'package:teamup/module/SAddProjectModel.dart';
import 'package:teamup/module/SFieldTypeModel.dart';
import 'package:teamup/module/SProjectLevelModel.dart';
import 'package:teamup/module/SignUpRequestModel.dart';
import 'package:teamup/module/SignUpRequestModelSecond.dart';
import 'package:teamup/module/SignUpRequestThird.dart';
import 'package:teamup/module/SignUpResponseModel.dart';
import 'package:teamup/module/StateModel.dart';
import 'package:teamup/module/SubmitProjectModel.dart';
import 'package:teamup/module/TypeOfPeopleModel.dart';
import 'package:teamup/module/TypeOfProjectModel.dart';
import 'package:teamup/module/UpdateAccomplishmentModel.dart';
import 'package:teamup/module/UpdateEducationModel.dart';
import 'package:teamup/module/UpdateExperienceModel.dart';
import 'package:teamup/module/UpdateFounderDetailsModel.dart';
import 'package:teamup/module/UpdateOurWorkModel.dart';
import 'package:teamup/module/UpdatePasswordModel.dart';
import 'package:teamup/module/UpdatePersonDetailsModel.dart';
import 'package:teamup/screen/AllAccomplishment.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class APICall implements Repos {
  String baseUrl = "https://teamup.sdaemon.com/api/";

  @override
  Future<SignUpFirstResponseModel> signUp(SignUpFirstRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: signUpFirstRequestModelToJson(SignUpFirstRequestModel), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      final newResponse = json.decode(response.body);
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      return signUpFirstResponseModelFromJson(response.body.toString());
    });
  }

  // Login API Call
  @override
  Future<LoginResponseModel> login(LoginRequestModel, url) {
    LoginResponseModel loginResponseModel = new LoginResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: LoginRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      return loginResponseModel =
          loginResponseModelFromJson(response.body.toString());
    });
  }

  // Student Registration API's
  @override
  Future<SignUpFirstResponseModel> stdSignUpFirstStep(SignUpFirstRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: signUpFirstRequestModelToJson(SignUpFirstRequestModel), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      return signUpFirstResponseModelFromJson(response.body.toString());
    });
  }
  @override
  Future<SignUpThirdResponseModel> stdSignUpThirdStep(SignUpRequestThird, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: SignUpRequestThird.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      final Res = json.decode(response.body);
      return SignUpThirdResponseModel(
          Message: Res['Message'], Status: Res['Status']);
    });
  }

// Organization Registration API's

  @override
  Future<List<OrganizationTypeModel>> organizationType(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      final orgResponse = json.decode(response.body);
      final List OrganizationResponse = orgResponse['OrganizationType'];
      return OrganizationResponse.map(
          (e) => new OrganizationTypeModel.fromMap(e)).toList();
    });
  }

  @override
  Future<OrgSignUpFirstResponseModel> orgSignUpFirstStep(orgSignUpFirst, url) {
    String newUrl = baseUrl + url;
   Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: orgSignUpFirstToJson(orgSignUpFirst), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      return orgSignUpFirstResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<orgSignUpSecondResponseModel> orgSignUpSecondStep(
      orgSignUpSecond, url) {
    String newUrl = baseUrl + url;

    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: orgSignUpSecond.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      final Res = json.decode(response.body);
      return orgSignUpSecondResponseModel(
          Id: Res['Id'], Message: Res['Message'], Status: Res['Status']);
    });
  }

  @override
  Future<orgSignUpThirdResponseModel> orgSignUpThirdStep(orgSignUpThird, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: orgSignUpThirdToJson(orgSignUpThird), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      final Res = json.decode(response.body);
      return orgSignUpThirdResponseModel(
          Message: Res['Message'], Status: Res['Status']);
    });
  }

  @override
  Future<EventNdAdsModel> getAllEventList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return eventNdAdsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<EventDetailsModel> getEventDetails(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return eventDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<PostEventResponseModel> postEvents(PostEventRequestModel, url) {
    PostEventResponseModel responseModel = new PostEventResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: PostEventRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      return responseModel =
          postEventResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<PostAdResponseModel> postAds(PostAdRequestModel, url) {
    PostAdResponseModel responseModel = new PostAdResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: PostAdRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      return responseModel =
          postAdResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<FeedbackResponseModel> submitFeedback(FeedbackRequestModel, url) {
    FeedbackResponseModel feedbackResponseModel = new FeedbackResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: FeedbackRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final String JsonBody = response.body;
      final StatusCode = response.statusCode;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To upload Data..');
      }
      return feedbackResponseModel =
          feedbackResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetFeedbackResponseModel> getFeedback(GetFeedbackRequestModel, url) {
    GetFeedbackResponseModel getFeedbackResponseModel =
        new GetFeedbackResponseModel();
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: GetFeedbackRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return getFeedbackResponseModel =
          getFeedbackResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<TypeOfProjectModel> getProjectTypeList(url) {
    String newUrl = baseUrl + url;

    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;

      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return typeOfProjectModelFromJson(response.body.toString());
    });
  }

  @override
  Future<TypeOfPeopleModel> getPeopleTypeList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return typeOfPeopleModelFromJson(response.body.toString());
    });
  }

  @override
  Future<SProjectLevelModel> getLevelList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return sProjectLevelModelFromJson(response.body.toString());
    });
  }

  @override
  Future<SFieldTypeModel> getFieldList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return sFieldTypeModelFromJson(response.body.toString());
    });
  }

  @override
  Future<SAddProjectResponseModel> addSProject(SAddProjectRequestModel, url) {
    SAddProjectResponseModel sAddProjectResponseModel =
        new SAddProjectResponseModel();
    String newUrl = baseUrl + url;

    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl, body: SAddProjectRequestModel.toJson(), headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;

      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return sAddProjectResponseModel =
          sAddProjectResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<OAddProjectResponseModel> addOProject(OAddProjectRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: oAddProjectRequestModelToJson(OAddProjectRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return oAddProjectResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<OnGoingProjectModel> getOnGoingProject(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return onGoingProjectModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AllMemberListModel> getMemberList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return memberListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddMemberResponseModel> addMember(AddMemberRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: addMemberRequestModelToJson(AddMemberRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return addMemberResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetProjectDetailsModel> getProjectDetails(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return getProjectDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<MyNetworkModel> getMyNetworkList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return myNetworkModelFromJson(response.body.toString());
    });
  }

  @override
  Future<CloseAccountResponseModel> closeAccount(
      CloseAccountRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: closeAccountRequestModelToJson(CloseAccountRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return closeAccountResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<LegelsModel> getLegals(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return legelsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ChangeResponseModel> updateName(ChangeNameRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: changeNameRequestModelToJson(ChangeNameRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return changeResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ChangeResponseModel> updateEmail(ChangeEmailIdRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: changeEmailIdRequestModelToJson(ChangeEmailIdRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return changeResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ChangeResponseModel> updatePassword(ChangePasswordRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: changePasswordRequestModelToJson(ChangePasswordRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return changeResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<FaqModel> getFAQList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return faqModelFromJson(response.body.toString());
    });
  }

  @override
  Future<CityModel> getCityList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return cityModelFromJson(response.body.toString());
    });
  }

  @override
  Future<StateModel> getStateList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return stateModelFromJson(response.body.toString());
    });
  }

  @override
  Future<CountryModel> getCountryList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return countryModelFromJson(response.body.toString());
    });
  }

  @override
  Future<PersonAboutMeResponseModel> updateAboutMe(
      PersonAboutMeRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: personAboutMeModelToJson(PersonAboutMeRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return personAboutMeResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddEducationResponseModel> addEducation(
      AddEducationRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: addEducationRequestModelToJson(AddEducationRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return addEducationResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddExperienceResponseModel> addExperience(
      AddExperienceRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: addExperienceRequestModelToJson(AddExperienceRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return addExperienceResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddAccomplishmentResponseModel> addAccomplishment(
      AddAccomplishmentRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: addAccomplishmentRequestModelToJson(
                AddAccomplishmentRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return addAccomplishmentResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AllEducationModel> getAllEducation(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return allEducationModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AllAccomplishmentModel> getAllAccomplishment(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return allAccomplishmentModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AllExperienceModel> getAllExperience(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return allExperienceModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetEducationDetailModel> getEducationDetail(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return getEducationDetailModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetExperienceDetailModel> getExperienceDetail(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return getExperienceDetailModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetAccomplishmentDetailModel> getAccomplishementDetail(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return getAccomplishmentDetailModelFromJson(response.body.toString());
    });
  }

  @override
  Future<UpdateAccomplishmentResponseModel> updateAccomplishment(
      UpdateAccomplishmentModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: updateAccomplishmentModelToJson(UpdateAccomplishmentModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return updateAccomplishmentResponseModelFromJson(
          response.body.toString());
    });
  }

  @override
  Future<UpdateExperienceResponseModel> updateExperience(
      UpdateExperienceModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: updateExperienceModelToJson(UpdateExperienceModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return updateExperienceResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<UpdateEducationResponseModel> updateEducation(
      UpdateEducationModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: updateEducationModelToJson(UpdateEducationModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return updateEducationResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<PersonProfileDetailsModel> getPersonProfile(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return personProfileDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetPersonDetailsModel> getPersonDetails(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return getPersonDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<UpdatePersonDetailsResponseModel> updatePersonDetails(
      UpdatePersonDetailsModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: updatePersonDetailsModelToJson(UpdatePersonDetailsModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return updatePersonDetailsResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ForgetPasswordResponseModel> forgetPassword(
      ForgetPasswordRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: forgetPasswordRequestModelToJson(ForgetPasswordRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return forgetPasswordResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<UpdatePasswordResponseModel> updateNewPassword(
      UpdatePasswordRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: updatePasswordRequestModelToJson(UpdatePasswordRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return updatePasswordResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddFounderResponseModel> addFounder(AddFounderRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: addFounderRequestModelToJson(AddFounderRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return addFounderResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AllFoundersModel> getAllFoundersList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return allFoundersModelFromJson(response.body.toString());
    });
  }

  @override
  Future<FounderDetailsModel> getFounderDetails(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return founderDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<UpdateOurWorkResponseModel> updateOurWork(
      UpdateOurWorkRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: updateOurWorkRequestModelToJson(UpdateOurWorkRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return updateOurWorkResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<UpdateFounderDetailsResponseModel> updateFounderDetails(
      UpdateFounderDetailsRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};

    return http
        .put(newUrl,
            body: updateFounderDetailsRequestModelToJson(
                UpdateFounderDetailsRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return updateFounderDetailsResponseModelFromJson(
          response.body.toString());
    });
  }

  @override
  Future<OrganizationProfileModel> getOrganizationProfile(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return organizationProfileModelFromJson(response.body.toString());
    });
  }

  @override
  Future<OrganizationChangeLogoResponseModel> orgChangeLogo(
      OrganizationChangeLogoRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: organizationChangeLogoRequestModelToJson(
                OrganizationChangeLogoRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;

      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return organizationChangeLogoResponseModelFromJson(
          response.body.toString());
    });
  }

  @override
  Future<AllHackathonModel> getAllHackathon(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return allHackathonModelFromJson(response.body.toString());
    });
  }

  @override
  Future<GetHackathonDetailsModel> getHackathonDetails(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return getHackathonDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<AddHackathonResponseModel> newAddHackathon(
      AddHackathonRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: addHackathonRequestModelToJson(AddHackathonRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return addHackathonResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<HackathonProblemStatementDetailsModel> getHackathonProblemDetails(
      url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return hackathonProblemStatementDetailsModelFromJson(
          response.body.toString());
    });
  }

  @override
  Future<HackathonTeamDetailsModel> getHackathonTeamDetails(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return hackathonTeamDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<HackathonTeamListModel> getHackathonTeamList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return hackathonTeamListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<CreateTeamResponseModel> createTeam(CreateTeamRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .post(newUrl,
            body: createTeamRequestModelToJson(CreateTeamRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return createTeamResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<LeaveProjectResponseModel> leaveProject(
      LeaveProjectRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: leaveProjectRequestModelToJson(LeaveProjectRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return leaveProjectResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<SubmitProjectResponseModel> submitProject(
      SubmitProjectRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: submitProjectRequestModelToJson(SubmitProjectRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return submitProjectResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<MyHackathonListModel> getMyHackathons(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      print(response.body.toString());
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return myHackathonListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<MyProjectListModel> getMyProjectList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return myProjectListModelFromJson(response.body.toString());
    });
  }

  @override
  Future<MyProjectDetailsModel> getMyProjectDetails(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return myProjectDetailsModelFromJson(response.body.toString());
    });
  }

  @override
  Future<ApproveProjectResponseModel> approveProject(
      ApproveProjectRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: approveProjectRequestModelToJson(ApproveProjectRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return approveProjectResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<RejectProjectResponseModel> rejectProject(
      RejectProjectRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
            body: rejectProjectRequestModelToJson(RejectProjectRequestModel),
            headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return rejectProjectResponseModelFromJson(response.body.toString());
    });
  }

  @override
  Future<CollegeModel> getCollegeList(url) {
    String newUrl = baseUrl + url;
    return http.get(newUrl).then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return collegeModelFromJson(response.body.toString());
    });
  }
  @override
  Future<GenerateCertificateResponseModel> certificateGenerate(
      GenerateCertificateRequestModel, url) {
    String newUrl = baseUrl + url;
    Map<String, String> header = {"Content-Type": "application/json"};
    return http
        .put(newUrl,
        body: generateCertificateRequestModelToJson(GenerateCertificateRequestModel),
        headers: header)
        .then((http.Response response) {
      final StatusCode = response.statusCode;
      final String JsonBody = response.body;
      if (StatusCode < 200 || StatusCode > 300 || JsonBody == null) {
        throw Exception('Failed To load Data..');
      }
      return generateCertificateResponseModelFromJson(response.body.toString());
    });
  }
}
