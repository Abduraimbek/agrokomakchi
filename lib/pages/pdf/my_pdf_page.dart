import 'package:agrokomakchi/providers/providers.dart';
import 'package:agrokomakchi/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class MyPdfPage extends ConsumerStatefulWidget {
  const MyPdfPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MyPdfPageState();
}

class _MyPdfPageState extends ConsumerState<MyPdfPage> {
  late final InnerModel model;

  @override
  void initState() {
    super.initState();

    model = ref.read(innerProvider).model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
      ),
      body: PdfPreview(
        build: (_) async {
          final ByteData bytes = await rootBundle.load(model.pdfPath);
          final Uint8List list = bytes.buffer.asUint8List();

          return list;
        },
        useActions: false,
      ),
    );
  }
}
