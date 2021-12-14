import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kid_good_good/constants.dart';
import 'package:kid_good_good/kid/kid.dart';
import 'package:kid_good_good/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'kid_test.mocks.dart';

const _uuid = Uuid();

class MockFunction<T> extends Mock {
  T call(ProviderBase<T> provider);
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  addTearDown(container.dispose);
  return container;
}

@GenerateMocks([Kid, Box])
void main() {
  group('Kid', () {
    test('Add Points', () async {
      final mockBox = MockBox();

      final container = createContainer(
        overrides: [boxProvider.overrideWithValue(mockBox)],
      );
      final kidRepository = KidRepository(container.read);
      final kid = Kid(
        points: 0,
        pointHistory: [],
        registered: false,
        firstName: '',
        id: _uuid.v4(),
      );
      //var kidState = Kid(kid, container.read);

      expect(kid.points, 0);

      when(mockBox.get(KidsTypeId, defaultValue: anyNamed('defaultValue')))
          .thenReturn(Kids(kids: [kid]));
      kidRepository.addPoints(id: kid.id, points: 10);
      expect(kidRepository.getKid(kid.id).points, 10);
    });
  });
}
