import 'package:flutter/material.dart';
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

abstract class Repos {
  Future<SignUpFirstResponseModel> signUp(SignUpFirstRequestModel, url);

  Future<LoginResponseModel> login(LoginRequestModel, url);

  //
  Future<SignUpFirstResponseModel> stdSignUpFirstStep(
      SignUpFirstRequestModel, url);

  //
  // Future<SignUpResponseModelSecond> stdSignUpSecondStep(
  //     SignUpRequestModelSecond, url);
  //
  Future<SignUpThirdResponseModel> stdSignUpThirdStep(SignUpRequestThird, url);

  Future<List<OrganizationTypeModel>> organizationType(url);

  Future<OrgSignUpFirstResponseModel> orgSignUpFirstStep(orgSignUpFirst, url);

  Future<orgSignUpSecondResponseModel> orgSignUpSecondStep(
      orgSignUpSecond, url);

  Future<orgSignUpThirdResponseModel> orgSignUpThirdStep(OrgSignUpThird, url);

  Future<EventNdAdsModel> getAllEventList(url);

  Future<EventDetailsModel> getEventDetails(url);

  Future<PostEventResponseModel> postEvents(PostEventRequestModel, url);

  Future<PostAdResponseModel> postAds(PostAdRequestModel, url);

  Future<FeedbackResponseModel> submitFeedback(FeedbackRequestModel, url);

  Future<GetFeedbackResponseModel> getFeedback(GetFeedbackRequestModel, url);

  Future<TypeOfProjectModel> getProjectTypeList(url);

  Future<TypeOfPeopleModel> getPeopleTypeList(url);

  Future<SProjectLevelModel> getLevelList(url);

  Future<SFieldTypeModel> getFieldList(url);

  Future<SAddProjectResponseModel> addSProject(SAddProjectRequestModel, url);

  Future<OAddProjectResponseModel> addOProject(OAddProjectRequestModel, url);

  Future<OnGoingProjectModel> getOnGoingProject(url);

  Future<AllMemberListModel> getMemberList(url);

  Future<AddMemberResponseModel> addMember(AddMemberRequestModel, url);

  Future<GetProjectDetailsModel> getProjectDetails(url);

  Future<MyNetworkModel> getMyNetworkList(url);

  Future<CloseAccountResponseModel> closeAccount(CloseAccountRequestModel, url);

  Future<LegelsModel> getLegals(url);

  Future<ChangeResponseModel> updateName(ChangeNameRequestModel, url);

  Future<ChangeResponseModel> updateEmail(ChangeEmailIdRequestModel, url);

  Future<ChangeResponseModel> updatePassword(ChangePasswordRequestModel, url);

  Future<FaqModel> getFAQList(url);

  Future<CityModel> getCityList(url);

  Future<StateModel> getStateList(url);

  Future<CountryModel> getCountryList(url);

  Future<PersonAboutMeResponseModel> updateAboutMe(
      PersonAboutMeRequestModel, url);

  Future<AddEducationResponseModel> addEducation(AddEducationRequestModel, url);

  Future<AddExperienceResponseModel> addExperience(
      AddExperienceRequestModel, url);

  Future<AddAccomplishmentResponseModel> addAccomplishment(
      AddAccomplishmentRequestModel, url);

  Future<AllEducationModel> getAllEducation(url);

  Future<AllAccomplishmentModel> getAllAccomplishment(url);

  Future<AllExperienceModel> getAllExperience(url);

  Future<GetEducationDetailModel> getEducationDetail(url);

  Future<GetExperienceDetailModel> getExperienceDetail(url);

  Future<GetAccomplishmentDetailModel> getAccomplishementDetail(url);

  Future<UpdateAccomplishmentResponseModel> updateAccomplishment(
      UpdateAccomplishmentModel, url);

  Future<UpdateExperienceResponseModel> updateExperience(
      UpdateExperienceModel, url);

  Future<UpdateEducationResponseModel> updateEducation(
      UpdateEducationModel, url);

  Future<PersonProfileDetailsModel> getPersonProfile(url);

  Future<GetPersonDetailsModel> getPersonDetails(url);

  Future<UpdatePersonDetailsResponseModel> updatePersonDetails(
      UpdatePersonDetailsModel, url);

  Future<ForgetPasswordResponseModel> forgetPassword(
      ForgetPasswordRequestModel, url);

  Future<UpdatePasswordResponseModel> updateNewPassword(
      UpdatePasswordRequestModel, url);

  Future<AddFounderResponseModel> addFounder(AddFounderRequestModel, url);

  Future<AllFoundersModel> getAllFoundersList(url);

  Future<UpdateOurWorkResponseModel> updateOurWork(
      UpdateOurWorkRequestModel, url);

  Future<FounderDetailsModel> getFounderDetails(url);

  Future<UpdateFounderDetailsResponseModel> updateFounderDetails(
      UpdateFounderDetailsRequestModel, url);

  Future<OrganizationProfileModel> getOrganizationProfile(url);

  Future<OrganizationChangeLogoResponseModel> orgChangeLogo(
      OrganizationChangeLogoRequestModel, url);

  Future<AllHackathonModel> getAllHackathon(url);

  Future<AddHackathonResponseModel> newAddHackathon(
      AddHackathonRequestModel, url);

  Future<GetHackathonDetailsModel> getHackathonDetails(url);

  Future<HackathonProblemStatementDetailsModel> getHackathonProblemDetails(url);

  Future<HackathonTeamDetailsModel> getHackathonTeamDetails(url);

  Future<HackathonTeamListModel> getHackathonTeamList(url);

  Future<MyHackathonListModel> getMyHackathons(url);

  Future<CreateTeamResponseModel> createTeam(CreateTeamRequestModel, url);

  Future<SubmitProjectResponseModel> submitProject(
      SubmitProjectRequestModel, url);

  Future<LeaveProjectResponseModel> leaveProject(LeaveProjectRequestModel, url);

  Future<MyProjectListModel> getMyProjectList(url);

  Future<MyProjectDetailsModel> getMyProjectDetails(url);

  Future<ApproveProjectResponseModel> approveProject(
      ApproveProjectRequestModel, url);

  Future<RejectProjectResponseModel> rejectProject(
      RejectProjectRequestModel, url);

  Future<CollegeModel> getCollegeList(url);

  Future<GenerateCertificateResponseModel> certificateGenerate(GenerateCertificateRequestModel,url);
}
