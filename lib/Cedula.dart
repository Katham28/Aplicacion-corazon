import 'dart:typed_data'; // Para Int32List
import 'package:intl/intl.dart'; // Para formateo de fechas// Para formateo de fechas

class Cedula {
  // Variables privadas
  String _institucion;
  String _numero;
  String _profesion;
  String _tipo;
  int _yearExpedicion; 

  // Constructor con parámetros requeridos
  Cedula({
    required String institucion,
    required String numero,
    required String profesion,
    required String tipo,
    required int yearExpedicion,
  })  : _institucion = institucion,
        _numero = numero,
        _profesion = profesion,
        _tipo = tipo,
        _yearExpedicion = yearExpedicion;

  // Getters y setters para institucion
  String get institucion => _institucion;
  set institucion(String value) {
    _institucion = value;
  }

  // Getters y setters para numero
  String get numero => _numero;
  set numero(String value) {
    _numero = value;
  }

  // Getters y setters para profesion
  String get profesion => _profesion;
  set profesion(String value) {
    _profesion = value;
  }

  // Getters y setters para tipo
  String get tipo => _tipo;
  set tipo(String value) {
    _tipo = value;
  }

  // Getters y setters para yearExpedicion
  int get yearExpedicion => _yearExpedicion;
  set yearExpedicion(int value) {
    _yearExpedicion = value;
  }

  // Método toString para representación en cadena
  @override
  String toString() {
    return 'Cédula: $_numero ($_tipo)\n'
           'Profesión: $_profesion\n'
           'Institución: $_institucion\n'
           'Expedición: $_yearExpedicion\n';
  }

}

class Medico {
  // Propiedades
  String _nombre;
  String _apellidoPat;
  String _apellidoMat;
  String _correo;
  int _edad;
  DateTime _fechaNacimiento;
  String _contrasena;
  int _telefono;
  final List <Cedula> _listaCedulas = [];
  final List<Paciente> _listaPacientes = [];

  // Constructor principal
  Medico({
    required String nombre,
    required String apellidoPat,
    required String apellidoMat,
    required String correo,
    required int edad,
    required DateTime fechaNacimiento,
    required String contrasena,
    required int telefono,
    List<Cedula>? cedulas,
    List<Paciente>? pacientes,
  })  : _nombre = nombre,
        _apellidoPat = apellidoPat,
        _apellidoMat = apellidoMat,
        _correo = correo,
        _edad = edad,
        _fechaNacimiento = fechaNacimiento,
        _contrasena = contrasena,
        _telefono = telefono {
    if (cedulas != null) {
      _listaCedulas.addAll(cedulas);
    }
    if (pacientes != null) {
      _listaPacientes.addAll(pacientes);
    }
  }

  

  // Getters y setters con validaciones
  String get nombre => _nombre;
  set nombre(String value) {
    _nombre = value;
  }

  String get apellidoPat => _apellidoPat;
  set apellidoPat(String value) {
    _apellidoPat = value;
  }

  String get apellidoMat => _apellidoMat;
  set apellidoMat(String value) {
     _apellidoMat = value; 
  }
  String get correo => _correo;
  set correo(String value) {
    _correo = value;
  }

  int get edad => _edad;
  set edad(int value) {
    _edad = value;
  }

  DateTime get fechaNacimiento => _fechaNacimiento;
  set fechaNacimiento(DateTime value) {
    if (value.isAfter(DateTime.now())) throw ArgumentError('Fecha de nacimiento no puede ser futura');
    _fechaNacimiento = value;
    _edad = DateTime.now().year - value.year;
  }

  String get contrasena => _contrasena;
  set contrasena(String value) {
    _contrasena = value;
  }

  int get telefono => _telefono;
  set telefono(int value) {
    if (value.toString().length != 10) throw ArgumentError('Teléfono debe tener 10 dígitos');
    _telefono = value;
  }

 

  // Método para nombre completo
  String get nombreCompleto => '$_nombre $_apellidoPat $_apellidoMat'.trim();

  // Método para edad exacta
  int get edadExacta {
    final ahora = DateTime.now();
    int edad = ahora.year - _fechaNacimiento.year;
    if (ahora.month < _fechaNacimiento.month ||
        (ahora.month == _fechaNacimiento.month && ahora.day < _fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

   // Métodos para manejar cédulas
  void agregarCedula(Cedula cedula) => _listaCedulas.add(cedula);
  void removerCedula(Cedula cedula) => _listaCedulas.remove(cedula);
  List<Cedula> get cedulas => _listaCedulas;

  // Métodos para manejar pacientes
  void agregarPaciente(Paciente paciente) => _listaPacientes.add(paciente);
  void removerPaciente(Paciente paciente) => _listaPacientes.remove(paciente);
  List<Paciente> get pacientes => _listaPacientes;

  // Método toString
  @override
  String toString() {
    return 'Médico: $nombreCompleto\n'
           'Edad: $edadExacta años\n'
           'Correo: $_correo\n'
           'Teléfono: $_telefono\n'
           'Cédulas: ${_listaCedulas.length}\n'
           'Pacientes: ${_listaPacientes.length}';
  }
}

class Paciente {
  // Propiedades privadas
  String _nombre;
  String _apellidoPat;
  String _apellidoMat;
  String _correo;
  int _edad;
  DateTime _fechaNacimiento;
  String _contrasena;
  int _telefono;
  final List<Registro> _historialRegistros;

  // Constructor
  Paciente({
    required String nombre,
    required String apellidoPat,
    String apellidoMat = '',
    required String correo,
    required int edad,
    required DateTime fechaNacimiento,
    required String contrasena,
    required int telefono,
    List<Registro>? historialRegistros,
  })  : _nombre = nombre,
        _apellidoPat = apellidoPat,
        _apellidoMat = apellidoMat,
        _correo = correo,
        _edad = edad,
        _fechaNacimiento = fechaNacimiento,
        _contrasena = contrasena,
        _telefono = telefono,
        _historialRegistros = historialRegistros ?? [] {
    // Validar consistencia entre edad y fecha de nacimiento
    final edadCalculada = _calcularEdad(fechaNacimiento);
    if (edad != edadCalculada) {
      throw ArgumentError('La edad no coincide con la fecha de nacimiento');
    }
  }

  // Getters y setters con validaciones
  String get nombre => _nombre;
  set nombre(String value) {
    _nombre = value;
  }

  String get apellidoPat => _apellidoPat;
  set apellidoPat(String value) {
    _apellidoPat = value;
  }

  String get apellidoMat => _apellidoMat;
  set apellidoMat(String value){
  _apellidoMat = value;
  }

  String get correo => _correo;
  set correo(String value) {
    _correo = value;
  }

  int get edad => _edad;
  set edad(int value) {
    _edad = value;
  }

  DateTime get fechaNacimiento => _fechaNacimiento;
  set fechaNacimiento(DateTime value) {
    if (value.isAfter(DateTime.now())) throw ArgumentError('Fecha de nacimiento no puede ser futura');
    _fechaNacimiento = value;
    _edad = _calcularEdad(value);
  }

  String get contrasena => _contrasena;
  set contrasena(String value) {
    _contrasena = value;
  }

  int get telefono => _telefono;
  set telefono(int value) {
    _telefono = value;
  }

  // Métodos para el historial de registros
  List<Registro> get historialRegistros => List.unmodifiable(_historialRegistros);
  void agregarRegistro(Registro registro) => _historialRegistros.add(registro);
  bool removerRegistro(Registro registro) => _historialRegistros.remove(registro);

  // Métodos auxiliares
  String get nombreCompleto => '$_nombre $_apellidoPat $_apellidoMat'.trim();

  int _calcularEdad(DateTime fechaNacimiento) {
    final ahora = DateTime.now();
    int edad = ahora.year - fechaNacimiento.year;
    if (ahora.month < fechaNacimiento.month ||
        (ahora.month == fechaNacimiento.month && ahora.day < fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

  @override
  String toString() {
    return 'Paciente: $nombreCompleto\n'
           'Edad: $_edad años\n'
           'Contacto: $_correo / $_telefono\n'
           'Registros médicos: ${_historialRegistros.length}';
  }
}


class Registro {
  // Matrices privadas para datos biomédicos
  final Int32List _auxRaw;
  final Int32List _auxTime;
  final Int32List _bmpRaw;
  final Int32List _bmpTime;
  final Int32List _egcRaw;
  final Int32List _egcTime;
  final Int32List _ppgRaw;
  final Int32List _ppgTime;
  final DateTime _fechaHora;

  // Constructor principal
  Registro({
    required int tamMuestras,
    required DateTime fechaHora,
  }) : _auxRaw = Int32List(tamMuestras),
       _auxTime = Int32List(tamMuestras),
       _bmpRaw = Int32List(tamMuestras),
       _bmpTime = Int32List(tamMuestras),
       _egcRaw = Int32List(tamMuestras),
       _egcTime = Int32List(tamMuestras),
       _ppgRaw = Int32List(tamMuestras),
       _ppgTime = Int32List(tamMuestras),
       _fechaHora = fechaHora;

  // Métodos para agregar datos (versión segura)
  void agregarDatosAux(int indice, int valor, int tiempo) {
    _validarIndice(indice);
    _auxRaw[indice] = valor;
    _auxTime[indice] = tiempo;
  }

  void agregarDatosBmp(int indice, int valor, int tiempo) {
    _validarIndice(indice);
    _bmpRaw[indice] = valor;
    _bmpTime[indice] = tiempo;
  }

  void agregarDatosEgc(int indice, int valor, int tiempo) {
    _validarIndice(indice);
    _egcRaw[indice] = valor;
    _egcTime[indice] = tiempo;
  }

  void agregarDatosPpg(int indice, int valor, int tiempo) {
    _validarIndice(indice);
    _ppgRaw[indice] = valor;
    _ppgTime[indice] = tiempo;
  }

  // Validación de índice
  void _validarIndice(int indice) {
    if (indice < 0 || indice >= _auxRaw.length) {
      throw RangeError('Índice $indice fuera de rango (0-${_auxRaw.length - 1})');
    }
  }

  // Getters para vistas inmutables
  Int32List get auxRaw => Int32List.fromList(_auxRaw);
  Int32List get auxTime => Int32List.fromList(_auxTime);
  Int32List get bmpRaw => Int32List.fromList(_bmpRaw);
  Int32List get bmpTime => Int32List.fromList(_bmpTime);
  Int32List get egcRaw => Int32List.fromList(_egcRaw);
  Int32List get egcTime => Int32List.fromList(_egcTime);
  Int32List get ppgRaw => Int32List.fromList(_ppgRaw);
  Int32List get ppgTime => Int32List.fromList(_ppgTime);
  DateTime get fechaHora => _fechaHora;



  
  @override
 @override
  String toString() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    return 'Registro Biomédico - ${formatter.format(_fechaHora)} ';
  }
}