import 'package:intl/date_symbol_data_file.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/model/course_repository.dart';
import 'package:intl/intl.dart';

class CourseController {
  CourseRepository repository = CourseRepository();

  getLettersToAvatar(name) {
    String initials = name.split(' ').map((word) => word[0]).join('');
    return initials.substring(0, 2);
  }

  Future<List<CourseEntity>> getCourseList() async {
    List<CourseEntity> coursesList = [];
    coursesList = await repository.getAll();
    return coursesList;
  }

  deleteCourse(String id) async {
    try {
      await repository.deleteCourse(id);
    } catch (e) {
      rethrow;
    }
  }

  postNewCourse(CourseEntity courseEntity) async {
    try {
      await repository.postNewCourse(courseEntity);
    } catch (e) {
      rethrow;
    }
  }

  updateAluno(CourseEntity courseEntity) async {
    try {
      await repository.putUpdateCourse(courseEntity);
    } catch (e) {
      rethrow;
    }
  }

  //intl: ^0.18.1 on pubspec.yml
  //converte um dateTime da api para o formato ptBR
  dateTimeToDateBR(date) {
    //da api para tela
    var inputDate = DateTime.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  //converte uma data ptBR dd/MM/yyyy de tela para
  //formato da API mockapi.com que é yyyy-MM-ddTHH:mm:ssZ
  dateBRToDateApi(ptBrDate) {
    //da tela para api
    final ptBrDateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');
    final parsedDate = ptBrDateFormat.parse(ptBrDate);

    final utcDateTime = DateTime.utc(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    final formattedDateTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(utcDateTime);
    return formattedDateTime;
  }
}
