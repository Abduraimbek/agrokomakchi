import 'package:equatable/equatable.dart';

enum InnerEnum { disease, pest }

class InnerModel extends Equatable {
  final String title;
  final InnerEnum innerEnum;
  final String imagePath;
  final String pdfPath;

  const InnerModel({
    required this.title,
    required this.innerEnum,
    required this.imagePath,
    required this.pdfPath,
  });

  @override
  List<Object> get props {
    return [title, innerEnum, imagePath, pdfPath];
  }

  static const list = [
    InnerModel(
      title: "ДОНЛИ ЭКИН КАСАЛЛИКЛАРИ",
      innerEnum: InnerEnum.disease,
      imagePath: "assets/images/donli ekin kasalliklari.jpeg",
      pdfPath: "assets/pdf/DONLI EKIN KAS.doc.pdf",
    ),
    InnerModel(
      title: "ҒЎЗА КАСАЛЛИКЛАРИ",
      innerEnum: InnerEnum.disease,
      imagePath: "assets/images/goza kasalliklari.jpeg",
      pdfPath: "assets/pdf/GOZANING KAS.doc.pdf",
    ),
    InnerModel(
      title: "МЕВА КАСАЛЛИКЛАРИ",
      innerEnum: InnerEnum.disease,
      imagePath: "assets/images/meva kasalliklari.jpeg",
      pdfPath: "assets/pdf/MEVA KAS.doc.pdf",
    ),
    InnerModel(
      title: "САБЗАВОТ КАСАЛЛИКЛАРИ",
      innerEnum: InnerEnum.disease,
      imagePath: "assets/images/sabzavot kasalliklari.jpeg",
      pdfPath: "assets/pdf/SABZAVOT KARTOWKA KAS.doc.pdf",
    ),
    InnerModel(
      title: "ТОК КАСАЛЛИКЛАРИ",
      innerEnum: InnerEnum.disease,
      imagePath: "assets/images/tok kasalliklari.jpeg",
      pdfPath: "assets/pdf/tok kas.docx.pdf",
    ),
    InnerModel(
      title: "ДОНЛИ ЭКИН ЗАРАРКУНАНДАЛАРИ",
      innerEnum: InnerEnum.pest,
      imagePath: "assets/images/donli ekin zararkunandalari.jpeg",
      pdfPath: "assets/pdf/DONLI EKIN ZAR.doc.pdf",
    ),
    InnerModel(
      title: "ҒЎЗА ЗАРАРКУНАНДАЛАРИ",
      innerEnum: InnerEnum.pest,
      imagePath: "assets/images/goza zararkunandalari.jpeg",
      pdfPath: "assets/pdf/GOZANING ZAR.doc.pdf",
    ),
    InnerModel(
      title: "МEВА ЗАРАРКУНАНДАЛАРИ",
      innerEnum: InnerEnum.pest,
      imagePath: "assets/images/meva zararkunandalari.jpeg",
      pdfPath: "assets/pdf/MEVA ZAR.doc.pdf",
    ),
    InnerModel(
      title: "САБЗАВОТ ЗАРАРКУНАНДАЛАРИ",
      innerEnum: InnerEnum.pest,
      imagePath: "assets/images/savzavot zararkunandalari.jpeg",
      pdfPath: "assets/pdf/SABZAVOT KARTOWKA ZAR.doc.pdf",
    ),
    InnerModel(
      title: "ТОК ЗАРАРКУНАНДАЛАРИ",
      innerEnum: InnerEnum.pest,
      imagePath: "assets/images/tok zararkunandalari.jpeg",
      pdfPath: "assets/pdf/tok zar.docx.pdf",
    ),
  ];
}
