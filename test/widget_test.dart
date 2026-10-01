import 'package:flutter_test/flutter_test.dart';
import 'package:catalogo_livros/main.dart';

void main() {
  testWidgets('Verifica renderizacao do estado vazio na tela inicial',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CatalogoApp());

    expect(find.text('Seu acervo está vazio'), findsOneWidget);
    expect(
      find.text('Toque no botão "+" abaixo para cadastrar seu primeiro livro.'),
      findsOneWidget,
    );
  });
}