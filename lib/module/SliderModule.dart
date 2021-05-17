class SlidersModel {
  String title;
  String imagePath;
  String subTitle;

  SlidersModel({this.title, this.imagePath, this.subTitle});

  void setTitle(String mTitle) {
    title = mTitle;
  }

  void setImagePath(String mImagePath) {
    imagePath = mImagePath;
  }

  void setSubTitle(String mSubTitle) {
    subTitle = mSubTitle;
  }

  String getTitle() {
    return title;
  }

  String getImagePath() {
    return imagePath;
  }

  String getSubTitle() {
    return subTitle;
  }
}

List<SlidersModel> getSlidersModel() {
  List<SlidersModel> sliderModel = new List<SlidersModel>();

  // 1
  SlidersModel slidersModel = new SlidersModel();
  slidersModel
      .setTitle("Collaborate with peers & companies\n for project development");
  slidersModel.setImagePath('assets/introImages/Image1.png');
  slidersModel.setSubTitle("#TeamUpWithMe");
  sliderModel.add(slidersModel);

  // 2
  slidersModel = new SlidersModel();
  slidersModel.setTitle(
      "Solve Real-Life Industry Problems & \n get opportunities to work with them.");
  slidersModel.setImagePath('assets/introImages/Image2.png');
  slidersModel.setSubTitle('#Company&Student');
  sliderModel.add(slidersModel);

  // 3
  slidersModel = new SlidersModel();
  slidersModel.setTitle(
      "Get certifications for your projects\nand share your achievements.");
  slidersModel.setImagePath('assets/introImages/Image3.png');
  slidersModel.setSubTitle('#ProjectCertified');
  sliderModel.add(slidersModel);

  // 4
  slidersModel = new SlidersModel();
  slidersModel
      .setTitle("Take Part in hackathon, pitch sessions & \n attend events.");
  slidersModel.setImagePath('assets/introImages/Image4.png');
  slidersModel.setSubTitle('#Compete&Invest');
  sliderModel.add(slidersModel);

  return sliderModel;
}
