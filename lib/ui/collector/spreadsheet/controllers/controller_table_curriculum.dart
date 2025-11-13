

import 'package:parry_front/core/lattes_entitys/curriculum.dart';

class ControllerTableCurriculum {
  int id_lattes = 0;
  String last_update = '';

  ControllerTableCurriculum([Curriculum? c]) {
    if(c == null) {
      return;
    }

    curriculum = c;
  }

  set curriculum(Curriculum c) {
    id_lattes = c.attributes['id_lattes'];
    last_update = c.attributes['ultima_atualizacao'];
  }
}