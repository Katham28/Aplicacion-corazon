import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart'; 
class MultiScreenPage_Medico extends StatefulWidget {
  @override
  PCrearCuentaMedico createState() => PCrearCuentaMedico();
}

class PCrearCuentaMedico extends State<MultiScreenPage_Medico> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  //Medico medico = Medico();
  final List<Widget> _screens = [
    PCrearCuentaMedico1 (),
    PCrearCuentaMedico2 (),
    PCrearCuentaMedico3 (),
    PCrearCuentaMedico4 (),
    PCrearCuentaMedico5 (),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear cuenta: Médico')),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Nombre'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Contacto'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Profesión'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Activación'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: 'Finalizar'),

        ],
      ),
    );
  }
}

class PCrearCuentaMedico1 extends StatelessWidget {
  const PCrearCuentaMedico1({super.key});

  @override
  Widget build(BuildContext context) {
    // Variables para manejar la fecha (usando StatefulBuilder para mantener el estado)
    DateTime? selectedBirthDate;
    final birthDateController = TextEditingController();

    // Función para mostrar el selector de fecha
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedBirthDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue, // Color del encabezado
                onPrimary: Colors.white, // Color del texto del encabezado
                onSurface: Colors.black, // Color del texto del calendario
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Color de los botones
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      
      if (picked != null && picked != selectedBirthDate) {
        selectedBirthDate = picked;
        birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      }
    }

    return Scaffold(
      body: Center(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/doc.jpg',
                  width: 50,
                  fit: BoxFit.cover,
                ),
                
                SizedBox(height: 10),
                
                Text('Nombre', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                            
                SizedBox(height: 10), // espacio entre botones
                // Campo de texto para el nombre
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nombre (s)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                       suffixIcon: Icon(Icons.person),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Campo de texto para el apellido
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Apellido (s)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                       suffixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
              SizedBox(height: 10),
                
                Text('Fecha de nacimiento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

                // Campo de fecha de nacimiento (nuevo)
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextFormField(
                    controller: birthDateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de nacimiento',
                      hintText: 'DD/MM/AAAA',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => selectDate(context),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => selectDate(context),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}


class PCrearCuentaMedico2 extends StatelessWidget {
  const PCrearCuentaMedico2({super.key});
 
  @override
  Widget build(BuildContext context) {

     final phoneController = TextEditingController();

    return Scaffold(
      
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             Image.asset(
                                 'assets/doc.jpg',
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                             
                              SizedBox(height: 10), // espacio entre botones
                              Text('Correo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                             
                              SizedBox(height: 10), // espacio entre botones
                              // Campo de texto para el usuario
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300), // Ancho máximo
                                      child: TextField(
                                             decoration: InputDecoration(
                                                 labelText: 'Correo electrónico',
                                                  hintText: 'correo@ejemplo.com',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                  suffixIcon: Icon(Icons.mail),
                                             ),
                                      ),
                              ),




                             SizedBox(height: 10),
                              
                              Text('Contraseña', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10), // espacio entre el campo y el siguiente


                              
                              // Campo de texto para la contraseña
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300),
                                      child: TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  labelText: 'Contraseña',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                  suffixIcon: Icon(Icons.lock),
                                            ),
                                      ),
                              ),

                              SizedBox(height: 10), // espacio entre el campo y el siguiente


                              // Campo de texto para la contraseña
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300),
                                      child: TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  labelText: 'Confirmar contraseña',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                   suffixIcon: Icon(Icons.lock),
                                            ),
                                      ),
                              ),

                              


                              SizedBox(height: 10),
                              
                              Text('Telefono', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              
                              SizedBox(height: 10), // espacio entre el campo y el siguiente
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Teléfono',
                                          hintText: '55 1234 5678',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                          suffixIcon: Icon(Icons.phone),
                                        ),
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Ingrese su teléfono';
                                          }
                                          final cleanPhone = value.replaceAll(' ', '');
                                          if (cleanPhone.length != 10) {
                                            return 'Deben ser 10 dígitos';
                                          }
                                          if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
                                            return 'Solo números permitidos';
                                          }
                                          return null;
                              },
                               ),
                              ),

                              SizedBox(height: 10), // espacio entre botones

                              
                            
          ],
        ),
      ),
    );
  }  
}

class PCrearCuentaMedico3 extends StatelessWidget {
  const PCrearCuentaMedico3({super.key});
 
  @override
  Widget build(BuildContext context) {
  int? _selectedYear;
  final TextEditingController _yearController = TextEditingController();
      
Future<void> _selectYear(BuildContext context) async {
  final DateTime? picked = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Seleccione el año"),
        content: SizedBox(
          width: 300,
          height: 300,
          child: YearPicker(
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            initialDate: DateTime(_selectedYear ?? DateTime.now().year - 18),
            selectedDate: DateTime(_selectedYear ?? DateTime.now().year - 18),
            onChanged: (DateTime dateTime) {
              Navigator.pop(context, dateTime);
            },
          ),
        ),
      );
    },
  );

  if (picked != null) {
    _selectedYear = picked.year;
    _yearController.text = _selectedYear.toString();
  } else {
    _yearController.text = '';
  }
}


    return Scaffold(
      
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             Image.asset(
                                 'assets/doc.jpg',
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                             
                              SizedBox(height: 9), // espacio entre botones

                              Text('Número de cédula profesional', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                             
                              SizedBox(height: 10), // espacio entre botones

                              //Numero de cédula
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Número de cédula',
                                          hintText: '',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                          suffixIcon: Icon(Icons.numbers),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          //LengthLimitingTextInputFormatter(10),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Ingrese su numero de cédula';
                                          }
                                          final cleanPhone = value.replaceAll(' ', '');
                                          //if (cleanPhone.length != 10) {
                                            //return 'Deben ser 10 dígitos';
                                          //}
                                          if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
                                            return 'Solo números permitidos';
                                          }
                                          return null;
                              },
                               ),
                              ),


                            //Institucion
                             SizedBox(height: 9), // espacio entre botones
                              Text('Institución', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                             
                              SizedBox(height: 10), // espacio entre botones
                              // Campo de texto para el usuario
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300), // Ancho máximo
                                      child: TextField(
                                             decoration: InputDecoration(
                                                 labelText: 'Institución',
                                                  hintText: '',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                  suffixIcon: Icon(Icons.school),
                                             ),
                                      ),
                              ),

                              //Tipo
                             SizedBox(height: 9), // espacio entre botones
                              Text('Tipo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                             
                              SizedBox(height: 10), // espacio entre botones
                              // Campo de texto para el usuario
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300), // Ancho máximo
                                      child: TextField(
                                             decoration: InputDecoration(
                                                 labelText: 'Tipo',
                                                  hintText: '',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                  suffixIcon: Icon(Icons.badge),
                                             ),
                                      ),
                              ),
                              


                              //Año
                                                            //Tipo
                             SizedBox(height: 9), // espacio entre botones
                              Text('Año', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                             
                              SizedBox(height: 10), // espacio entre botones
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300),
                                      child: TextFormField(
                                        controller: _yearController,
                                        decoration: InputDecoration(
                                          labelText: 'Año de nacimiento',
                                          hintText: 'AAAA',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.calendar_today),
                                            onPressed: () => _selectYear(context),
                                          ),
                                        ),
                                        readOnly: true,
                                        onTap: () => _selectYear(context),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Por favor seleccione el año';
                                          }
                                          final year = int.tryParse(value);
                                          if (year == null || year < 1900 || year > DateTime.now().year) {
                                            return 'Ingrese un año válido';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                            
          ],
        ),
      ),
    );
  }  
}
class PCrearCuentaMedico4 extends StatelessWidget {
  const PCrearCuentaMedico4({super.key});
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             Image.asset(
                                 'assets/doc.jpg',
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                             
                              //Codigo de activitacion
                              SizedBox(height: 10), // espacio entre botones
                              Text('Código de activación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),                             
                              SizedBox(height: 10), // espacio entre botones
                            
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Código de activación',
                                          hintText: 'XXXX-XXXX-XXXX',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                          suffixIcon: Icon(Icons.numbers),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(12),
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Ingrese su codigo de activación';
                                          }
                                          final cleanPhone = value.replaceAll(' ', '');
                                          if (cleanPhone.length != 12) {
                                            return 'Deben ser 12 dígitos';
                                          }
                                          if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
                                            return 'Solo números permitidos';
                                          }
                                          return null;
                              },
                               ),
                              ),

                             

                              
                            
          ],
        ),
      ),
    );
  }  
}

class PCrearCuentaMedico5 extends StatelessWidget {
  const PCrearCuentaMedico5({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
            body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             Image.asset(
                                'assets/doc.jpg',
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                             
                              SizedBox(height: 10), // espacio entre botones

                          ElevatedButton(
                              onPressed: () {
                                //Navigator.push(
                                //  context,
                                  //MaterialPageRoute(builder: (context) => PCrearCuenta()),
                                //);
                              },
                              child: Text('     Crear cuenta    '),
                            ),

                              SizedBox(height: 10), // espacio entre botones

                              
                            
          ],
        ),
      ),
    );
  }


}